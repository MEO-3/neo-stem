import QtQuick
import "../../core"

ActivityBase {
    questionId: 5
    baseUrl: Qt.resolvedUrl(".")
    questionTitle: qsTr("Q5: Muối biển")
    drivingQuestion: qsTr("Tại sao muối biển lấy được bằng cách phơi nắng?")

    stepComponents: [
        "Step1Phenomenon.qml",
        "Step2DQB.qml",
        "Step3Investigation.qml",
        "Step4Model.qml",
        "Step5Problematize.qml"
    ]
}
