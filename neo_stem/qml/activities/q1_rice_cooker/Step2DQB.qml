import QtQuick
import "../../core"

DrivingQuestionBoard {
    drivingQuestion: qsTr("Tại sao nắp nồi cơm điện rung và có hơi nước?")

    subQuestions: [
        { text: qsTr("Nước biến thành hơi ở nhiệt độ bao nhiêu?"), answered: false },
        { text: qsTr("Tại sao bọt khí nổi lên khi nước sôi?"), answered: false },
        { text: qsTr("Hơi nước có thể nhìn thấy không?"), answered: false },
        { text: qsTr("Tại sao nắp nồi bị đẩy lên?"), answered: false },
        { text: qsTr("Phân tử nước di chuyển như thế nào khi nóng?"), answered: false }
    ]
}
