import QtQuick
import "../../core"

DrivingQuestionBoard {
    drivingQuestion: qsTr("Tại sao sắt để ngoài mưa bị rỉ sét?")

    subQuestions: [
        { text: qsTr("Gỉ sét là gì?"), answered: false },
        { text: qsTr("Tại sao cần nước và không khí?"), answered: false },
        { text: qsTr("Inox có gỉ không?"), answered: false },
        { text: qsTr("Sơn bảo vệ thế nào?"), answered: false },
        { text: qsTr("Đồng có gỉ giống sắt không?"), answered: false }
    ]
}
