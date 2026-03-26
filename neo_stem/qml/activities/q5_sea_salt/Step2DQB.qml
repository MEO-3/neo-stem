import QtQuick
import "../../core"

DrivingQuestionBoard {
    drivingQuestion: qsTr("Tại sao muối biển lấy được bằng cách phơi nắng?")

    subQuestions: [
        { text: qsTr("Muối tan trong nước có biến mất không?"), answered: false },
        { text: qsTr("Nước đi đâu khi bay hơi?"), answered: false },
        { text: qsTr("Tại sao muối không bay hơi cùng nước?"), answered: false },
        { text: qsTr("Kết tinh nghĩa là gì?"), answered: false },
        { text: qsTr("Có cách nào khác để tách muối khỏi nước không?"), answered: false }
    ]
}
