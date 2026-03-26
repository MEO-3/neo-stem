import QtQuick
import "../../core"

PhenomenonViewer {
    title: qsTr("Hiện tượng: Bóng bay heli")
    description: qsTr("Tại lễ hội Việt Nam, bóng bay heli bay lên trời, còn bóng thường thì rơi xuống — bạn thấy gì?")

    hotspots: [
        { x: 0.3, y: 0.2, label: qsTr("Bóng heli bay lên"), detail: qsTr("Bóng chứa khí heli nhẹ hơn không khí xung quanh. Mật độ heli (0.164 kg/m³) nhỏ hơn nhiều so với không khí (1.225 kg/m³). Lực đẩy Archimedes lớn hơn trọng lượng bóng, nên bóng bay lên.") },
        { x: 0.65, y: 0.6, label: qsTr("Bóng thường rơi"), detail: qsTr("Bóng thổi bằng miệng chứa không khí (có thêm CO₂ từ hơi thở). Mật độ khí bên trong bằng hoặc lớn hơn không khí, cộng thêm trọng lượng vỏ cao su, nên bóng rơi xuống.") },
        { x: 0.35, y: 0.45, label: qsTr("Dây buộc"), detail: qsTr("Dây buộc giữ bóng heli không bay mất. Nếu buông dây, bóng heli bay lên cao cho đến khi áp suất ngoài giảm, bóng nở ra và vỡ ở độ cao khoảng 8-10 km.") }
    ]

    sceneComponent: Component {
        Rectangle {
            anchors.fill: parent
            radius: 12; color: "#E3F2FD"

            // Sky gradient
            Rectangle {
                width: parent.width; height: parent.height * 0.75
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#64B5F6" }
                    GradientStop { position: 1.0; color: "#BBDEFB" }
                }
            }

            // Clouds
            Repeater {
                model: [
                    { cx: 0.15, cy: 0.08, sz: 40 },
                    { cx: 0.8, cy: 0.12, sz: 35 }
                ]
                Rectangle {
                    x: parent.width * modelData.cx; y: parent.height * modelData.cy
                    width: modelData.sz * 1.8; height: modelData.sz
                    radius: modelData.sz / 2; color: "#FFFFFF"; opacity: 0.7
                }
            }

            // Ground / Festival area
            Rectangle {
                anchors.bottom: parent.bottom; width: parent.width
                height: parent.height * 0.25; color: "#66BB6A"; radius: 8
                Rectangle {
                    anchors.top: parent.top; width: parent.width; height: 4; color: "#43A047"
                }
            }

            // Festival banner
            Rectangle {
                x: parent.width * 0.3; y: parent.height * 0.7
                width: parent.width * 0.4; height: 22; radius: 4
                color: "#E53935"; opacity: 0.85
                Text {
                    anchors.centerIn: parent
                    text: qsTr("Lễ Hội Bóng Bay")
                    font.pixelSize: 11; font.bold: true; color: "white"
                }
            }

            // String line from hand to helium balloon
            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    ctx.beginPath()
                    ctx.moveTo(width * 0.22, height * 0.65)
                    ctx.bezierCurveTo(width * 0.24, height * 0.45, width * 0.28, height * 0.35, width * 0.30, height * 0.22)
                    ctx.strokeStyle = "#757575"
                    ctx.lineWidth = 1.2
                    ctx.stroke()
                }
            }

            // Helium balloon 1 (red, rising)
            Rectangle {
                id: heliumBalloon1
                x: parent.width * 0.28; width: 36; height: 42
                radius: 18; color: "#EF5350"

                SequentialAnimation on y {
                    running: true; loops: Animation.Infinite
                    NumberAnimation { from: parent.height * 0.18; to: parent.height * 0.10; duration: 2500; easing.type: Easing.InOutSine }
                    NumberAnimation { from: parent.height * 0.10; to: parent.height * 0.18; duration: 2500; easing.type: Easing.InOutSine }
                }

                // Balloon knot
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 6; height: 6; radius: 3; color: "#C62828"
                }

                // Shine
                Rectangle {
                    x: 8; y: 8; width: 8; height: 12; radius: 4
                    color: "white"; opacity: 0.4; rotation: -20
                }
            }

            // Helium balloon 2 (blue, rising freely)
            Rectangle {
                id: heliumBalloon2
                x: parent.width * 0.48; width: 32; height: 38
                radius: 16; color: "#42A5F5"

                SequentialAnimation on y {
                    running: true; loops: Animation.Infinite
                    NumberAnimation { from: parent.height * 0.14; to: parent.height * 0.04; duration: 3200; easing.type: Easing.InOutSine }
                    NumberAnimation { from: parent.height * 0.04; to: parent.height * 0.14; duration: 3200; easing.type: Easing.InOutSine }
                }

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 5; height: 5; radius: 2.5; color: "#1565C0"
                }

                Rectangle {
                    x: 7; y: 6; width: 7; height: 10; radius: 3.5
                    color: "white"; opacity: 0.35; rotation: -20
                }
            }

            // Helium balloon 3 (yellow, with string)
            Rectangle {
                id: heliumBalloon3
                x: parent.width * 0.12; width: 30; height: 35
                radius: 15; color: "#FFEE58"

                SequentialAnimation on y {
                    running: true; loops: Animation.Infinite
                    NumberAnimation { from: parent.height * 0.22; to: parent.height * 0.16; duration: 2800; easing.type: Easing.InOutSine }
                    NumberAnimation { from: parent.height * 0.16; to: parent.height * 0.22; duration: 2800; easing.type: Easing.InOutSine }
                }

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 5; height: 5; radius: 2.5; color: "#F9A825"
                }

                Rectangle {
                    x: 6; y: 6; width: 6; height: 9; radius: 3
                    color: "white"; opacity: 0.35; rotation: -15
                }
            }

            // Regular balloon (falling / on ground)
            Rectangle {
                id: regularBalloon1
                x: parent.width * 0.62; width: 32; height: 38
                radius: 16; color: "#AB47BC"; opacity: 0.8

                SequentialAnimation on y {
                    running: true; loops: Animation.Infinite
                    NumberAnimation { from: parent.height * 0.55; to: parent.height * 0.60; duration: 2000; easing.type: Easing.InOutSine }
                    NumberAnimation { from: parent.height * 0.60; to: parent.height * 0.55; duration: 2000; easing.type: Easing.InOutSine }
                }

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 5; height: 5; radius: 2.5; color: "#7B1FA2"
                }
            }

            // Regular balloon 2 (on ground)
            Rectangle {
                x: parent.width * 0.78; y: parent.height * 0.62
                width: 28; height: 34; radius: 14
                color: "#FF7043"; opacity: 0.75

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    width: 5; height: 5; radius: 2.5; color: "#D84315"
                }
            }

            // Person (stick figure holding string)
            Rectangle {
                x: parent.width * 0.19; y: parent.height * 0.58
                width: 14; height: 14; radius: 7; color: "#5D4037"
            }
            Rectangle {
                x: parent.width * 0.20; y: parent.height * 0.65
                width: 10; height: 18; radius: 3; color: "#42A5F5"
            }

            // Arrow labels
            Text {
                x: parent.width * 0.4; y: parent.height * 0.07
                text: qsTr("Heli bay LÊN")
                font.pixelSize: 10; font.bold: true; color: "#1565C0"
                rotation: -15
            }

            Text {
                x: parent.width * 0.68; y: parent.height * 0.52
                text: qsTr("Bóng thường RƠI")
                font.pixelSize: 9; font.bold: true; color: "#7B1FA2"
            }

            // Up arrows for helium
            Repeater {
                model: 3
                Text {
                    property int arrowDuration: 1500 + index * 400
                    x: parent.width * (0.15 + index * 0.18)
                    text: "\u2191"
                    font.pixelSize: 14; color: "#1E88E5"; opacity: 0.6

                    SequentialAnimation on y {
                        running: true; loops: Animation.Infinite
                        NumberAnimation { from: parent.height * 0.30; to: parent.height * 0.20; duration: arrowDuration; easing.type: Easing.InOutSine }
                        NumberAnimation { from: parent.height * 0.20; to: parent.height * 0.30; duration: arrowDuration; easing.type: Easing.InOutSine }
                    }
                }
            }

            // Down arrow for regular balloon
            Text {
                x: parent.width * 0.72; text: "\u2193"
                font.pixelSize: 14; color: "#AB47BC"; opacity: 0.6

                SequentialAnimation on y {
                    running: true; loops: Animation.Infinite
                    NumberAnimation { from: parent.height * 0.55; to: parent.height * 0.65; duration: 1800; easing.type: Easing.InOutSine }
                    NumberAnimation { from: parent.height * 0.65; to: parent.height * 0.55; duration: 1800; easing.type: Easing.InOutSine }
                }
            }

            // Bottom label
            Text {
                anchors.bottom: parent.bottom; anchors.bottomMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Bóng heli bay lên — Bóng thường rơi xuống")
                font.pixelSize: NeoConstants.fontCaption; color: "#1565C0"; font.bold: true
            }
        }
    }
}
