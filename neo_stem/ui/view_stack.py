from PyQt5 import QtWidgets


class ViewStack(QtWidgets.QStackedWidget):
    def __init__(self, parent=None):
        super().__init__(parent)
        self._view_stack = []

    def push(self, view: QtWidgets.QWidget) -> None:
        if view in self._view_stack:
            self.setCurrentWidget(view)
            return

        view.setParent(self)
        self.addWidget(view)
        self._view_stack.append(view)
        self.setCurrentWidget(view)

    def pop(self) -> None:
        if len(self._view_stack) <= 1:
            return

        current = self._view_stack.pop()
        self.removeWidget(current)
        current.deleteLater()
        self.setCurrentWidget(self._view_stack[-1])
