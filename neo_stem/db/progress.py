import sqlite3
from pathlib import Path
from typing import Optional

from PyQt5 import QtCore


class ProgressTracker:
    def __init__(self) -> None:
        self._db_path: Optional[Path] = None
        self._conn: Optional[sqlite3.Connection] = None

    def _ensure_db(self) -> None:
        if self._conn is not None:
            return

        data_path = QtCore.QStandardPaths.writableLocation(QtCore.QStandardPaths.AppDataLocation)
        Path(data_path).mkdir(parents=True, exist_ok=True)
        self._db_path = Path(data_path) / "neostem.db"
        self._conn = sqlite3.connect(self._db_path)
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

    def save_step_progress(self, question_id: int, step_id: int, stars: int) -> None:
        self._ensure_db()
        assert self._conn is not None
        self._conn.execute(
            "INSERT INTO progress (question_id, step_id, stars, completed) "
            "VALUES (?, ?, ?, 1) "
            "ON CONFLICT(question_id, step_id) DO UPDATE SET "
            "stars = MAX(stars, excluded.stars), completed = 1",
            (question_id, step_id, stars),
        )
        self._conn.commit()

    def get_step_progress(self, question_id: int, step_id: int) -> Optional[dict]:
        self._ensure_db()
        assert self._conn is not None
        cursor = self._conn.execute(
            "SELECT stars, completed FROM progress WHERE question_id = ? AND step_id = ?",
            (question_id, step_id),
        )
        row = cursor.fetchone()
        if not row:
            return None
        return {"stars": row[0], "completed": row[1]}

    def get_total_stars(self) -> int:
        self._ensure_db()
        assert self._conn is not None
        cursor = self._conn.execute("SELECT COALESCE(SUM(stars), 0) FROM progress")
        row = cursor.fetchone()
        return int(row[0]) if row else 0


progress_tracker = ProgressTracker()
