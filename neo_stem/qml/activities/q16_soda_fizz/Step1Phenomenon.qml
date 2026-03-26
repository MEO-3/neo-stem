import QtQuick
import "../../core"

PhenomenonViewer {
    title: qsTr("Hiện tượng: Nước ngọt có ga")
    description: qsTr("Bàn ăn Việt Nam, mở một chai nước ngọt có ga. Quan sát hiện tượng xảy ra — bạn thấy gì?")

    hotspots: [
        { x: 0.5, y: 0.12, label: qsTr("Nắp chai"), detail: qsTr("Khi nắp chai còn đóng, áp suất bên trong cao giữ CO₂ hòa tan trong nước. Mở nắp = giảm áp suất đột ngột, CO₂ bắt đầu thoát ra dạng khí.") },
        { x: 0.55, y: 0.45, label: qsTr("Bọt CO₂"), detail: qsTr("Bọt khí chính là CO₂ thoát ra khỏi nước. Khi áp suất giảm, CO₂ không còn hòa tan được → tạo thành bong bóng nhỏ nổi lên mặt nước.") },
        { x: 0.35, y: 0.25, label: qsTr("Áp suất"), detail: qsTr("Bên trong chai kín, áp suất khoảng 3-4 atm (gấp 3-4 lần áp suất không khí). Áp suất cao ép CO₂ tan vào nước. Mở nắp → áp suất giảm về 1 atm → CO₂ thoát ra.") }
    ]

    sceneComponent: Component {
        Rectangle {
            anchors.fill: parent
            radius: 12; color: "#FFF8E1"

            property bool capOpen: false
            property real foamHeight: capOpen ? 0.35 : 0.0

            // Dining table background
            Rectangle {
                anchors.fill: parent; radius: 12
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#FAFAFA" }
                    GradientStop { position: 0.7; color: "#FFF8E1" }
                    GradientStop { position: 1.0; color: "#D7CCC8" }
                }
            }

            // Table surface
            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width; height: parent.height * 0.25
                color: "#8D6E63"; radius: 4
                Rectangle {
                    width: parent.width; height: 4
                    color: "#6D4C41"
                }
            }

            // Bottle body
            Rectangle {
                id: bottleBody
                anchors.horizontalCenter: parent.horizontalCenter
                y: parent.height * 0.3
                width: 50; height: parent.height * 0.42
                radius: 8; color: "#81C784"
                border.width: 2; border.color: "#388E3C"

                // Label on bottle
                Rectangle {
                    anchors.centerIn: parent
                    width: parent.width - 8; height: 30
                    radius: 4; color: "#C62828"
                    Text {
                        anchors.centerIn: parent
                        text: qsTr("SODA")
                        font.pixelSize: 11; font.bold: true; color: "white"
                    }
                }

                // Liquid inside
                Rectangle {
                    anchors.bottom: parent.bottom; anchors.bottomMargin: 4
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 8; height: parent.height * 0.65
                    radius: 6; color: "#A5D6A7"; opacity: 0.6
                }
            }

            // Bottle neck
            Rectangle {
                id: bottleNeck
                anchors.horizontalCenter: parent.horizontalCenter
                y: parent.height * 0.2
                width: 20; height: parent.height * 0.12
                radius: 4; color: "#81C784"
                border.width: 2; border.color: "#388E3C"
            }

            // Cap (moves when opened)
            Rectangle {
                id: capRect
                anchors.horizontalCenter: parent.horizontalCenter
                y: capOpen ? parent.height * 0.05 : parent.height * 0.17
                width: 24; height: 12; radius: 4
                color: "#F44336"; border.width: 1; border.color: "#C62828"
                rotation: capOpen ? -45 : 0

                Behavior on y { NumberAnimation { duration: 300 } }
                Behavior on rotation { NumberAnimation { duration: 300 } }
            }

            // "Psshh!" effect text
            Text {
                visible: capOpen
                anchors.right: bottleNeck.left; anchors.rightMargin: 8
                y: parent.height * 0.15
                text: qsTr("Psshh!")
                font.pixelSize: 14; font.bold: true; font.italic: true
                color: "#E65100"
                opacity: capOpen ? 1.0 : 0.0

                SequentialAnimation on opacity {
                    running: capOpen; loops: Animation.Infinite
                    NumberAnimation { from: 0.4; to: 1.0; duration: 600 }
                    NumberAnimation { from: 1.0; to: 0.4; duration: 600 }
                }
            }

            // Foam overflow at bottle top
            Rectangle {
                visible: capOpen
                anchors.horizontalCenter: parent.horizontalCenter
                y: parent.height * 0.16
                width: 36; height: 20; radius: 10
                color: "#FFFDE7"; opacity: 0.85

                SequentialAnimation on height {
                    running: capOpen; loops: Animation.Infinite
                    NumberAnimation { from: 10; to: 24; duration: 800 }
                    NumberAnimation { from: 24; to: 10; duration: 800 }
                }
            }

            // Rising bubbles inside bottle
            Repeater {
                model: 8
                Rectangle {
                    property real startX: parent.width * 0.4 + index * 4
                    property real bubbleSize: 4 + (index % 3) * 2
                    property int animDur: 900 + index * 150

                    visible: capOpen
                    x: startX
                    width: bubbleSize; height: bubbleSize; radius: bubbleSize / 2
                    color: "white"; opacity: 0.7

                    SequentialAnimation on y {
                        running: capOpen; loops: Animation.Infinite
                        NumberAnimation { from: parent.height * 0.65; to: parent.height * 0.2; duration: animDur }
                        NumberAnimation { from: parent.height * 0.65; to: parent.height * 0.65; duration: 0 }
                    }
                }
            }

            // Spray bubbles above bottle
            Repeater {
                model: 6
                Rectangle {
                    property real offsetX: (index - 3) * 10
                    property int sprayDur: 700 + index * 100

                    visible: capOpen
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: offsetX
                    width: 6; height: 6; radius: 3
                    color: "#FFFDE7"; opacity: 0.6

                    SequentialAnimation on y {
                        running: capOpen; loops: Animation.Infinite
                        NumberAnimation { from: parent.height * 0.18; to: parent.height * 0.02; duration: sprayDur }
                        NumberAnimation { from: parent.height * 0.18; to: parent.height * 0.18; duration: 0 }
                    }
                }
            }

            // Pressure arrows (visible when closed)
            Repeater {
                model: 3
                visible: !capOpen
                Rectangle {
                    visible: !capOpen
                    x: parent.width * 0.52 + 30
                    y: parent.height * 0.38 + index * 25
                    width: 20; height: 3; radius: 1
                    color: "#1565C0"
                    // Arrow head
                    Rectangle {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        width: 8; height: 8; radius: 1
                        color: "#1565C0"; rotation: 45
                    }
                }
            }

            // Pressure label
            Text {
                visible: !capOpen
                x: parent.width * 0.52 + 55
                y: parent.height * 0.42
                text: qsTr("3 atm")
                font.pixelSize: 11; font.bold: true; color: "#1565C0"
            }

            // Side dishes on table
            // Bowl
            Rectangle {
                x: parent.width * 0.05; anchors.bottom: parent.bottom; anchors.bottomMargin: parent.height * 0.25
                width: 40; height: 20; radius: 20
                color: "#ECEFF1"; border.width: 1; border.color: "#B0BEC5"
            }
            // Chopsticks
            Rectangle {
                x: parent.width * 0.78; anchors.bottom: parent.bottom; anchors.bottomMargin: parent.height * 0.26
                width: 3; height: 35; radius: 1; color: "#8D6E63"; rotation: 15
            }
            Rectangle {
                x: parent.width * 0.82; anchors.bottom: parent.bottom; anchors.bottomMargin: parent.height * 0.26
                width: 3; height: 35; radius: 1; color: "#8D6E63"; rotation: 10
            }

            // Tap to open/close
            MouseArea {
                anchors.fill: parent
                onClicked: { capOpen = !capOpen }
            }

            // Instruction label
            Text {
                anchors.bottom: parent.bottom; anchors.bottomMargin: parent.height * 0.27
                anchors.horizontalCenter: parent.horizontalCenter
                text: capOpen ? qsTr("Nhấn để đóng nắp") : qsTr("Nhấn để mở nắp")
                font.pixelSize: NeoConstants.fontCaption; font.bold: true
                color: "#5D4037"
            }
        }
    }
}
