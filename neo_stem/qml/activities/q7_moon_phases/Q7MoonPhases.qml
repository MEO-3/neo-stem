import QtQuick
import "../../core"

ActivityBase {
    questionId: 7
    questionTitle: qsTr("Q7: Pha mặt trăng")
    drivingQuestion: qsTr("Tại sao mặt trăng thay đổi hình dạng mỗi đêm?")

    stepComponents: [
        "Step1Phenomenon.qml",
        "Step2DQB.qml",
        "Step3Investigation.qml",
        "Step4Model.qml",
        "Step5Problematize.qml"
    ]
}
