import QtQuick
import "../../core"

ActivityBase {
    questionId: 20
    baseUrl: Qt.resolvedUrl(".")
    questionTitle: qsTr("Q20: Chai nước xylophone")
    drivingQuestion: qsTr("Tại sao gõ chai nước khác mực nghe khác nhau?")

    stepComponents: [
        "Step1Phenomenon.qml",
        "Step2DQB.qml",
        "Step3Investigation.qml",
        "Step4Model.qml",
        "Step5Problematize.qml"
    ]
}
