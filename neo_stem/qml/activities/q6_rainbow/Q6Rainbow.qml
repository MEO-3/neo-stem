import QtQuick
import "../../core"

ActivityBase {
    questionId: 6
    questionTitle: qsTr("Q6: Cầu vồng")
    drivingQuestion: qsTr("Tại sao cầu vồng xuất hiện sau cơn mưa?")

    stepComponents: [
        "Step1Phenomenon.qml",
        "Step2DQB.qml",
        "Step3Investigation.qml",
        "Step4Model.qml",
        "Step5Problematize.qml"
    ]
}
