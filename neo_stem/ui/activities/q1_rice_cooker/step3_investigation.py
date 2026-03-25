from PyQt5 import QtCore, QtWidgets

from ...widgets.touch_button import TouchButton


class Step3Investigation(QtWidgets.QWidget):
    step_completed = QtCore.pyqtSignal(int)

    def __init__(self, question_id: int, step_index: int, parent=None):
        super().__init__(parent)
        self.question_id = question_id
        self.step_index = step_index
        self._current_temp = 25.0
        self._heat_level = 0.0
        self._build_ui()
        self._timer = QtCore.QTimer(self)
        self._timer.setInterval(120)
        self._timer.timeout.connect(self._tick)
        self._timer.start()

    def _build_ui(self) -> None:
        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(24, 24, 24, 24)
        layout.setSpacing(12)

        title = QtWidgets.QLabel("Thí nghiệm: Đun nước sôi")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet("font-size: 22px; font-weight: 700;")

        description = QtWidgets.QLabel(
            "Điều chỉnh mức lửa và quan sát nước thay đổi. Ghi lại nhiệt độ và trạng thái nước tại mỗi mức.")
        description.setAlignment(QtCore.Qt.AlignHCenter)
        description.setWordWrap(True)
        description.setStyleSheet("font-size: 16px; color: #4A4A4A;")

        self._temp_label = QtWidgets.QLabel("Nhiệt độ: 25°C")
        self._temp_label.setAlignment(QtCore.Qt.AlignHCenter)
        self._temp_label.setStyleSheet("font-size: 16px; font-weight: 600;")

        self._state_label = QtWidgets.QLabel("Trạng thái: Yên tĩnh")
        self._state_label.setAlignment(QtCore.Qt.AlignHCenter)
        self._state_label.setStyleSheet("font-size: 14px; color: #5A5A5A;")

        self._slider = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self._slider.setRange(0, 100)
        self._slider.setValue(0)
        self._slider.valueChanged.connect(self._on_slider)

        self._table = QtWidgets.QTableWidget(0, 2)
        self._table.setHorizontalHeaderLabels(["Nhiệt độ (°C)", "Trạng thái"])
        self._table.horizontalHeader().setStretchLastSection(True)
        self._table.setMinimumHeight(180)

        self._record_btn = TouchButton("Ghi dữ liệu")
        self._record_btn.clicked.connect(self._record_data)

        self._conclusion = QtWidgets.QLabel("Cần thêm dữ liệu để kết luận.")
        self._conclusion.setWordWrap(True)
        self._conclusion.setStyleSheet("font-size: 14px; color: #4A4A4A;")

        self._complete = TouchButton("Hoàn thành bước")
        self._complete.setEnabled(False)
        self._complete.clicked.connect(self._complete_step)

        layout.addWidget(title)
        layout.addWidget(description)
        layout.addWidget(self._temp_label)
        layout.addWidget(self._state_label)
        layout.addWidget(self._slider)
        layout.addWidget(self._table, 1)
        layout.addWidget(self._record_btn, alignment=QtCore.Qt.AlignHCenter)
        layout.addWidget(self._conclusion)
        layout.addStretch(1)
        layout.addWidget(self._complete, alignment=QtCore.Qt.AlignHCenter)

    def _on_slider(self, value: int) -> None:
        self._heat_level = value / 100.0

    def _tick(self) -> None:
        target = 25 + self._heat_level * 85
        if self._heat_level > 0:
            self._current_temp = min(self._current_temp + (target - self._current_temp) * 0.08, 110)
        else:
            self._current_temp = max(self._current_temp - 0.5, 25)

        state = self._state_from_temp(self._current_temp)
        self._temp_label.setText(f"Nhiệt độ: {int(self._current_temp)}°C")
        self._state_label.setText(f"Trạng thái: {state}")

    def _state_from_temp(self, temp: float) -> str:
        if temp < 40:
            return "Yên tĩnh"
        if temp < 80:
            return "Bọt nhỏ xuất hiện"
        if temp < 100:
            return "Bọt lớn + hơi nước"
        return "Sôi mạnh + nắp rung!"

    def _record_data(self) -> None:
        row = self._table.rowCount()
        if row >= 5:
            return
        temp = int(self._current_temp)
        state = self._state_from_temp(self._current_temp)
        self._table.insertRow(row)
        self._table.setItem(row, 0, QtWidgets.QTableWidgetItem(str(temp)))
        self._table.setItem(row, 1, QtWidgets.QTableWidgetItem(state))
        self._update_conclusion()

    def _update_conclusion(self) -> None:
        if self._table.rowCount() >= 5:
            self._conclusion.setText(
                "Kết luận: Khi nước được đun nóng đến 100°C, nước chuyển từ thể lỏng sang thể khí (hơi nước). "
                "Phân tử nước di chuyển nhanh hơn khi nhiệt độ tăng, tạo bọt khí. "
                "Hơi nước tạo áp suất đẩy nắp nồi lên, gây ra tiếng rung. "
                "Đây là quá trình bay hơi và sôi — một dạng chuyển thể từ lỏng sang khí.")
            self._complete.setEnabled(True)
        else:
            self._conclusion.setText("Cần thêm dữ liệu để kết luận.")
            self._complete.setEnabled(False)

    def _complete_step(self) -> None:
        self.step_completed.emit(3)
