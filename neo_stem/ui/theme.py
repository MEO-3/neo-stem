FOREST_GREEN = "#2E7D32"
OCEAN_BLUE = "#1565C0"

WARM_ORANGE = "#FF8F00"
SUNSHINE = "#FFD600"

RICE_PAPER = "#FFF8E1"
CARD_BG = "#FFFFFF"

STEP_CORAL = "#FF7043"
STEP_AMBER = "#FFB300"
STEP_TEAL = "#26A69A"
STEP_INDIGO = "#5C6BC0"
STEP_PURPLE = "#AB47BC"

SUCCESS_GREEN = "#43A047"
ERROR_RED = "#E53935"
HINT_BLUE = "#29B6F6"

STEP_COLORS = [STEP_CORAL, STEP_AMBER, STEP_TEAL, STEP_INDIGO, STEP_PURPLE]

DEFAULT_FONT_FAMILY = "Noto Sans"
DEFAULT_FONT_SIZE = 16

FONT_TITLE = 28
FONT_BODY = 18
FONT_BUTTON = 20
FONT_CAPTION = 14

TOUCH_MIN = 48
DRAG_ITEM_SIZE = 64
BUTTON_HEIGHT = 56

ANIM_FAST = 200
ANIM_NORMAL = 400
ANIM_SLOW = 800

MAX_STARS_PER_STEP = 3
MAX_STARS_PER_QUESTION = 15
MAX_STARS_TOTAL = 300


def apply_theme(app) -> None:
    from PyQt5 import QtGui

    app.setFont(QtGui.QFont(DEFAULT_FONT_FAMILY, DEFAULT_FONT_SIZE))

    palette = app.palette()
    palette.setColor(QtGui.QPalette.Window, QtGui.QColor(RICE_PAPER))
    palette.setColor(QtGui.QPalette.Base, QtGui.QColor(CARD_BG))
    palette.setColor(QtGui.QPalette.Button, QtGui.QColor(WARM_ORANGE))
    palette.setColor(QtGui.QPalette.Text, QtGui.QColor("#1F1F1F"))
    palette.setColor(QtGui.QPalette.ButtonText, QtGui.QColor("#FFFFFF"))
    app.setPalette(palette)
