import QtQuick
import "../../core"

ActivityBase {
    questionId: 10
    baseUrl: Qt.resolvedUrl(".")
    questionTitle: qsTr("Q10: Nam châm")
    drivingQuestion: qsTr("Tại sao nam châm hút đinh sắt nhưng không hút nhôm?")

    stepComponents: [
        "Step1Phenomenon.qml",
        "Step2DQB.qml",
        "Step3Investigation.qml",
        "Step4Model.qml",
        "Step5Problematize.qml"
    ]
}
