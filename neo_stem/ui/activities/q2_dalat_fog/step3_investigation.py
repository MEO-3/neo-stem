from PyQt5 import QtCore, QtWidgets

from ...widgets.touch_button import TouchButton


class Step3Investigation(QtWidgets.QWidget):
    step_completed = QtCore.pyqtSignal(int)

    def __init__(self, question_id: int, step_index: int, parent=None):
        super().__init__(parent)
        self.question_id = question_id
        self.step_index = step_index
        self._water_temp = 40
        self._has_ice = False
        self._has_fog = False
        self._build_ui()

    def _build_ui(self) -> None:
        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(24, 24, 24, 24)
        layout.setSpacing(12)

        title = QtWidgets.QLabel("Thí nghiệm: Sương mù trong lọ")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet("font-size: 22px; font-weight: 700;")

        description = QtWidgets.QLabel(
            "Tạo sương mù trong lọ bằng nước nóng + đá lạnh. Điều chỉnh nhiệt độ nước và quan sát.")
        description.setAlignment(QtCore.Qt.AlignHCenter)
        description.setWordWrap(True)
        description.setStyleSheet("font-size: 16px; color: #4A4A4A;")

        self._temp_label = QtWidgets.QLabel("Nhiệt nước: 40°C")
        self._temp_label.setAlignment(QtCore.Qt.AlignHCenter)
        self._temp_label.setStyleSheet("font-size: 14px; color: #5A5A5A;")

        self._fog_label = QtWidgets.QLabel("Chưa có sương mù")
        self._fog_label.setAlignment(QtCore.Qt.AlignHCenter)
        self._fog_label.setStyleSheet("font-size: 14px; color: #666666;")

        self._slider = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self._slider.setRange(20, 90)
        self._slider.setValue(40)
        self._slider.setSingleStep(5)
        self._slider.valueChanged.connect(self._on_temp_changed)

        self._ice_btn = TouchButton("❄ Thêm đá", primary=False)
        self._ice_btn.clicked.connect(self._toggle_ice)

        self._table = QtWidgets.QTableWidget(0, 3)
        self._table.setHorizontalHeaderLabels(["Nhiệt nước (°C)", "Có đá lạnh", "Sương mù"])
        self._table.horizontalHeader().setStretchLastSection(True)
        self._table.setMinimumHeight(180)

        self._record_btn = TouchButton("Ghi dữ liệu")
        self._record_btn.clicked.connect(self._record_data)

        self._conclusion = QtWidgets.QLabel("Kết luận: Sương mù hình thành khi hơi nước ấm gặp bề mặt lạnh và ngưng tụ thành giọt nước li ti. "
                                            "Ở Đà Lạt, ban đêm nhiệt độ giảm thấp, hơi nước trong không khí ngưng tụ thành sương mù. "
                                            "Khi mặt trời lên, nhiệt độ tăng, giọt nước bay hơi và sương tan. "
                                            "Đây là một phần của chu trình nước trong tự nhiên.")
        self._conclusion.setWordWrap(True)
        self._conclusion.setStyleSheet("font-size: 13px; color: #4A4A4A;")

        self._complete = TouchButton("Hoàn thành bước")
        self._complete.setEnabled(False)
        self._complete.clicked.connect(self._complete_step)

        controls = QtWidgets.QHBoxLayout()
        controls.addWidget(self._slider, 1)
        controls.addWidget(self._ice_btn)

        layout.addWidget(title)
        layout.addWidget(description)
        layout.addWidget(self._temp_label)
        layout.addWidget(self._fog_label)
        layout.addLayout(controls)
        layout.addWidget(self._table, 1)
        layout.addWidget(self._record_btn, alignment=QtCore.Qt.AlignHCenter)
        layout.addWidget(self._conclusion)
        layout.addStretch(1)
        layout.addWidget(self._complete, alignment=QtCore.Qt.AlignHCenter)

        self._update_fog()

    def _on_temp_changed(self, value: int) -> None:
        self._water_temp = value
        self._temp_label.setText(f"Nhiệt nước: {value}°C")
        self._update_fog()

    def _toggle_ice(self) -> None:
        self._has_ice = not self._has_ice
        self._ice_btn.setText("❄ Bỏ đá" if self._has_ice else "❄ Thêm đá")
        self._update_fog()

    def _update_fog(self) -> None:
        self._has_fog = self._water_temp >= 50 and self._has_ice
        if self._has_fog:
            self._fog_label.setText("✓ Sương mù xuất hiện!")
            self._fog_label.setStyleSheet("font-size: 14px; color: #2E7D32;")
        else:
            self._fog_label.setText("Chưa có sương mù")
            self._fog_label.setStyleSheet("font-size: 14px; color: #666666;")

    def _record_data(self) -> None:
        if self._table.rowCount() >= 4:
            return
        row = self._table.rowCount()
        self._table.insertRow(row)
        self._table.setItem(row, 0, QtWidgets.QTableWidgetItem(str(self._water_temp)))
        self._table.setItem(row, 1, QtWidgets.QTableWidgetItem("Có" if self._has_ice else "Không"))
        self._table.setItem(row, 2, QtWidgets.QTableWidgetItem("Có" if self._has_fog else "Không"))
        if self._table.rowCount() >= 4:
            self._complete.setEnabled(True)

    def _complete_step(self) -> None:
        self.step_completed.emit(3)
