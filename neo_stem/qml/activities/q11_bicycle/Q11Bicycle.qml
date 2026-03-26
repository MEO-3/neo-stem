import QtQuick
import "../../core"

ActivityBase {
    questionId: 11
    baseUrl: Qt.resolvedUrl(".")
    questionTitle: qsTr("Q11: Xe đạp xuống dốc")
    drivingQuestion: qsTr("Tại sao xe đạp đi nhanh hơn khi xuống dốc?")

    stepComponents: [
        "Step1Phenomenon.qml",
        "Step2DQB.qml",
        "Step3Investigation.qml",
        "Step4Model.qml",
        "Step5Problematize.qml"
    ]
}
