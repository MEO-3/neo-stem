import QtQuick
import "../../core"

ActivityBase {
    questionId: 18
    questionTitle: qsTr("Q18: Bóng bay heli")
    drivingQuestion: qsTr("Tại sao bóng bay heli bay lên trời?")

    stepComponents: [
        "Step1Phenomenon.qml",
        "Step2DQB.qml",
        "Step3Investigation.qml",
        "Step4Model.qml",
        "Step5Problematize.qml"
    ]
}
