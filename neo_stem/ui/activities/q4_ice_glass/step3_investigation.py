from PyQt5 import QtCore, QtWidgets

from ...widgets.touch_button import TouchButton


class Step3Investigation(QtWidgets.QWidget):
    step_completed = QtCore.pyqtSignal(int)

    def __init__(self, question_id: int, step_index: int, parent=None):
        super().__init__(parent)
        self.question_id = question_id
        self.step_index = step_index
        self._ice_count = 0
        self._humidity = 60
        self._glass_temp = 25
        self._has_condensation = False
        self._build_ui()
        self._update_condensation()

    def _build_ui(self) -> None:
        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(24, 24, 24, 24)
        layout.setSpacing(12)

        title = QtWidgets.QLabel("Thí nghiệm: Ngưng tụ trên ly")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet("font-size: 22px; font-weight: 700;")

        description = QtWidgets.QLabel(
            "Thay đổi số đá (nhiệt độ ly) và độ ẩm không khí. Quan sát khi nào giọt nước xuất hiện.")
        description.setAlignment(QtCore.Qt.AlignHCenter)
        description.setWordWrap(True)
        description.setStyleSheet("font-size: 16px; color: #4A4A4A;")

        self._temp_label = QtWidgets.QLabel("Nhiệt ly: 25°C")
        self._temp_label.setAlignment(QtCore.Qt.AlignHCenter)
        self._temp_label.setStyleSheet("font-size: 14px; color: #5A5A5A;")

        self._dew_label = QtWidgets.QLabel("Điểm sương: 30°C")
        self._dew_label.setAlignment(QtCore.Qt.AlignHCenter)
        self._dew_label.setStyleSheet("font-size: 14px; color: #5A5A5A;")

        self._cond_label = QtWidgets.QLabel("Chưa ngưng tụ")
        self._cond_label.setAlignment(QtCore.Qt.AlignHCenter)
        self._cond_label.setStyleSheet("font-size: 14px; color: #666666;")

        ice_controls = QtWidgets.QHBoxLayout()
        self._ice_minus = TouchButton("−", primary=False)
        self._ice_minus.setFixedWidth(44)
        self._ice_plus = TouchButton("+", primary=False)
        self._ice_plus.setFixedWidth(44)
        self._ice_label = QtWidgets.QLabel("🧊 Số viên đá: 0")
        self._ice_label.setAlignment(QtCore.Qt.AlignHCenter)
        self._ice_label.setStyleSheet("font-size: 12px; color: #555555;")
        self._ice_minus.clicked.connect(lambda: self._change_ice(-1))
        self._ice_plus.clicked.connect(lambda: self._change_ice(1))
        ice_controls.addWidget(self._ice_minus)
        ice_controls.addWidget(self._ice_label)
        ice_controls.addWidget(self._ice_plus)

        self._humidity_slider = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self._humidity_slider.setRange(30, 95)
        self._humidity_slider.setValue(60)
        self._humidity_slider.setSingleStep(5)
        self._humidity_slider.valueChanged.connect(self._on_humidity)

        self._table = QtWidgets.QTableWidget(0, 3)
        self._table.setHorizontalHeaderLabels(["Nhiệt ly (°C)", "Độ ẩm (%)", "Ngưng tụ"])
        self._table.horizontalHeader().setStretchLastSection(True)
        self._table.setMinimumHeight(180)

        self._record_btn = TouchButton("Ghi dữ liệu")
        self._record_btn.clicked.connect(self._record_data)

        self._conclusion = QtWidgets.QLabel(
            "Kết luận: Giọt nước bên ngoài ly đá là do NGƯNG TỤ. "
            "Hơi nước trong không khí (ở thể khí) gặp thành ly lạnh, "
            "nhiệt độ giảm xuống dưới 'điểm sương', hơi nước chuyển thành giọt nước (thể lỏng). "
            "Độ ẩm càng cao → điểm sương càng cao → dễ ngưng tụ hơn. "
            "Ly càng lạnh (nhiều đá) → ngưng tụ càng nhiều.")
        self._conclusion.setWordWrap(True)
        self._conclusion.setStyleSheet("font-size: 13px; color: #4A4A4A;")

        self._complete = TouchButton("Hoàn thành bước")
        self._complete.setEnabled(False)
        self._complete.clicked.connect(self._complete_step)

        layout.addWidget(title)
        layout.addWidget(description)
        layout.addWidget(self._temp_label)
        layout.addWidget(self._dew_label)
        layout.addWidget(self._cond_label)
        layout.addLayout(ice_controls)
        layout.addWidget(self._humidity_slider)
        layout.addWidget(self._table, 1)
        layout.addWidget(self._record_btn, alignment=QtCore.Qt.AlignHCenter)
        layout.addWidget(self._conclusion)
        layout.addStretch(1)
        layout.addWidget(self._complete, alignment=QtCore.Qt.AlignHCenter)

    def _change_ice(self, delta: int) -> None:
        self._ice_count = max(0, min(5, self._ice_count + delta))
        self._ice_label.setText(f"🧊 Số viên đá: {self._ice_count}")
        self._update_condensation()

    def _on_humidity(self, value: int) -> None:
        self._humidity = value
        self._update_condensation()

    def _update_condensation(self) -> None:
        self._glass_temp = 25 - self._ice_count * 5
        dew_point = 30 - ((100 - self._humidity) / 5)
        self._has_condensation = self._glass_temp <= dew_point
        self._temp_label.setText(f"Nhiệt ly: {int(self._glass_temp)}°C")
        self._dew_label.setText(f"Điểm sương: {int(dew_point)}°C")
        if self._has_condensation:
            self._cond_label.setText("💧 Ngưng tụ!")
            self._cond_label.setStyleSheet("font-size: 14px; color: #2E7D32;")
        else:
            self._cond_label.setText("Chưa ngưng tụ")
            self._cond_label.setStyleSheet("font-size: 14px; color: #666666;")

    def _record_data(self) -> None:
        if self._table.rowCount() >= 4:
            return
        row = self._table.rowCount()
        self._table.insertRow(row)
        self._table.setItem(row, 0, QtWidgets.QTableWidgetItem(str(int(self._glass_temp))))
        self._table.setItem(row, 1, QtWidgets.QTableWidgetItem(f"{self._humidity}%"))
        self._table.setItem(row, 2, QtWidgets.QTableWidgetItem("Có" if self._has_condensation else "Không"))
        if self._table.rowCount() >= 4:
            self._complete.setEnabled(True)

    def _complete_step(self) -> None:
        self.step_completed.emit(3)
