import QtQuick
import "../../core"

PhenomenonViewer {
    title: qsTr("Hiện tượng: Cầu vồng sau mưa")
    description: qsTr("Quan sát bầu trời nông thôn Việt Nam sau cơn mưa. Mặt trời xuất hiện — bạn thấy gì?")

    hotspots: [
        { x: 0.3, y: 0.6, label: qsTr("Giọt mưa"), detail: qsTr("Hàng triệu giọt mưa nhỏ li ti lơ lửng trong không khí. Mỗi giọt nước hoạt động như một lăng kính tí hon, bẻ cong ánh sáng đi qua nó.") },
        { x: 0.7, y: 0.3, label: qsTr("Tia nắng"), detail: qsTr("Ánh sáng mặt trời trông có vẻ trắng, nhưng thực ra là tổng hợp của tất cả các màu. Khi đi qua giọt nước, các màu bị tách ra.") },
        { x: 0.5, y: 0.4, label: qsTr("Dải 7 màu"), detail: qsTr("Đỏ, cam, vàng, lục, lam, chàm, tím — 7 màu sắp xếp thành vòng cung. Mỗi màu bị bẻ cong một góc khác nhau bởi giọt nước.") }
    ]

    sceneComponent: Component {
        Rectangle {
            anchors.fill: parent
            radius: 12

            // Sky gradient - after rain
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#87CEEB" }
                GradientStop { position: 0.6; color: "#B0E0E6" }
                GradientStop { position: 1.0; color: "#228B22" }
            }

            // Sun
            Rectangle {
                id: sun
                x: parent.width * 0.8
                y: parent.height * 0.15
                width: 60; height: 60; radius: 30
                color: "#FFD700"
                SequentialAnimation on opacity {
                    running: true; loops: Animation.Infinite
                    NumberAnimation { from: 0.8; to: 1.0; duration: 1500; easing.type: Easing.InOutSine }
                    NumberAnimation { from: 1.0; to: 0.8; duration: 1500; easing.type: Easing.InOutSine }
                }
            }

            // Rainbow arc
            Repeater {
                model: [
                    { c: "#FF0000", s: 0.95 },
                    { c: "#FF7F00", s: 0.88 },
                    { c: "#FFFF00", s: 0.81 },
                    { c: "#00FF00", s: 0.74 },
                    { c: "#0000FF", s: 0.67 },
                    { c: "#4B0082", s: 0.60 },
                    { c: "#8B00FF", s: 0.53 }
                ]
                Rectangle {
                    property real scaleFactor: modelData.s
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: parent.height * 0.15
                    width: parent.width * scaleFactor
                    height: parent.width * scaleFactor * 0.5
                    radius: width / 2
                    color: "transparent"
                    border.width: parent.width * 0.02
                    border.color: modelData.c
                    opacity: 0.7
                }
            }

            // Inner sky to cover bottom half of arcs
            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                width: parent.width
                height: parent.height * 0.42
                color: "#228B22"
            }

            // Rain drops fading
            Repeater {
                model: 15
                Rectangle {
                    property real startX: Math.random()
                    property real animDur: 1500 + Math.random() * 1000
                    x: parent.width * startX
                    width: 2; height: 8; radius: 1
                    color: "#90CAF9"
                    opacity: 0.4
                    SequentialAnimation on y {
                        running: true; loops: Animation.Infinite
                        NumberAnimation { from: -10; to: parent.height; duration: animDur }
                    }
                }
            }

            // Ground / village
            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width; height: parent.height * 0.15
                color: "#2E7D32"; radius: 0
                // Simple houses
                Row {
                    anchors.bottom: parent.top; anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 40
                    Repeater {
                        model: 3
                        Rectangle {
                            width: 30; height: 25; color: "#8D6E63"
                            anchors.bottom: parent.bottom
                            Rectangle {
                                anchors.bottom: parent.top; anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width + 6; height: 15
                                color: "#D32F2F"
                                rotation: 0
                            }
                        }
                    }
                }
            }
        }
    }
}
