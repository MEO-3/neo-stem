import QtQuick
import "../../core"

DrivingQuestionBoard {
    drivingQuestion: qsTr("Tại sao đom đóm phát sáng trong đêm?")

    subQuestions: [
        { text: qsTr("Đom đóm dùng điện không?"), answered: false },
        { text: qsTr("Tại sao ánh sáng không nóng?"), answered: false },
        { text: qsTr("Chất gì tạo ánh sáng?"), answered: false },
        { text: qsTr("Đom đóm phát sáng để làm gì?"), answered: false },
        { text: qsTr("Có sinh vật khác phát sáng không?"), answered: false }
    ]
}
