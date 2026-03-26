import QtQuick
import "../../core"

DrivingQuestionBoard {
    drivingQuestion: qsTr("Tại sao gõ chai nước khác mực nghe khác nhau?")

    subQuestions: [
        { text: qsTr("Tại sao ít nước tiếng trầm?"), answered: false },
        { text: qsTr("Cái gì rung khi gõ chai?"), answered: false },
        { text: qsTr("Cột không khí là gì?"), answered: false },
        { text: qsTr("Sáo hoạt động giống không?"), answered: false },
        { text: qsTr("Làm sao tạo nốt nhạc chính xác?"), answered: false }
    ]
}
