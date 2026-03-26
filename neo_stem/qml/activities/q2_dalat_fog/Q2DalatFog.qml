import QtQuick
import "../../core"

ActivityBase {
    questionId: 2
    questionTitle: qsTr("Q2: Sương mù Đà Lạt")
    drivingQuestion: qsTr("Tại sao Đà Lạt sáng sớm có sương mù, trưa tan hết?")

    stepComponents: [
        "Step1Phenomenon.qml",
        "Step2DQB.qml",
        "Step3Investigation.qml",
        "Step4Model.qml",
        "Step5Problematize.qml"
    ]
}
