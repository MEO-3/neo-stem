import QtQuick
import "../../core"

PhenomenonViewer {
    title: qsTr("Hiện tượng: Kem tan chảy")
    description: qsTr("Một ngày nắng nóng, các bạn nhỏ Việt Nam mua kem ốc quế ăn ngoài trời. Chỉ vài phút, kem bắt đầu chảy nhỏ giọt xuống tay. Quan sát xem điều gì đang xảy ra!")

    hotspots: [
        { x: 0.35, y: 0.5, label: qsTr("Kem chảy"), detail: qsTr("Kem đang chuyển từ thể rắn sang thể lỏng. Nhiệt từ không khí nóng truyền vào kem, phá vỡ liên kết tinh thể — đó là hiện tượng NÓNG CHẢY.") },
        { x: 0.7, y: 0.2, label: qsTr("Tia nắng"), detail: qsTr("Mặt trời phát ra bức xạ nhiệt. Ánh nắng truyền nhiệt trực tiếp vào kem, làm nhiệt độ kem tăng nhanh hơn so với trong bóng râm.") },
        { x: 0.5, y: 0.75, label: qsTr("Giọt nước"), detail: qsTr("Kem tan chảy thành chất lỏng nhỏ giọt xuống. Nước và sữa trong kem ở dạng lỏng khi nhiệt độ cao hơn điểm nóng chảy (~-2°C đến 0°C).") }
    ]

    sceneComponent: Component {
        Rectangle {
            anchors.fill: parent
            radius: 12; color: "#FFF3E0"

            // Sky gradient with sun
            Rectangle {
                width: parent.width; height: parent.height * 0.45
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#FF8F00" }
                    GradientStop { position: 0.4; color: "#FFB74D" }
                    GradientStop { position: 1.0; color: "#FFF9C4" }
                }
            }

            // Sun
            Rectangle {
                id: sun
                x: parent.width * 0.75; y: parent.height * 0.05
                width: 60; height: 60; radius: 30
                color: "#FFD600"

                SequentialAnimation on opacity {
                    running: true; loops: Animation.Infinite
                    NumberAnimation { from: 0.8; to: 1.0; duration: 1200; easing.type: Easing.InOutSine }
                    NumberAnimation { from: 1.0; to: 0.8; duration: 1200; easing.type: Easing.InOutSine }
                }
            }

            // Sun rays
            Repeater {
                model: 8
                Rectangle {
                    property real rayAngle: index * 45
                    x: sun.x + 30 + Math.cos(rayAngle * Math.PI / 180) * 38 - 1
                    y: sun.y + 30 + Math.sin(rayAngle * Math.PI / 180) * 38 - 8
                    width: 3; height: 16; radius: 1
                    color: "#FFD600"; rotation: rayAngle + 90
                    opacity: sun.opacity
                }
            }

            // Ground
            Rectangle {
                y: parent.height * 0.7; width: parent.width; height: parent.height * 0.3
                color: "#A5D6A7"; radius: 0

                Rectangle {
                    anchors.bottom: parent.bottom; width: parent.width; height: parent.height * 0.5
                    color: "#81C784"
                }
            }

            // Ice cream cone
            Item {
                id: iceCreamCone
                anchors.horizontalCenter: parent.horizontalCenter
                y: parent.height * 0.25
                width: 70; height: 120

                // Cone (triangle shape via Canvas)
                Canvas {
                    anchors.fill: parent
                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        ctx.beginPath()
                        ctx.moveTo(width * 0.2, height * 0.4)
                        ctx.lineTo(width * 0.5, height)
                        ctx.lineTo(width * 0.8, height * 0.4)
                        ctx.closePath()
                        ctx.fillStyle = "#D4A056"
                        ctx.fill()
                        // Waffle pattern
                        ctx.strokeStyle = "#C08840"
                        ctx.lineWidth = 1
                        for (var i = 0; i < 4; i++) {
                            var yy = height * (0.45 + i * 0.12)
                            ctx.beginPath()
                            ctx.moveTo(width * 0.25, yy)
                            ctx.lineTo(width * 0.75, yy)
                            ctx.stroke()
                        }
                    }
                }

                // Ice cream scoop
                Rectangle {
                    id: scoop
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: parent.height * 0.05
                    width: 50; height: 45; radius: 25
                    color: "#F8BBD0"

                    SequentialAnimation on height {
                        running: true; loops: Animation.Infinite
                        NumberAnimation { from: 45; to: 35; duration: 4000; easing.type: Easing.InQuad }
                        NumberAnimation { from: 35; to: 45; duration: 2000; easing.type: Easing.OutQuad }
                    }
                }

                // Dripping animation
                Repeater {
                    model: 3
                    Rectangle {
                        id: drip
                        property real startX: parent.width * (0.3 + index * 0.2)
                        property real dripStartY: parent.height * 0.42
                        property real dripEndY: parent.height * 1.1
                        x: startX; width: 5; height: 8; radius: 3
                        color: "#F48FB1"

                        property int dripDuration: 1800 + index * 600

                        SequentialAnimation on y {
                            running: true; loops: Animation.Infinite
                            NumberAnimation { from: drip.dripStartY; to: drip.dripEndY; duration: drip.dripDuration; easing.type: Easing.InQuad }
                            NumberAnimation { from: drip.dripStartY; to: drip.dripStartY; duration: 0 }
                        }

                        SequentialAnimation on opacity {
                            running: true; loops: Animation.Infinite
                            NumberAnimation { from: 0.0; to: 1.0; duration: 300 }
                            NumberAnimation { from: 1.0; to: 1.0; duration: drip.dripDuration - 600 }
                            NumberAnimation { from: 1.0; to: 0.0; duration: 300 }
                            NumberAnimation { from: 0.0; to: 0.0; duration: 0 }
                        }
                    }
                }
            }

            // Comparison: frozen vs melted
            Row {
                anchors.bottom: parent.bottom; anchors.bottomMargin: 8
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20

                Column {
                    spacing: 2
                    Rectangle {
                        width: 30; height: 30; radius: 15; color: "#CE93D8"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        text: qsTr("Kem cứng")
                        font.pixelSize: 11; color: "#4A148C"; font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        text: qsTr("-18°C")
                        font.pixelSize: 10; color: "#7B1FA2"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Text {
                    text: qsTr("→")
                    font.pixelSize: 20; color: "#FF6F00"
                    anchors.verticalCenter: parent.verticalCenter
                }

                Column {
                    spacing: 2
                    Rectangle {
                        width: 30; height: 20; radius: 10; color: "#F48FB1"
                        anchors.horizontalCenter: parent.horizontalCenter

                        Rectangle {
                            anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter
                            width: 6; height: 10; radius: 3; color: "#F48FB1"
                        }
                    }
                    Text {
                        text: qsTr("Kem chảy")
                        font.pixelSize: 11; color: "#880E4F"; font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        text: qsTr("35°C")
                        font.pixelSize: 10; color: "#AD1457"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            // Label
            Text {
                anchors.top: parent.top; anchors.topMargin: 6
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Kem tan chảy dưới nắng nóng")
                font.pixelSize: NeoConstants.fontCaption; color: "#BF360C"; font.bold: true
            }
        }
    }
}
