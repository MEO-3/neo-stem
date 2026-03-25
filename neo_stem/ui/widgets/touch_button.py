from PyQt5 import QtCore, QtWidgets

from .. import theme


class TouchButton(QtWidgets.QPushButton):
    def __init__(self, text: str = "", parent=None, *, primary: bool = True):
        super().__init__(text, parent)
        self._primary = primary
        self.setCursor(QtCore.Qt.PointingHandCursor)
        self.setMinimumHeight(theme.BUTTON_HEIGHT)
        self.setMinimumWidth(theme.TOUCH_MIN * 2)
        self._apply_style()

    def set_primary(self, primary: bool) -> None:
        self._primary = primary
        self._apply_style()

    def _apply_style(self) -> None:
        if self._primary:
            bg = theme.WARM_ORANGE
            fg = "#FFFFFF"
        else:
            bg = "transparent"
            fg = "#FFFFFF"

        self.setStyleSheet(
            "QPushButton {"
            f"background-color: {bg};"
            f"color: {fg};"
            "border-radius: 10px;"
            "padding: 10px 18px;"
            "font-weight: 600;"
            "}"
            "QPushButton:pressed {"
            f"background-color: {theme.SUNSHINE if self._primary else 'transparent'};"
            "}"
        )
