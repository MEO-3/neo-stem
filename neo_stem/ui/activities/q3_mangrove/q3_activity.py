from ..activity_base import ActivityBaseWidget
from .step1_phenomenon import Step1Phenomenon
from .step2_dqb import Step2DQB
from .step3_investigation import Step3Investigation
from .step4_model import Step4Model
from .step5_challenge import Step5Challenge


class Q3Mangrove(ActivityBaseWidget):
    def __init__(self, parent=None):
        steps = [
            lambda qid, idx: Step1Phenomenon(qid, idx),
            lambda qid, idx: Step2DQB(qid, idx),
            lambda qid, idx: Step3Investigation(qid, idx),
            lambda qid, idx: Step4Model(qid, idx),
            lambda qid, idx: Step5Challenge(qid, idx),
        ]
        super().__init__(question_id=3, title="Rừng ngập mặn", step_factories=steps, parent=parent)
