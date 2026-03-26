import QtQuick
import "../../core"

ActivityBase {
    questionId: 15
    questionTitle: qsTr("Q15: Cá thở dưới nước")
    drivingQuestion: qsTr("Tại sao cá sống được dưới nước?")

    stepComponents: [
        "Step1Phenomenon.qml",
        "Step2DQB.qml",
        "Step3Investigation.qml",
        "Step4Model.qml",
        "Step5Problematize.qml"
    ]
}
