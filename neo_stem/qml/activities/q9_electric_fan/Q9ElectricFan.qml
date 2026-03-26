import QtQuick
import "../../core"

ActivityBase {
    questionId: 9
    baseUrl: Qt.resolvedUrl(".")
    questionTitle: qsTr("Q9: Quạt điện")
    drivingQuestion: qsTr("Tại sao quạt điện quay khi cắm điện?")

    stepComponents: [
        "Step1Phenomenon.qml",
        "Step2DQB.qml",
        "Step3Investigation.qml",
        "Step4Model.qml",
        "Step5Problematize.qml"
    ]
}
