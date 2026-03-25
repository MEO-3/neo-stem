from typing import Callable, List

from PyQt5 import QtCore, QtWidgets

from ..widgets.neo_bar import NeoBar
from ..widgets.neo_bonus import NeoBonus
from ...db import progress_tracker

StepFactory = Callable[[int, int], QtWidgets.QWidget]


class ActivityBaseWidget(QtWidgets.QWidget):
    back_requested = QtCore.pyqtSignal()

    def __init__(self, question_id: int, title: str, step_factories: List[StepFactory], parent=None):
        super().__init__(parent)
        self._question_id = question_id
        self._title = title
        self._step_factories = step_factories
        self._step_widgets: List[QtWidgets.QWidget] = []
        self._step_stars = [0 for _ in range(len(step_factories))]
        self._current_step = 0

        self._bar = NeoBar(title)
        self._bar.back_clicked.connect(self._on_back)
        self._bar.home_clicked.connect(self.back_requested.emit)
        self._bar.set_step(1, len(step_factories))

        self._stack = QtWidgets.QStackedWidget()

        self._bonus = NeoBonus(self)
        self._bonus.dismissed.connect(self._advance_step)
        self._final_bonus = NeoBonus(self)
        self._final_bonus.dismissed.connect(self.back_requested.emit)

        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(0, 0, 0, 0)
        layout.addWidget(self._bar)
        layout.addWidget(self._stack, 1)

        self._build_steps()
        self._load_progress()

    def _build_steps(self) -> None:
        for idx, factory in enumerate(self._step_factories):
            widget = factory(self._question_id, idx)
            if hasattr(widget, "step_completed"):
                widget.step_completed.connect(self._on_step_done)
            self._stack.addWidget(widget)
            self._step_widgets.append(widget)
        self.go_to_step(0)

    def go_to_step(self, step_index: int) -> None:
        if step_index < 0 or step_index >= len(self._step_widgets):
            return
        self._current_step = step_index
        self._stack.setCurrentIndex(step_index)
        self._bar.set_step(step_index + 1, len(self._step_widgets))

    def start_at(self, step_index: int) -> None:
        self.go_to_step(step_index)

    def _on_step_done(self, stars: int) -> None:
        self._step_stars[self._current_step] = max(self._step_stars[self._current_step], stars)
        progress_tracker.save_step_progress(self._question_id, self._current_step, stars)
        is_final = self._current_step >= len(self._step_widgets) - 1
        if is_final:
            self._final_bonus.set_bonus(stars, is_final=True)
            self._final_bonus.exec_()
        else:
            self._bonus.set_bonus(stars, is_final=False)
            self._bonus.exec_()

    def _advance_step(self) -> None:
        next_step = self._current_step + 1
        if next_step < len(self._step_widgets):
            self.go_to_step(next_step)

    def _on_back(self) -> None:
        if self._current_step > 0:
            self.go_to_step(self._current_step - 1)
        else:
            self.back_requested.emit()

    def _load_progress(self) -> None:
        for idx in range(len(self._step_widgets)):
            saved = progress_tracker.get_step_progress(self._question_id, idx)
            if saved:
                self._step_stars[idx] = int(saved.get("stars", 0))
