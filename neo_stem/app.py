import sys

from PyQt5 import QtWidgets

from .ui.main_window import MainWindow
from .ui.theme import apply_theme


def main() -> int:
    app = QtWidgets.QApplication(sys.argv)
    apply_theme(app)

    window = MainWindow()
    window.show()

    return app.exec_()


if __name__ == "__main__":
    raise SystemExit(main())
