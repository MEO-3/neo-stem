import QtQuick
import "../../core"

DrivingQuestionBoard {
    drivingQuestion: qsTr("Tại sao nam châm hút đinh sắt nhưng không hút nhôm?")

    subQuestions: [
        { text: qsTr("Tại sao nam châm chỉ hút một số vật?"), answered: false },
        { text: qsTr("Nam châm có mấy cực?"), answered: false },
        { text: qsTr("Hai nam châm gần nhau thì sao?"), answered: false },
        { text: qsTr("Có thể tắt nam châm không?"), answered: false },
        { text: qsTr("La bàn hoạt động nhờ gì?"), answered: false }
    ]
}
