import QtQuick
import "../../core"

ActivityBase {
    questionId: 12
    questionTitle: qsTr("Q12: Lá cây xanh")
    drivingQuestion: qsTr("Tại sao lá cây xanh nhưng hoa có nhiều màu?")

    stepComponents: [
        "Step1Phenomenon.qml",
        "Step2DQB.qml",
        "Step3Investigation.qml",
        "Step4Model.qml",
        "Step5Problematize.qml"
    ]
}
