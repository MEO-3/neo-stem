import QtQuick
import "../../core"

DrivingQuestionBoard {
    drivingQuestion: qsTr("Tại sao mở chai nước ngọt có ga bọt phun ra?")

    subQuestions: [
        { text: qsTr("Bọt khí là gì?"), answered: false },
        { text: qsTr("Khí từ đâu ra?"), answered: false },
        { text: qsTr("Tại sao lắc thì phun nhiều?"), answered: false },
        { text: qsTr("Nước nóng hay lạnh có ga nhiều hơn?"), answered: false },
        { text: qsTr("Tại sao để lâu hết ga?"), answered: false }
    ]
}
