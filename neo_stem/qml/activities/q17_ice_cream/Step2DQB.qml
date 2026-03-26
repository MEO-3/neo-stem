import QtQuick
import "../../core"

DrivingQuestionBoard {
    drivingQuestion: qsTr("Tại sao kem tan nhanh ngoài nắng?")

    subQuestions: [
        { text: qsTr("Nhiệt đi từ đâu vào kem?"), answered: false },
        { text: qsTr("Tại sao kem cứng trong tủ đông?"), answered: false },
        { text: qsTr("Nóng chảy là gì?"), answered: false },
        { text: qsTr("Tại sao kem tan nhanh hơn đá?"), answered: false },
        { text: qsTr("Có cách giữ kem lâu hơn?"), answered: false }
    ]
}
