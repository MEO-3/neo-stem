import QtQuick
import "../../core"

DrivingQuestionBoard {
    drivingQuestion: qsTr("Tại sao bên ngoài ly đá có giọt nước bám?")

    subQuestions: [
        { text: qsTr("Nước bên ngoài ly đến từ đâu?"), answered: false },
        { text: qsTr("Điểm sương là gì?"), answered: false },
        { text: qsTr("Độ ẩm không khí ảnh hưởng thế nào?"), answered: false },
        { text: qsTr("Tại sao chỉ có giọt nước khi ly lạnh?"), answered: false },
        { text: qsTr("Ngưng tụ xảy ra ở điều kiện nào?"), answered: false }
    ]
}
