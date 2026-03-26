import QtQuick
import "../../core"

DrivingQuestionBoard {
    drivingQuestion: qsTr("Tại sao Đà Lạt sáng sớm có sương mù, trưa tan hết?")

    subQuestions: [
        { text: qsTr("Sương mù được tạo ra từ đâu?"), answered: false },
        { text: qsTr("Tại sao sương chỉ xuất hiện khi trời lạnh?"), answered: false },
        { text: qsTr("Ngưng tụ là gì?"), answered: false },
        { text: qsTr("Mặt trời làm tan sương bằng cách nào?"), answered: false },
        { text: qsTr("Tại sao thung lũng có nhiều sương hơn?"), answered: false }
    ]
}
