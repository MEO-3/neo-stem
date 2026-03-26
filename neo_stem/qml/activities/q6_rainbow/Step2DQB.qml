import QtQuick
import "../../core"

DrivingQuestionBoard {
    drivingQuestion: qsTr("Tại sao cầu vồng xuất hiện sau cơn mưa?")

    subQuestions: [
        { text: qsTr("Ánh sáng trắng có phải một màu duy nhất?"), answered: false },
        { text: qsTr("Giọt nước làm gì với ánh sáng?"), answered: false },
        { text: qsTr("Tại sao cầu vồng cong?"), answered: false },
        { text: qsTr("Có thể tạo cầu vồng nhân tạo không?"), answered: false },
        { text: qsTr("Tại sao chỉ thấy cầu vồng sau mưa?"), answered: false }
    ]
}
