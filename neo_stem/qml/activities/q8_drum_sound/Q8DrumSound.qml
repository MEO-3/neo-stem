import QtQuick
import "../../core"

ActivityBase {
    questionId: 8
    questionTitle: qsTr("Q8: Tiếng trống")
    drivingQuestion: qsTr("Tại sao đập trống phát ra tiếng vang?")

    stepComponents: [
        "Step1Phenomenon.qml",
        "Step2DQB.qml",
        "Step3Investigation.qml",
        "Step4Model.qml",
        "Step5Problematize.qml"
    ]
}
