from PyQt5 import QtCore, QtWidgets

from ...widgets.touch_button import TouchButton


class Step3Investigation(QtWidgets.QWidget):
    step_completed = QtCore.pyqtSignal(int)

    def __init__(self, question_id: int, step_index: int, parent=None):
        super().__init__(parent)
        self.question_id = question_id
        self.step_index = step_index
        self._current_station = 0
        self._solar_intensity = 0.5
        self._heat_intensity = 0.5
        self._evap_progress = 0.0
        self._build_ui()
        self._timer = QtCore.QTimer(self)
        self._timer.setInterval(120)
        self._timer.timeout.connect(self._tick)
        self._timer.start()

    def _build_ui(self) -> None:
        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(24, 24, 24, 24)
        layout.setSpacing(12)

        title = QtWidgets.QLabel("Thí nghiệm: 3 cách tách muối")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet("font-size: 22px; font-weight: 700;")

        description = QtWidgets.QLabel(
            "Thử 3 phương pháp tách muối khỏi nước biển. Quan sát hiệu quả từng cách.")
        description.setAlignment(QtCore.Qt.AlignHCenter)
        description.setWordWrap(True)
        description.setStyleSheet("font-size: 16px; color: #4A4A4A;")

        tab_row = QtWidgets.QHBoxLayout()
        self._tabs = []
        for label, idx in [("A: Phơi nắng", 0), ("B: Đun nóng", 1), ("C: Lọc", 2)]:
            btn = TouchButton(label, primary=False)
            btn.clicked.connect(lambda _=False, i=idx: self._set_station(i))
            tab_row.addWidget(btn)
            self._tabs.append(btn)

        self._status = QtWidgets.QLabel("Bay hơi: 0%")
        self._status.setAlignment(QtCore.Qt.AlignHCenter)
        self._status.setStyleSheet("font-size: 14px; color: #666666;")

        self._energy = QtWidgets.QLabel("Cường độ: 50%")
        self._energy.setAlignment(QtCore.Qt.AlignHCenter)
        self._energy.setStyleSheet("font-size: 13px; color: #555555;")

        self._slider = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self._slider.setRange(10, 100)
        self._slider.setValue(50)
        self._slider.valueChanged.connect(self._on_intensity)

        self._filter_note = QtWidgets.QLabel(
            "Phương pháp lọc không hiệu quả cho hỗn hợp dung dịch")
        self._filter_note.setAlignment(QtCore.Qt.AlignHCenter)
        self._filter_note.setWordWrap(True)
        self._filter_note.setStyleSheet("font-size: 12px; color: #999999;")

        self._table = QtWidgets.QTableWidget(0, 3)
        self._table.setHorizontalHeaderLabels(["Phương pháp", "Mức năng lượng", "Kết quả"])
        self._table.horizontalHeader().setStretchLastSection(True)
        self._table.setMinimumHeight(180)

        self._record_btn = TouchButton("Ghi dữ liệu")
        self._record_btn.clicked.connect(self._record_data)

        self._conclusion = QtWidgets.QLabel(
            "Kết luận: Muối biển được tách bằng phương pháp BAY HƠI. "
            "Nước (dung môi) bay hơi, muối (chất tan) không bay hơi → muối kết tinh lại. "
            "Phơi nắng: chậm nhưng tiết kiệm năng lượng (dùng năng lượng mặt trời). "
            "Đun nóng: nhanh nhưng tốn nhiên liệu. "
            "Lọc: KHÔNG hiệu quả vì muối hòa tan ở mức phân tử, lọt qua mọi bộ lọc thông thường.")
        self._conclusion.setWordWrap(True)
        self._conclusion.setStyleSheet("font-size: 13px; color: #4A4A4A;")

        self._complete = TouchButton("Hoàn thành bước")
        self._complete.setEnabled(False)
        self._complete.clicked.connect(self._complete_step)

        layout.addWidget(title)
        layout.addWidget(description)
        layout.addLayout(tab_row)
        layout.addWidget(self._status)
        layout.addWidget(self._energy)
        layout.addWidget(self._slider)
        layout.addWidget(self._filter_note)
        layout.addWidget(self._table, 1)
        layout.addWidget(self._record_btn, alignment=QtCore.Qt.AlignHCenter)
        layout.addWidget(self._conclusion)
        layout.addStretch(1)
        layout.addWidget(self._complete, alignment=QtCore.Qt.AlignHCenter)

        self._set_station(0)

    def _set_station(self, index: int) -> None:
        self._current_station = index
        self._evap_progress = 0.0
        self._filter_note.setVisible(index == 2)
        self._slider.setVisible(index != 2)
        self._energy.setVisible(index != 2)
        self._update_status()

    def _on_intensity(self, value: int) -> None:
        if self._current_station == 0:
            self._solar_intensity = value / 100.0
        elif self._current_station == 1:
            self._heat_intensity = value / 100.0
        self._energy.setText(f"Cường độ: {value}%")

    def _tick(self) -> None:
        if self._current_station == 0:
            self._evap_progress = min(1.0, self._evap_progress + self._solar_intensity * 0.01)
        elif self._current_station == 1:
            self._evap_progress = min(1.0, self._evap_progress + self._heat_intensity * 0.03)
        self._update_status()

    def _update_status(self) -> None:
        if self._current_station in (0, 1):
            if self._evap_progress >= 0.9:
                label = "✓ Muối kết tinh!" if self._current_station == 0 else "✓ Muối kết tinh (nhanh)!"
            else:
                label = f"Bay hơi: {int(self._evap_progress * 100)}%"
            self._status.setText(label)
        else:
            self._status.setText("Lọc: Thất bại - vẫn mặn")

    def _record_data(self) -> None:
        if self._table.rowCount() >= 4:
            return
        methods = ["Phơi nắng", "Đun nóng", "Lọc"]
        energy_levels = [
            f"{int(self._solar_intensity * 100)}%",
            f"{int(self._heat_intensity * 100)}%",
            "N/A",
        ]
        results = [
            "Có muối" if self._evap_progress >= 0.9 else f"{int(self._evap_progress * 100)}% bay hơi",
            "Có muối" if self._evap_progress >= 0.9 else f"{int(self._evap_progress * 100)}% bay hơi",
            "Thất bại - vẫn mặn",
        ]
        row = self._table.rowCount()
        self._table.insertRow(row)
        self._table.setItem(row, 0, QtWidgets.QTableWidgetItem(methods[self._current_station]))
        self._table.setItem(row, 1, QtWidgets.QTableWidgetItem(energy_levels[self._current_station]))
        self._table.setItem(row, 2, QtWidgets.QTableWidgetItem(results[self._current_station]))
        if self._table.rowCount() >= 4:
            self._complete.setEnabled(True)

    def _complete_step(self) -> None:
        self.step_completed.emit(3)
