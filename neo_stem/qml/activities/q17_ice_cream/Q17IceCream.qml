import QtQuick
import "../../core"

ActivityBase {
    questionId: 17
    baseUrl: Qt.resolvedUrl(".")
    questionTitle: qsTr("Q17: Kem tan chảy")
    drivingQuestion: qsTr("Tại sao kem tan nhanh ngoài nắng?")

    stepComponents: [
        "Step1Phenomenon.qml",
        "Step2DQB.qml",
        "Step3Investigation.qml",
        "Step4Model.qml",
        "Step5Problematize.qml"
    ]
}
