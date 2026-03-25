from PyQt5 import QtCore, QtWidgets

from ...widgets.touch_button import TouchButton


class Step1Phenomenon(QtWidgets.QWidget):
    step_completed = QtCore.pyqtSignal(int)

    def __init__(self, question_id: int, step_index: int, parent=None):
        super().__init__(parent)
        self.question_id = question_id
        self.step_index = step_index
        self._discovered = set()
        self._time_of_day = 0.0
        self._build_ui()

    def _build_ui(self) -> None:
        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(24, 24, 24, 24)
        layout.setSpacing(12)

        title = QtWidgets.QLabel("Hiện tượng: Sương mù Đà Lạt")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet("font-size: 22px; font-weight: 700;")

        description = QtWidgets.QLabel(
            "Đà Lạt sáng sớm phủ đầy sương mù. Kéo slider thời gian để xem sương thay đổi trong ngày.")
        description.setWordWrap(True)
        description.setAlignment(QtCore.Qt.AlignHCenter)
        description.setStyleSheet("font-size: 16px; color: #4A4A4A;")

        self._time_label = QtWidgets.QLabel("Thời gian: 0% (Đêm)")
        self._time_label.setAlignment(QtCore.Qt.AlignHCenter)
        self._time_label.setStyleSheet("font-size: 14px; color: #5A5A5A;")

        self._slider = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self._slider.setRange(0, 100)
        self._slider.setValue(0)
        self._slider.valueChanged.connect(self._on_time_changed)

        hotspot_row = QtWidgets.QHBoxLayout()
        hotspot_row.setSpacing(12)

        self._info = QtWidgets.QLabel("Hãy chạm vào các điểm để tìm hiểu.")
        self._info.setWordWrap(True)
        self._info.setAlignment(QtCore.Qt.AlignHCenter)
        self._info.setStyleSheet("font-size: 14px; color: #2E7D32;")

        hotspots = [
            (
                "Sương mù dày đặc",
                "Sáng sớm (5-7h), nhiệt độ thấp nhất trong ngày. Hơi nước trong không khí ngưng tụ thành "
                "giọt nước li ti lơ lửng — đó là sương mù.",
            ),
            (
                "Mặt trời lên",
                "Khi mặt trời lên, nhiệt độ tăng dần. Giọt nước nhỏ trong sương mù hấp thụ nhiệt và bay "
                "hơi trở lại thành khí — sương tan dần.",
            ),
            (
                "Thung lũng Đà Lạt",
                "Đà Lạt nằm ở cao nguyên 1500m, có nhiều thung lũng. Không khí lạnh nặng chảy xuống thung "
                "lũng ban đêm, tạo điều kiện lý tưởng cho sương mù.",
            ),
        ]

        for label, detail in hotspots:
            btn = TouchButton(label)
            btn.clicked.connect(lambda _=False, l=label, d=detail: self._on_hotspot(l, d))
            hotspot_row.addWidget(btn)

        self._complete = TouchButton("Hoàn thành bước")
        self._complete.setEnabled(False)
        self._complete.clicked.connect(lambda: self.step_completed.emit(3))

        layout.addWidget(title)
        layout.addWidget(description)
        layout.addWidget(self._time_label)
        layout.addWidget(self._slider)
        layout.addLayout(hotspot_row)
        layout.addWidget(self._info)
        layout.addStretch(1)
        layout.addWidget(self._complete, alignment=QtCore.Qt.AlignHCenter)

    def _on_time_changed(self, value: int) -> None:
        self._time_of_day = value / 100.0
        if value < 30:
            label = "Đêm"
        elif value < 60:
            label = "Sáng sớm"
        elif value < 85:
            label = "Sáng"
        else:
            label = "Trưa"
        self._time_label.setText(f"Thời gian: {value}% ({label})")

    def _on_hotspot(self, label: str, detail: str) -> None:
        self._discovered.add(label)
        self._info.setText(detail)
        if len(self._discovered) >= 3:
            self._complete.setEnabled(True)
