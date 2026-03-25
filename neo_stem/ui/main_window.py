from PyQt5 import QtCore, QtWidgets

from .view_stack import ViewStack
from .views.profile_view import ProfileView
from .views.question_selector import QuestionSelectorView
from .views.settings_view import SettingsView
from .views.splash_view import SplashView
from .views.step_selector import StepSelectorView
from .activities.registry import create_activity


class MainWindow(QtWidgets.QMainWindow):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle("NEO STEM")
        self.resize(1024, 768)

        self._stack = ViewStack()
        self.setCentralWidget(self._stack)

        self._init_views()

    def _init_views(self) -> None:
        splash = SplashView()
        splash.start_requested.connect(self._open_question_selector)
        splash.profile_requested.connect(self._open_profile)
        splash.settings_requested.connect(self._open_settings)
        self._stack.push(splash)

    def _open_question_selector(self) -> None:
        view = QuestionSelectorView()
        view.back_requested.connect(self._stack.pop)
        view.question_selected.connect(self._open_step_selector)
        self._stack.push(view)

    def _open_step_selector(self, question_id: int) -> None:
        view = StepSelectorView(question_id=question_id)
        view.back_requested.connect(self._stack.pop)
        view.step_selected.connect(self._on_step_selected)
        self._stack.push(view)

    def _open_profile(self) -> None:
        view = ProfileView()
        view.back_requested.connect(self._stack.pop)
        self._stack.push(view)

    def _open_settings(self) -> None:
        view = SettingsView()
        view.back_requested.connect(self._stack.pop)
        self._stack.push(view)

    def _on_step_selected(self, question_id: int, step_id: int) -> None:
        activity = create_activity(question_id)
        if activity is None:
            QtWidgets.QMessageBox.information(
                self,
                "Activity",
                "Hoat dong dang duoc phat trien.",
            )
            return

        activity.back_requested.connect(self._stack.pop)
        if hasattr(activity, "start_at"):
            activity.start_at(step_id)
        self._stack.push(activity)
