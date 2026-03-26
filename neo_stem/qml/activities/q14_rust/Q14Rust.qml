import QtQuick
import "../../core"

ActivityBase {
    questionId: 14
    baseUrl: Qt.resolvedUrl(".")
    questionTitle: qsTr("Q14: Rỉ sét")
    drivingQuestion: qsTr("Tại sao sắt để ngoài mưa bị rỉ sét?")

    stepComponents: [
        "Step1Phenomenon.qml",
        "Step2DQB.qml",
        "Step3Investigation.qml",
        "Step4Model.qml",
        "Step5Problematize.qml"
    ]
}
