import QtQuick
import "../../core"

DrivingQuestionBoard {
    drivingQuestion: qsTr("Tại sao đập trống phát ra tiếng vang?")

    subQuestions: [
        { text: qsTr("Tại sao đập mạnh hơn thì tiếng to hơn?"), answered: false },
        { text: qsTr("Âm thanh truyền qua gì?"), answered: false },
        { text: qsTr("Tại sao trong chân không không nghe tiếng?"), answered: false },
        { text: qsTr("Trống to vs trống nhỏ tiếng khác nhau thế nào?"), answered: false },
        { text: qsTr("Sóng âm trông như thế nào?"), answered: false }
    ]
}
