import QtQuick
import "../../core"

DrivingQuestionBoard {
    drivingQuestion: qsTr("Tại sao bóng bay heli bay lên trời?")

    subQuestions: [
        { text: qsTr("Tại sao bóng heli bay lên?"), answered: false },
        { text: qsTr("Heli khác không khí thế nào?"), answered: false },
        { text: qsTr("Bóng bay lên mãi không?"), answered: false },
        { text: qsTr("Tại sao bóng thường rơi?"), answered: false },
        { text: qsTr("Lực gì đẩy bóng lên?"), answered: false }
    ]
}
