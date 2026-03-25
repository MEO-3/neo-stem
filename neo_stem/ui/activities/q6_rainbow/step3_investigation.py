from PyQt5 import QtCore, QtWidgets

from ...widgets.touch_button import TouchButton


class Step3Investigation(QtWidgets.QWidget):
    step_completed = QtCore.pyqtSignal(int)

    def __init__(self, question_id: int, step_index: int, parent=None):
        super().__init__(parent)
        self.question_id = question_id
        self.step_index = step_index
        self._prism_angle = 0
        self._visible_colors = 0
        self._color_order = "Chưa thấy"
        self._build_ui()
        self._update_spectrum()

    def _build_ui(self) -> None:
        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(24, 24, 24, 24)
        layout.setSpacing(12)

        title = QtWidgets.QLabel("Thí nghiệm: Lăng kính tách ánh sáng")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet("font-size: 22px; font-weight: 700;")

        description = QtWidgets.QLabel(
            "Xoay lăng kính để tách ánh sáng trắng thành quang phổ. Ghi lại góc xoay và số màu nhìn thấy.")
        description.setAlignment(QtCore.Qt.AlignHCenter)
        description.setWordWrap(True)
        description.setStyleSheet("font-size: 16px; color: #4A4A4A;")

        self._angle_label = QtWidgets.QLabel("Góc: 0° — 0 màu")
        self._angle_label.setAlignment(QtCore.Qt.AlignHCenter)
        self._angle_label.setStyleSheet("font-size: 14px; color: #5A5A5A;")

        self._order_label = QtWidgets.QLabel("Chưa thấy")
        self._order_label.setAlignment(QtCore.Qt.AlignHCenter)
        self._order_label.setStyleSheet("font-size: 14px; color: #5A5A5A;")

        self._slider = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self._slider.setRange(0, 75)
        self._slider.setValue(0)
        self._slider.valueChanged.connect(self._on_angle)

        self._table = QtWidgets.QTableWidget(0, 3)
        self._table.setHorizontalHeaderLabels(["Góc (°)", "Số màu", "Thứ tự màu"])
        self._table.horizontalHeader().setStretchLastSection(True)
        self._table.setMinimumHeight(180)

        self._record_btn = TouchButton("Ghi dữ liệu")
        self._record_btn.clicked.connect(self._record_data)

        self._conclusion = QtWidgets.QLabel(
            "Cần thêm dữ liệu để kết luận.")
        self._conclusion.setWordWrap(True)
        self._conclusion.setStyleSheet("font-size: 13px; color: #4A4A4A;")

        self._complete = TouchButton("Hoàn thành bước")
        self._complete.setEnabled(False)
        self._complete.clicked.connect(self._complete_step)

        layout.addWidget(title)
        layout.addWidget(description)
        layout.addWidget(self._angle_label)
        layout.addWidget(self._order_label)
        layout.addWidget(self._slider)
        layout.addWidget(self._table, 1)
        layout.addWidget(self._record_btn, alignment=QtCore.Qt.AlignHCenter)
        layout.addWidget(self._conclusion)
        layout.addStretch(1)
        layout.addWidget(self._complete, alignment=QtCore.Qt.AlignHCenter)

    def _on_angle(self, value: int) -> None:
        self._prism_angle = value
        self._update_spectrum()

    def _update_spectrum(self) -> None:
        if self._prism_angle < 15:
            self._visible_colors = 0
            self._color_order = "Chưa thấy"
        elif self._prism_angle < 30:
            self._visible_colors = 2
            self._color_order = "Đỏ, Cam"
        elif self._prism_angle < 45:
            self._visible_colors = 4
            self._color_order = "Đỏ, Cam, Vàng, Lục"
        elif self._prism_angle < 60:
            self._visible_colors = 6
            self._color_order = "Đỏ, Cam, Vàng, Lục, Lam, Chàm"
        else:
            self._visible_colors = 7
            self._color_order = "Đỏ, Cam, Vàng, Lục, Lam, Chàm, Tím"

        self._angle_label.setText(f"Góc: {self._prism_angle}° — {self._visible_colors} màu")
        self._order_label.setText(self._color_order)

    def _record_data(self) -> None:
        if self._table.rowCount() >= 5:
            return
        row = self._table.rowCount()
        self._table.insertRow(row)
        self._table.setItem(row, 0, QtWidgets.QTableWidgetItem(str(self._prism_angle)))
        self._table.setItem(row, 1, QtWidgets.QTableWidgetItem(str(self._visible_colors)))
        self._table.setItem(row, 2, QtWidgets.QTableWidgetItem(self._color_order))
        if self._table.rowCount() >= 5:
            self._conclusion.setText(
                "Kết luận: Ánh sáng trắng thực ra là tổng hợp của nhiều màu. "
                "Khi đi qua lăng kính (hoặc giọt nước), ánh sáng bị khúc xạ — mỗi màu bị bẻ cong một góc khác nhau. "
                "Đó là lý do ta thấy 7 màu: Đỏ, Cam, Vàng, Lục, Lam, Chàm, Tím. "
                "Cầu vồng chính là quang phổ của ánh sáng mặt trời được giọt mưa tách ra!")
            self._complete.setEnabled(True)

    def _complete_step(self) -> None:
        self.step_completed.emit(3)
