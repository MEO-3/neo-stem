import QtQuick
import "../../core"

PhenomenonViewer {
    title: qsTr("Hiện tượng: Cá thở dưới nước")
    description: qsTr("Quan sát ao cá Việt Nam. Cá bơi, mở miệng đóng miệng liên tục — bạn thấy gì?")

    hotspots: [
        { x: 0.4, y: 0.45, label: qsTr("Miệng cá"), detail: qsTr("Cá liên tục mở miệng hút nước vào. Nước chảy qua miệng, qua mang, rồi ra ngoài. Đây là cách cá 'hít thở' — lấy oxy từ nước.") },
        { x: 0.55, y: 0.4, label: qsTr("Mang cá"), detail: qsTr("Mang cá có hàng nghìn mao mạch nhỏ li ti, màu đỏ do giàu máu. Khi nước chảy qua, mao mạch hấp thụ oxy hòa tan trong nước.") },
        { x: 0.6, y: 0.6, label: qsTr("Bọt khí"), detail: qsTr("Bọt khí nhỏ trong nước chứa oxy hòa tan. Oxy từ không khí hòa vào nước ở bề mặt. Cây thủy sinh cũng thải O₂ vào nước qua quang hợp.") }
    ]

    sceneComponent: Component {
        Rectangle {
            anchors.fill: parent; radius: 12
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#B3E5FC" }
                GradientStop { position: 1.0; color: "#01579B" }
            }

            // Water plants swaying
            Repeater {
                model: 4
                Rectangle {
                    property real px: 0.1 + index * 0.25
                    property real baseRotation: -5 + index * 3
                    property real tipRotation: 5 + index * 3
                    x: parent.width * px; y: parent.height * 0.6
                    width: 6; height: parent.height * 0.35; radius: 3; color: "#2E7D32"
                    rotation: baseRotation
                    SequentialAnimation on rotation {
                        running: true; loops: Animation.Infinite
                        NumberAnimation { from: baseRotation; to: tipRotation; duration: 2000; easing.type: Easing.InOutSine }
                        NumberAnimation { from: tipRotation; to: baseRotation; duration: 2000; easing.type: Easing.InOutSine }
                    }
                }
            }

            // Fish body
            Item {
                id: fish
                width: 80; height: 40
                y: parent.height * 0.35

                property real swimLeft: parent.width * 0.3
                property real swimRight: parent.width * 0.6

                SequentialAnimation on x {
                    running: true; loops: Animation.Infinite
                    NumberAnimation { from: fish.swimLeft; to: fish.swimRight; duration: 4000; easing.type: Easing.InOutSine }
                    NumberAnimation { from: fish.swimRight; to: fish.swimLeft; duration: 4000; easing.type: Easing.InOutSine }
                }

                // Body
                Rectangle { width: 60; height: 30; radius: 15; color: "#FF7043"; x: 10; y: 5 }
                // Tail
                Rectangle { width: 20; height: 20; radius: 3; color: "#FF5722"; x: 0; y: 10; rotation: 45 }
                // Eye
                Rectangle {
                    x: 55; y: 12; width: 8; height: 8; radius: 4; color: "white"
                    Rectangle { x: 3; y: 2; width: 4; height: 4; radius: 2; color: "#333" }
                }
                // Mouth animation
                Rectangle {
                    id: mouth; x: 65; y: 18; width: 6; height: 4; radius: 2; color: "#D32F2F"
                    SequentialAnimation on height {
                        running: true; loops: Animation.Infinite
                        NumberAnimation { from: 2; to: 8; duration: 300 }
                        NumberAnimation { from: 8; to: 2; duration: 300 }
                        PauseAnimation { duration: 400 }
                    }
                }
                // Gill slit
                Rectangle { x: 48; y: 10; width: 2; height: 18; radius: 1; color: "#E53935"; opacity: 0.7 }
            }

            // Bubbles rising
            Repeater {
                model: 8
                Rectangle {
                    id: bubble
                    property real bx: [0.25, 0.35, 0.42, 0.55, 0.62, 0.70, 0.30, 0.50][index]
                    property int bDur: [2200, 3000, 2600, 3400, 2800, 3200, 2400, 3600][index]
                    property real bSize: [5, 7, 4, 8, 6, 5, 7, 4][index]
                    property real startY: parent.height * 0.8
                    property real endY: parent.height * 0.05
                    x: parent.width * bx; width: bSize; height: bSize; radius: bSize / 2
                    color: "transparent"; border.width: 1; border.color: "white"; opacity: 0.5
                    SequentialAnimation on y {
                        running: true; loops: Animation.Infinite
                        NumberAnimation { from: bubble.startY; to: bubble.endY; duration: bubble.bDur }
                    }
                }
            }

            // Sandy bottom
            Rectangle {
                anchors.bottom: parent.bottom; width: parent.width
                height: parent.height * 0.08; color: "#8D6E63"
            }

            // Bottom label
            Text {
                anchors.bottom: parent.bottom; anchors.bottomMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Ao cá — Cá mở đóng miệng liên tục để hút nước qua mang")
                font.pixelSize: NeoConstants.fontCaption; color: "white"; font.bold: true
            }
        }
    }
}
