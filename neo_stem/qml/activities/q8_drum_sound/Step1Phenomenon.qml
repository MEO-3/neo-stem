import QtQuick
import "../../core"

PhenomenonViewer {
    title: qsTr("Hiện tượng: Đập trống phát ra tiếng")
    description: qsTr("Quan sát trống trường học Việt Nam. Khi đập trống — bạn thấy và nghe gì?")

    hotspots: [
        { x: 0.5, y: 0.4, label: qsTr("Mặt trống rung"), detail: qsTr("Khi đập, mặt trống rung lên xuống rất nhanh. Hạt gạo đặt trên mặt trống sẽ nhảy lên — chứng tỏ mặt trống đang rung động!") },
        { x: 0.3, y: 0.5, label: qsTr("Sóng không khí"), detail: qsTr("Mặt trống rung đẩy không khí xung quanh, tạo ra sóng nén và giãn lan tỏa ra mọi hướng. Đó chính là sóng âm thanh.") },
        { x: 0.75, y: 0.55, label: qsTr("Tai nghe"), detail: qsTr("Sóng âm đến tai, làm màng nhĩ rung theo cùng tần số. Não bộ chuyển rung động thành âm thanh mà ta nghe thấy.") }
    ]

    sceneComponent: Component {
        Rectangle {
            anchors.fill: parent
            radius: 12
            color: "#FFF8E1"

            // Drum body
            Rectangle {
                id: drumBody
                anchors.centerIn: parent
                width: Math.min(parent.width * 0.4, 200)
                height: width * 0.6
                radius: 8
                color: "#D32F2F"
                border.width: 3; border.color: "#B71C1C"

                // Drum pattern
                Row {
                    anchors.centerIn: parent; spacing: 8
                    Repeater {
                        model: 3
                        Rectangle { width: 4; height: drumBody.height * 0.5; radius: 2; color: "#FFD54F" }
                    }
                }
            }

            // Drum skin (top)
            Rectangle {
                id: drumSkin
                anchors.horizontalCenter: drumBody.horizontalCenter
                anchors.bottom: drumBody.top; anchors.bottomMargin: -4
                width: drumBody.width + 10; height: 12
                radius: 6; color: "#FFF9C4"
                border.width: 2; border.color: "#F9A825"

                SequentialAnimation on scale {
                    running: true; loops: Animation.Infinite
                    NumberAnimation { from: 1.0; to: 1.03; duration: 80 }
                    NumberAnimation { from: 1.03; to: 0.97; duration: 80 }
                    NumberAnimation { from: 0.97; to: 1.0; duration: 80 }
                    PauseAnimation { duration: 300 }
                }
            }

            // Drum sticks
            Rectangle {
                x: drumBody.x + drumBody.width * 0.3
                y: drumBody.y - 40
                width: 6; height: 50; radius: 3
                color: "#8D6E63"; rotation: -15
                Rectangle {
                    anchors.top: parent.top; anchors.horizontalCenter: parent.horizontalCenter
                    width: 12; height: 12; radius: 6; color: "#5D4037"
                }

                SequentialAnimation on rotation {
                    running: true; loops: Animation.Infinite
                    NumberAnimation { from: -15; to: -30; duration: 100 }
                    NumberAnimation { from: -30; to: -15; duration: 100 }
                    PauseAnimation { duration: 400 }
                }
            }

            // Rice grains jumping
            Repeater {
                model: 8
                Rectangle {
                    property real gx: 0.35 + Math.random() * 0.3
                    property real jumpDur: 200 + Math.random() * 200
                    x: parent.width * gx
                    width: 4; height: 3; radius: 1
                    color: "#F5F5DC"
                    SequentialAnimation on y {
                        running: true; loops: Animation.Infinite
                        NumberAnimation { from: drumSkin.y - 5; to: drumSkin.y - 20 - Math.random() * 15; duration: jumpDur }
                        NumberAnimation { from: drumSkin.y - 20 - Math.random() * 15; to: drumSkin.y - 5; duration: jumpDur }
                        PauseAnimation { duration: 100 }
                    }
                }
            }

            // Sound waves
            Repeater {
                model: 3
                Rectangle {
                    property real waveDur: 1500 + index * 500
                    anchors.centerIn: drumBody
                    width: drumBody.width * (1.5 + index * 0.5)
                    height: width; radius: width / 2
                    color: "transparent"
                    border.width: 2; border.color: "#FF9800"

                    SequentialAnimation on opacity {
                        running: true; loops: Animation.Infinite
                        NumberAnimation { from: 0.6; to: 0.0; duration: waveDur }
                        PauseAnimation { duration: 200 }
                    }
                    SequentialAnimation on scale {
                        running: true; loops: Animation.Infinite
                        NumberAnimation { from: 1.0; to: 2.0; duration: waveDur }
                        PauseAnimation { duration: 200 }
                    }
                }
            }
        }
    }
}
