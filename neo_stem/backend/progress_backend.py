"""Python QObject bridge for ProgressTracker — exposes the same API the QML files call."""

import sqlite3
from datetime import datetime, timezone
from pathlib import Path
from typing import Optional

from PyQt6.QtCore import QObject, QStandardPaths, pyqtSlot, QVariant


class ProgressTracker(QObject):
    def __init__(self, parent: Optional[QObject] = None) -> None:
        super().__init__(parent)
        self._conn: Optional[sqlite3.Connection] = None

    def _ensure_db(self) -> None:
        if self._conn is not None:
            return
        data_path = QStandardPaths.writableLocation(
            QStandardPaths.StandardLocation.AppDataLocation
        )
        Path(data_path).mkdir(parents=True, exist_ok=True)
        db_path = Path(data_path) / "neostem.db"
        self._conn = sqlite3.connect(str(db_path))
        self._conn.execute(
            "CREATE TABLE IF NOT EXISTS progress ("
            "  question_id INTEGER NOT NULL,"
            "  step_id INTEGER NOT NULL,"
            "  stars INTEGER DEFAULT 0,"
            "  completed INTEGER DEFAULT 0,"
            "  data TEXT,"
            "  PRIMARY KEY (question_id, step_id)"
            ")"
        )
        self._conn.execute(
            "CREATE TABLE IF NOT EXISTS badges ("
            "  badge_id TEXT PRIMARY KEY,"
            "  unlocked INTEGER DEFAULT 0,"
            "  unlock_date TEXT"
            ")"
        )
        self._conn.execute(
            "CREATE TABLE IF NOT EXISTS dqb_state ("
            "  question_id INTEGER NOT NULL,"
            "  note_id INTEGER NOT NULL,"
            "  text TEXT,"
            "  answered INTEGER DEFAULT 0,"
            "  PRIMARY KEY (question_id, note_id)"
            ")"
        )
        self._conn.commit()

    # --- Progress ---

    @pyqtSlot(int, int, int, str)
    @pyqtSlot(int, int, int)
    def saveStepProgress(self, questionId: int, stepId: int, stars: int, data: str = "") -> None:
        self._ensure_db()
        assert self._conn is not None
        self._conn.execute(
            "INSERT INTO progress (question_id, step_id, stars, completed, data) "
            "VALUES (?, ?, ?, 1, ?) "
            "ON CONFLICT(question_id, step_id) DO UPDATE SET "
            "stars = MAX(stars, excluded.stars), completed = 1, "
            "data = CASE WHEN excluded.data != '' THEN excluded.data ELSE data END",
            (questionId, stepId, stars, data),
        )
        self._conn.commit()

    @pyqtSlot(int, int, result=QVariant)
    def getStepProgress(self, questionId: int, stepId: int) -> Optional[dict]:
        self._ensure_db()
        assert self._conn is not None
        cur = self._conn.execute(
            "SELECT stars, completed, data FROM progress WHERE question_id = ? AND step_id = ?",
            (questionId, stepId),
        )
        row = cur.fetchone()
        if not row:
            return None
        return {"stars": row[0], "completed": bool(row[1]), "data": row[2] or ""}

    @pyqtSlot(int, result=QVariant)
    def getQuestionProgress(self, questionId: int) -> list:
        self._ensure_db()
        assert self._conn is not None
        cur = self._conn.execute(
            "SELECT step_id, stars, completed FROM progress WHERE question_id = ? ORDER BY step_id",
            (questionId,),
        )
        results = []
        for row in cur.fetchall():
            results.append({"stepId": row[0], "stars": row[1], "completed": bool(row[2])})
        return results

    @pyqtSlot(result=int)
    def getTotalStars(self) -> int:
        self._ensure_db()
        assert self._conn is not None
        cur = self._conn.execute("SELECT COALESCE(SUM(stars), 0) FROM progress")
        row = cur.fetchone()
        return int(row[0]) if row else 0

    @pyqtSlot(int, result=int)
    def getQuestionStars(self, questionId: int) -> int:
        self._ensure_db()
        assert self._conn is not None
        cur = self._conn.execute(
            "SELECT COALESCE(SUM(stars), 0) FROM progress WHERE question_id = ?",
            (questionId,),
        )
        row = cur.fetchone()
        return int(row[0]) if row else 0

    @pyqtSlot(int, result=bool)
    def isQuestionComplete(self, questionId: int) -> bool:
        self._ensure_db()
        assert self._conn is not None
        cur = self._conn.execute(
            "SELECT COUNT(*) FROM progress WHERE question_id = ? AND completed = 1",
            (questionId,),
        )
        row = cur.fetchone()
        return row[0] >= 5 if row else False

    # --- DQB Notes ---

    @pyqtSlot(int, int, str, bool)
    def saveDQBNote(self, questionId: int, noteId: int, text: str, answered: bool) -> None:
        self._ensure_db()
        assert self._conn is not None
        self._conn.execute(
            "INSERT OR REPLACE INTO dqb_state (question_id, note_id, text, answered) VALUES (?, ?, ?, ?)",
            (questionId, noteId, text, 1 if answered else 0),
        )
        self._conn.commit()

    @pyqtSlot(int, result=QVariant)
    def getDQBNotes(self, questionId: int) -> list:
        self._ensure_db()
        assert self._conn is not None
        cur = self._conn.execute(
            "SELECT text, answered FROM dqb_state WHERE question_id = ? ORDER BY note_id",
            (questionId,),
        )
        notes = []
        for row in cur.fetchall():
            notes.append({"text": row[0], "answered": bool(row[1])})
        return notes

    # --- Badges ---

    @pyqtSlot(str)
    def unlockBadge(self, badgeId: str) -> None:
        self._ensure_db()
        assert self._conn is not None
        self._conn.execute(
            "INSERT OR REPLACE INTO badges (badge_id, unlocked, unlock_date) VALUES (?, 1, ?)",
            (badgeId, datetime.now(timezone.utc).isoformat()),
        )
        self._conn.commit()

    @pyqtSlot(str, result=bool)
    def isBadgeUnlocked(self, badgeId: str) -> bool:
        self._ensure_db()
        assert self._conn is not None
        cur = self._conn.execute(
            "SELECT unlocked FROM badges WHERE badge_id = ?", (badgeId,)
        )
        row = cur.fetchone()
        return bool(row[0]) if row else False

    @pyqtSlot(result=QVariant)
    def getUnlockedBadges(self) -> list:
        self._ensure_db()
        assert self._conn is not None
        cur = self._conn.execute(
            "SELECT badge_id, unlock_date FROM badges WHERE unlocked = 1 ORDER BY unlock_date"
        )
        badges = []
        for row in cur.fetchall():
            badges.append({"id": row[0], "unlockDate": row[1]})
        return badges

    @pyqtSlot(result=int)
    def getUnlockedBadgeCount(self) -> int:
        self._ensure_db()
        assert self._conn is not None
        cur = self._conn.execute("SELECT COUNT(*) FROM badges WHERE unlocked = 1")
        row = cur.fetchone()
        return int(row[0]) if row else 0

    # --- Reset ---

    @pyqtSlot()
    def resetAll(self) -> None:
        self._ensure_db()
        assert self._conn is not None
        self._conn.execute("DELETE FROM progress")
        self._conn.execute("DELETE FROM badges")
        self._conn.execute("DELETE FROM dqb_state")
        self._conn.commit()
