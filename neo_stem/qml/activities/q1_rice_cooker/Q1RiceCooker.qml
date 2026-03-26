import QtQuick
import "../../core"

ActivityBase {
    questionId: 1
    questionTitle: qsTr("Q1: Nồi cơm điện")
    drivingQuestion: qsTr("Tại sao nắp nồi cơm điện rung và có hơi nước?")

    stepComponents: [
        "Step1Phenomenon.qml",
        "Step2DQB.qml",
        "Step3Investigation.qml",
        "Step4Model.qml",
        "Step5Problematize.qml"
    ]
}
