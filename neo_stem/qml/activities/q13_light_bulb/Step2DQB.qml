import QtQuick
import "../../core"

DrivingQuestionBoard {
    drivingQuestion: qsTr("Tại sao bóng đèn phát sáng khi bật công tắc?")

    subQuestions: [
        { text: qsTr("Điện biến thành ánh sáng bằng cách nào?"), answered: false },
        { text: qsTr("Tại sao dây tóc phát sáng khi có dòng điện?"), answered: false },
        { text: qsTr("Đèn LED khác đèn sợi đốt như thế nào?"), answered: false },
        { text: qsTr("Loại đèn nào tốn nhiều điện hơn?"), answered: false },
        { text: qsTr("Tại sao bóng đèn sợi đốt rất nóng?"), answered: false }
    ]
}
