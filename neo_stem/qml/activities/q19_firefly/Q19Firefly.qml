import QtQuick
import "../../core"

ActivityBase {
    questionId: 19
    baseUrl: Qt.resolvedUrl(".")
    questionTitle: qsTr("Q19: Đom đóm")
    drivingQuestion: qsTr("Tại sao đom đóm phát sáng trong đêm?")

    stepComponents: [
        "Step1Phenomenon.qml",
        "Step2DQB.qml",
        "Step3Investigation.qml",
        "Step4Model.qml",
        "Step5Problematize.qml"
    ]
}
