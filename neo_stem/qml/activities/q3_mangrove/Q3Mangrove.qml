import QtQuick
import "../../core"

ActivityBase {
    questionId: 3
    baseUrl: Qt.resolvedUrl(".")
    questionTitle: qsTr("Q3: Rừng ngập mặn")
    drivingQuestion: qsTr("Tại sao cây bần/đước sống được trong nước mặn?")

    stepComponents: [
        "Step1Phenomenon.qml",
        "Step2DQB.qml",
        "Step3Investigation.qml",
        "Step4Model.qml",
        "Step5Problematize.qml"
    ]
}
