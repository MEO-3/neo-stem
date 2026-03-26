import QtQuick
import "../../core"

DrivingQuestionBoard {
    drivingQuestion: qsTr("Tại sao lá cây xanh nhưng hoa có nhiều màu?")

    subQuestions: [
        { text: qsTr("Tại sao lá xanh chứ không đỏ?"), answered: false },
        { text: qsTr("Cây ăn gì để sống?"), answered: false },
        { text: qsTr("Quang hợp cần gì?"), answered: false },
        { text: qsTr("Tại sao lá úa vàng khi thiếu nắng?"), answered: false },
        { text: qsTr("Cây thở ra gì?"), answered: false }
    ]
}
