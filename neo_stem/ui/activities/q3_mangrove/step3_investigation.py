from PyQt5 import QtCore, QtWidgets

from ...widgets.touch_button import TouchButton


class Step3Investigation(QtWidgets.QWidget):
    step_completed = QtCore.pyqtSignal(int)

    def __init__(self, question_id: int, step_index: int, parent=None):
        super().__init__(parent)
        self.question_id = question_id
        self.step_index = step_index
        self._salt_level = 0.0
        self._time_elapsed = 0.0
        self._build_ui()
        self._timer = QtCore.QTimer(self)
        self._timer.setInterval(80)
        self._timer.timeout.connect(self._tick)
        self._timer.start()

    def _build_ui(self) -> None:
        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(24, 24, 24, 24)
        layout.setSpacing(12)

        title = QtWidgets.QLabel("Thí nghiệm: Cần tây trong nước muối")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet("font-size: 22px; font-weight: 700;")

        description = QtWidgets.QLabel(
            "Đặt cần tây vào 3 cốc nước khác nhau. Quan sát sự thay đổi sau vài giờ (mô phỏng nhanh).")
        description.setAlignment(QtCore.Qt.AlignHCenter)
        description.setWordWrap(True)
        description.setStyleSheet("font-size: 16px; color: #4A4A4A;")

        self._status = QtWidgets.QLabel("Trạng thái: Yên tĩnh")
        self._status.setAlignment(QtCore.Qt.AlignHCenter)
        self._status.setStyleSheet("font-size: 14px; color: #5A5A5A;")

        self._cell = QtWidgets.QLabel("Tế bào: Nước vào tế bào → căng")
        self._cell.setAlignment(QtCore.Qt.AlignHCenter)
        self._cell.setStyleSheet("font-size: 14px; color: #5A5A5A;")

        cups = QtWidgets.QHBoxLayout()
        self._cup_buttons = []
        for label, value in [("Nước ngọt", 0.0), ("Hơi mặn (1%)", 0.5), ("Rất mặn (5%)", 1.0)]:
            btn = TouchButton(label, primary=False)
            btn.clicked.connect(lambda _=False, v=value: self._select_cup(v))
            cups.addWidget(btn)
            self._cup_buttons.append(btn)

        self._slider = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self._slider.setRange(0, 100)
        self._slider.setValue(0)
        self._slider.valueChanged.connect(self._on_slider)

        self._time_label = QtWidgets.QLabel("Thời gian: 0h")
        self._time_label.setAlignment(QtCore.Qt.AlignHCenter)
        self._time_label.setStyleSheet("font-size: 13px; color: #666666;")

        self._table = QtWidgets.QTableWidget(0, 3)
        self._table.setHorizontalHeaderLabels(["Nồng độ muối", "Trạng thái cần tây", "Tế bào"])
        self._table.horizontalHeader().setStretchLastSection(True)
        self._table.setMinimumHeight(180)

        self._record_btn = TouchButton("Ghi dữ liệu")
        self._record_btn.clicked.connect(self._record_data)

        self._conclusion = QtWidgets.QLabel(
            "Kết luận: Nước di chuyển từ nơi có nồng độ muối THẤP sang nơi có nồng độ muối CAO (thẩm thấu). "
            "Trong nước mặn, nước rút ra khỏi tế bào → cây héo. "
            "Cây đước có cơ chế đặc biệt: rễ lọc muối, lá tiết muối, giữ nước bên trong tế bào. "
            "Đó là lý do chỉ cây ngập mặn mới sống được trong môi trường mặn.")
        self._conclusion.setWordWrap(True)
        self._conclusion.setStyleSheet("font-size: 13px; color: #4A4A4A;")

        self._complete = TouchButton("Hoàn thành bước")
        self._complete.setEnabled(False)
        self._complete.clicked.connect(self._complete_step)

        layout.addWidget(title)
        layout.addWidget(description)
        layout.addLayout(cups)
        layout.addWidget(self._slider)
        layout.addWidget(self._time_label)
        layout.addWidget(self._status)
        layout.addWidget(self._cell)
        layout.addWidget(self._table, 1)
        layout.addWidget(self._record_btn, alignment=QtCore.Qt.AlignHCenter)
        layout.addWidget(self._conclusion)
        layout.addStretch(1)
        layout.addWidget(self._complete, alignment=QtCore.Qt.AlignHCenter)

        self._update_state()

    def _select_cup(self, value: float) -> None:
        self._salt_level = value
        self._slider.setValue(int(value * 100))
        self._time_elapsed = 0
        self._update_state()

    def _on_slider(self, value: int) -> None:
        self._salt_level = value / 100.0
        self._time_elapsed = 0
        self._update_state()

    def _tick(self) -> None:
        if self._time_elapsed < 100:
            self._time_elapsed += 0.5
        self._time_label.setText(f"Thời gian: {int(self._time_elapsed)}h")
        self._update_state()

    def _celery_state(self) -> str:
        if self._salt_level < 0.2:
            return "Tươi, cứng"
        if self._salt_level < 0.6:
            return "Hơi mềm" if self._time_elapsed > 50 else "Bình thường"
        return "Héo, mềm nhũn" if self._time_elapsed > 30 else "Bắt đầu héo"

    def _cell_state(self) -> str:
        if self._salt_level < 0.2:
            return "Nước vào tế bào → căng"
        if self._salt_level < 0.6:
            return "Cân bằng"
        return "Nước rút ra → tế bào co"

    def _update_state(self) -> None:
        self._status.setText(f"Trạng thái cần tây: {self._celery_state()}")
        self._cell.setText(f"Tế bào: {self._cell_state()}")

    def _record_data(self) -> None:
        if self._table.rowCount() >= 4:
            return
        row = self._table.rowCount()
        salt_label = "Ngọt" if self._salt_level < 0.2 else ("Hơi mặn" if self._salt_level < 0.6 else "Rất mặn")
        self._table.insertRow(row)
        self._table.setItem(row, 0, QtWidgets.QTableWidgetItem(salt_label))
        self._table.setItem(row, 1, QtWidgets.QTableWidgetItem(self._celery_state()))
        self._table.setItem(row, 2, QtWidgets.QTableWidgetItem(self._cell_state()))
        if self._table.rowCount() >= 4:
            self._complete.setEnabled(True)

    def _complete_step(self) -> None:
        self.step_completed.emit(3)
