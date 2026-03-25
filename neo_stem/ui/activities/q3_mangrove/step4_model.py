from PyQt5 import QtCore, QtWidgets

from ...widgets.touch_button import TouchButton


class Step4Model(QtWidgets.QWidget):
    step_completed = QtCore.pyqtSignal(int)

    def __init__(self, question_id: int, step_index: int, parent=None):
        super().__init__(parent)
        self.question_id = question_id
        self.step_index = step_index
        self._build_ui()

    def _build_ui(self) -> None:
        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(24, 24, 24, 24)
        layout.setSpacing(12)

        title = QtWidgets.QLabel("Mô hình: Thẩm thấu ở cây ngập mặn")
        title.setAlignment(QtCore.Qt.AlignHCenter)
        title.setStyleSheet("font-size: 22px; font-weight: 700;")

        description = QtWidgets.QLabel("Sắp xếp các bước giải thích cách cây đước sống trong nước mặn.")
        description.setAlignment(QtCore.Qt.AlignHCenter)
        description.setWordWrap(True)
        description.setStyleSheet("font-size: 16px; color: #4A4A4A;")

        lists_row = QtWidgets.QHBoxLayout()

        self._parts = QtWidgets.QListWidget()
        self._parts.setSelectionMode(QtWidgets.QAbstractItemView.SingleSelection)

        self._sequence = QtWidgets.QListWidget()
        self._sequence.setSelectionMode(QtWidgets.QAbstractItemView.SingleSelection)

        self._drop_labels = ["Môi trường", "Rễ", "Tế bào", "Lá", "Kết quả"]
        for label in self._drop_labels:
            item = QtWidgets.QListWidgetItem(f"{label}: ...")
            item.setData(QtCore.Qt.UserRole, None)
            self._sequence.addItem(item)

        lists_row.addWidget(self._parts)
        lists_row.addWidget(self._sequence)

        controls = QtWidgets.QHBoxLayout()
        self._add_btn = TouchButton("Thêm vào chuỗi")
        self._remove_btn = TouchButton("Xóa bước", primary=False)
        self._add_btn.clicked.connect(self._add_to_sequence)
        self._remove_btn.clicked.connect(self._remove_last)
        controls.addStretch(1)
        controls.addWidget(self._add_btn)
        controls.addWidget(self._remove_btn)
        controls.addStretch(1)

        self._status = QtWidgets.QLabel("0/5 bước đúng")
        self._status.setAlignment(QtCore.Qt.AlignHCenter)
        self._status.setStyleSheet("font-size: 14px; color: #5A5A5A;")

        self._complete = TouchButton("Hoàn thành bước")
        self._complete.setEnabled(False)
        self._complete.clicked.connect(self._complete_step)

        layout.addWidget(title)
        layout.addWidget(description)
        layout.addLayout(lists_row, 1)
        layout.addLayout(controls)
        layout.addWidget(self._status)
        layout.addWidget(self._complete, alignment=QtCore.Qt.AlignHCenter)

        self._setup_items()

    def _setup_items(self) -> None:
        self._correct_sequence = [
            ("salt_water", "Nước mặn quanh rễ"),
            ("filter", "Rễ lọc muối 90%"),
            ("water_in", "Nước vào tế bào"),
            ("salt_excrete", "Lá tiết muối thừa"),
            ("survive", "Cây sống khỏe"),
        ]
        distractors = [
            ("absorb_salt", "Hấp thụ toàn bộ muối"),
            ("no_water", "Không cần nước"),
            ("osmosis_out", "Nước rút ra ngoài"),
        ]
        for item_id, label in self._correct_sequence + distractors:
            item = QtWidgets.QListWidgetItem(label)
            item.setData(QtCore.Qt.UserRole, item_id)
            self._parts.addItem(item)

    def _add_to_sequence(self) -> None:
        selected = self._parts.currentItem()
        if not selected:
            return
        for index in range(self._sequence.count()):
            slot = self._sequence.item(index)
            if slot.data(QtCore.Qt.UserRole) is None:
                slot.setData(QtCore.Qt.UserRole, selected.data(QtCore.Qt.UserRole))
                slot.setText(f"{self._drop_labels[index]}: {selected.text()}")
                break
        self._update_state()

    def _remove_last(self) -> None:
        for index in range(self._sequence.count() - 1, -1, -1):
            slot = self._sequence.item(index)
            if slot.data(QtCore.Qt.UserRole) is not None:
                slot.setData(QtCore.Qt.UserRole, None)
                slot.setText(f"{self._drop_labels[index]}: ...")
                break
        self._update_state()

    def _update_state(self) -> None:
        current = []
        filled = 0
        for index in range(self._sequence.count()):
            slot = self._sequence.item(index)
            if slot.data(QtCore.Qt.UserRole) is not None:
                filled += 1
                current.append(slot.data(QtCore.Qt.UserRole))

        correct_ids = [item_id for item_id, _ in self._correct_sequence]
        correct_count = 0
        for idx, item_id in enumerate(current):
            if idx < len(correct_ids) and item_id == correct_ids[idx]:
                correct_count += 1
        self._status.setText(f"{correct_count}/5 bước đúng")
        self._complete.setEnabled(filled == 5 and correct_count == 5)

    def _complete_step(self) -> None:
        self.step_completed.emit(3)
