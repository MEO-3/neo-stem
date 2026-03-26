import QtQuick
import "../../core"

ActivityBase {
    questionId: 4
    questionTitle: qsTr("Q4: Giọt nước trên ly đá")
    drivingQuestion: qsTr("Tại sao bên ngoài ly đá có giọt nước bám?")

    stepComponents: [
        "Step1Phenomenon.qml",
        "Step2DQB.qml",
        "Step3Investigation.qml",
        "Step4Model.qml",
        "Step5Problematize.qml"
    ]
}
