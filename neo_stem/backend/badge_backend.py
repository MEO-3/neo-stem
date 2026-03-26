"""Python QObject bridge for BadgeSystem — evaluates badge criteria and delegates to ProgressTracker."""

from typing import Optional

from PyQt6.QtCore import QObject, pyqtSignal, pyqtSlot, QVariant


BADGE_ICONS = {
    "first_step": "\U0001f463",
    "explorer": "\U0001f52d",
    "question_master": "\u2753",
    "young_scientist": "\U0001f52c",
    "architect": "\U0001f3d7",
    "challenger": "\U0001f3c6",
    "master_q1": "\U0001f35a",
    "master_q2": "\U0001f32b",
    "master_q3": "\U0001f333",
    "master_q4": "\U0001f9ca",
    "master_q5": "\U0001f9c2",
    "perfect": "\U0001f48e",
    "speed_demon": "\u26a1",
    "self_reliant": "\U0001f985",
    "adventurer": "\U0001f9ed",
}


class BadgeSystem(QObject):
    badgeUnlocked = pyqtSignal(str, str, arguments=["badgeId", "badgeName"])

    def __init__(self, progress_tracker: QObject, parent: Optional[QObject] = None) -> None:
        super().__init__(parent)
        self._tracker = progress_tracker

    @pyqtSlot(int, int, int, result=QVariant)
    def checkBadges(self, questionId: int, stepId: int, stars: int) -> list:
        new_badges: list[str] = []

        # "Buoc dau tien" — complete any step
        if not self._tracker.isBadgeUnlocked("first_step"):
            self._tracker.unlockBadge("first_step")
            new_badges.append("first_step")

        # Step-type badges
        step_badges = {
            0: "explorer",
            1: "question_master",
            2: "young_scientist",
            3: "architect",
            4: "challenger",
        }
        badge_id = step_badges.get(stepId)
        if badge_id and not self._tracker.isBadgeUnlocked(badge_id):
            self._tracker.unlockBadge(badge_id)
            new_badges.append(badge_id)

        # Question master badges
        if self._tracker.isQuestionComplete(questionId):
            master_badge = f"master_q{questionId}"
            if not self._tracker.isBadgeUnlocked(master_badge):
                self._tracker.unlockBadge(master_badge)
                new_badges.append(master_badge)

        # "Hoan hao" — 300 stars total
        if self._tracker.getTotalStars() >= 300 and not self._tracker.isBadgeUnlocked("perfect"):
            self._tracker.unlockBadge("perfect")
            new_badges.append("perfect")

        # "Tu luc canh sinh" — complete any question with 3 stars on all steps
        if self._tracker.isQuestionComplete(questionId):
            progress = self._tracker.getQuestionProgress(questionId)
            all_three = all(p["stars"] >= 3 for p in progress) if len(progress) >= 5 else False
            if all_three and not self._tracker.isBadgeUnlocked("self_reliant"):
                self._tracker.unlockBadge("self_reliant")
                new_badges.append("self_reliant")

        # "Tri tue tham do" — complete all 20 phenomenon steps
        all_phenomenons = True
        for q in range(1, 21):
            p = self._tracker.getStepProgress(q, 0)
            if not p or not p.get("completed"):
                all_phenomenons = False
                break
        if all_phenomenons and not self._tracker.isBadgeUnlocked("adventurer"):
            self._tracker.unlockBadge("adventurer")
            new_badges.append("adventurer")

        # Emit signals
        for bid in new_badges:
            self.badgeUnlocked.emit(bid, bid)

        return new_badges

    @pyqtSlot(str, result=bool)
    def isBadgeUnlocked(self, badgeId: str) -> bool:
        return self._tracker.isBadgeUnlocked(badgeId)

    @pyqtSlot(result=QVariant)
    def getUnlockedBadges(self) -> list:
        return self._tracker.getUnlockedBadges()

    @pyqtSlot(result=int)
    def getUnlockedCount(self) -> int:
        return self._tracker.getUnlockedBadgeCount()

    @pyqtSlot(str, result=str)
    def getBadgeIcon(self, badgeId: str) -> str:
        return BADGE_ICONS.get(badgeId, "\U0001f3c5")
