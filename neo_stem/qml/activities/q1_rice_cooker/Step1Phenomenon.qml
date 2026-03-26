import QtQuick
import "../../core"

PhenomenonViewer {
    title: qsTr("Hiện tượng: Nồi cơm điện")
    description: qsTr("Quan sát nhà bếp Việt Nam. Nồi cơm đang nấu — bạn thấy gì?")

    hotspots: [
        { x: 0.5, y: 0.25, label: qsTr("Hơi nước"), detail: qsTr("Hơi nước bốc lên từ khe nắp nồi. Đó là nước ở dạng khí — mắt thường không thấy hơi nước thật sự, chỉ thấy khi nó ngưng tụ thành giọt nhỏ trong không khí.") },
        { x: 0.5, y: 0.45, label: qsTr("Nắp nồi rung"), detail: qsTr("Nắp nồi liên tục nhấc lên hạ xuống. Áp suất hơi nước bên trong nồi đẩy nắp lên, rồi thoát ra ngoài, nắp hạ xuống lại.") },
        { x: 0.5, y: 0.7, label: qsTr("Nước sôi bên trong"), detail: qsTr("Bên trong nồi, nước đang sôi sùng sục ở 100°C. Bọt khí nổi lên liên tục — đó là hơi nước hình thành từ đáy nồi.") }
    ]

    sceneComponent: Component {
        Rectangle {
            anchors.fill: parent
            radius: 12
            color: "#FFF3E0"

            Row {
                anchors.top: parent.top; anchors.left: parent.left; anchors.right: parent.right
                height: parent.height * 0.2; spacing: 2
                Repeater { model: 12; Rectangle { width: (parent.width - 22) / 12; height: parent.height; color: index % 2 === 0 ? "#E3F2FD" : "#BBDEFB" } }
            }

            Rectangle {
                anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right
                height: parent.height * 0.35; color: "#8D6E63"; radius: 8
                Rectangle { anchors.top: parent.top; anchors.left: parent.left; anchors.right: parent.right; height: 8; color: "#A1887F" }
            }

            Rectangle {
                id: cookerBody
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom; anchors.bottomMargin: parent.height * 0.35 - 10
                width: parent.width * 0.35; height: parent.height * 0.3
                radius: width * 0.15; color: "#ECEFF1"; border.width: 2; border.color: "#B0BEC5"; z: 2

                Rectangle {
                    anchors.bottom: parent.bottom; anchors.bottomMargin: 15; anchors.horizontalCenter: parent.horizontalCenter
                    width: 12; height: 12; radius: 6; color: "#E53935"
                    SequentialAnimation on opacity {
                        running: true; loops: Animation.Infinite
                        NumberAnimation { from: 1; to: 0.3; duration: 500 }
                        NumberAnimation { from: 0.3; to: 1; duration: 500 }
                    }
                }

                Rectangle {
                    anchors.top: parent.top; anchors.topMargin: 5; anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width * 0.85; height: parent.height * 0.3; radius: width * 0.1; color: "#78909C"
                    Rectangle {
                        anchors.fill: parent; anchors.margins: 4; radius: parent.radius - 4; color: "#B3E5FC"
                        ParticleEffects { anchors.fill: parent; effectType: "bubbles"; running: true; intensity: 0.8 }
                    }
                }
            }

            Rectangle {
                id: lid
                anchors.horizontalCenter: cookerBody.horizontalCenter; anchors.bottom: cookerBody.top; anchors.bottomMargin: -5
                width: cookerBody.width * 1.05; height: 25; radius: 12
                color: "#CFD8DC"; border.width: 2; border.color: "#90A4AE"; z: 3
                Rectangle { anchors.horizontalCenter: parent.horizontalCenter; anchors.bottom: parent.top; width: 30; height: 12; radius: 6; color: "#78909C" }
                SequentialAnimation on anchors.bottomMargin {
                    running: true; loops: Animation.Infinite
                    NumberAnimation { from: -5; to: -11; duration: 150; easing.type: Easing.OutQuad }
                    NumberAnimation { from: -11; to: -5; duration: 100; easing.type: Easing.InQuad }
                    PauseAnimation { duration: 500 }
                }
                SequentialAnimation on rotation {
                    running: true; loops: Animation.Infinite
                    NumberAnimation { from: -1; to: 1; duration: 100 }
                    NumberAnimation { from: 1; to: -1; duration: 100 }
                    PauseAnimation { duration: 400 }
                }
            }

            ParticleEffects {
                anchors.horizontalCenter: cookerBody.horizontalCenter; anchors.bottom: cookerBody.top
                width: cookerBody.width; height: parent.height * 0.4
                effectType: "steam"; running: true; intensity: 0.7; particleColor: "#E0E0E0"; z: 4
            }
        }
    }
}
