import QtQuick
import "../../core"

ActivityBase {
    questionId: 16
    questionTitle: qsTr("Q16: Nước ngọt có ga")
    drivingQuestion: qsTr("Tại sao mở chai nước ngọt có ga bọt phun ra?")

    stepComponents: [
        "Step1Phenomenon.qml",
        "Step2DQB.qml",
        "Step3Investigation.qml",
        "Step4Model.qml",
        "Step5Problematize.qml"
    ]
}
