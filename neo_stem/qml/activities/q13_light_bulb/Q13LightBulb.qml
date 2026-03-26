import QtQuick
import "../../core"

ActivityBase {
    questionId: 13
    questionTitle: qsTr("Q13: Bóng đèn")
    drivingQuestion: qsTr("Tại sao bóng đèn phát sáng khi bật công tắc?")

    stepComponents: [
        "Step1Phenomenon.qml",
        "Step2DQB.qml",
        "Step3Investigation.qml",
        "Step4Model.qml",
        "Step5Problematize.qml"
    ]
}
