import QtQuick
import "../../core"

DrivingQuestionBoard {
    drivingQuestion: qsTr("Tại sao cá sống được dưới nước?")

    subQuestions: [
        { text: qsTr("Cá lấy oxy từ đâu?"), answered: false },
        { text: qsTr("Nước có chứa oxy không?"), answered: false },
        { text: qsTr("Mang cá hoạt động thế nào?"), answered: false },
        { text: qsTr("Tại sao cá chết khi ra khỏi nước?"), answered: false },
        { text: qsTr("Cá voi thở bằng gì?"), answered: false }
    ]
}
