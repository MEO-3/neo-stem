import QtQuick
import "../../core"

DrivingQuestionBoard {
    drivingQuestion: qsTr("Tại sao quạt điện quay khi cắm điện?")

    subQuestions: [
        { text: qsTr("Điện đi từ đâu đến quạt?"), answered: false },
        { text: qsTr("Tại sao bật công tắc mới quay?"), answered: false },
        { text: qsTr("Motor biến điện thành gì?"), answered: false },
        { text: qsTr("Tại sao dây điện bằng đồng?"), answered: false },
        { text: qsTr("Quạt sử dụng bao nhiêu điện?"), answered: false }
    ]
}
