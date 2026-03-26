import QtQuick
import "../../core"

DrivingQuestionBoard {
    drivingQuestion: qsTr("Tại sao mặt trăng thay đổi hình dạng mỗi đêm?")

    subQuestions: [
        { text: qsTr("Mặt trăng tự phát sáng hay phản xạ ánh sáng?"), answered: false },
        { text: qsTr("Bóng tối trên mặt trăng do đâu?"), answered: false },
        { text: qsTr("Mặt trăng quay quanh Trái Đất bao lâu?"), answered: false },
        { text: qsTr("Tại sao ta luôn thấy cùng một mặt của mặt trăng?"), answered: false },
        { text: qsTr("Trăng tròn có liên quan đến thủy triều không?"), answered: false }
    ]
}
