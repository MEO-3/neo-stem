import QtQuick
import "../../core"

PhenomenonViewer {
    title: qsTr("Hiện tượng: Lá cây xanh")
    description: qsTr("Quan sát khu vườn Việt Nam xanh mướt. Cây cối xanh tươi dưới nắng — bạn thấy gì?")

    hotspots: [
        { x: 0.35, y: 0.45, label: qsTr("Lục lạp"), detail: qsTr("Bên trong lá có hàng triệu hạt lục lạp (chloroplast) chứa chất diệp lục (chlorophyll). Diệp lục hấp thụ ánh sáng đỏ và xanh dương, phản xạ ánh sáng xanh lá — nên ta thấy lá xanh.") },
        { x: 0.7, y: 0.2, label: qsTr("Ánh sáng"), detail: qsTr("Mặt trời cung cấp năng lượng ánh sáng cho cây. Không có ánh sáng, cây không thể quang hợp. Ánh sáng trắng gồm nhiều màu — lá chỉ dùng đỏ và xanh dương.") },
        { x: 0.6, y: 0.55, label: qsTr("Khí CO₂"), detail: qsTr("Cây hấp thụ CO₂ từ không khí qua lỗ khí (khí khổng) dưới mặt lá. CO₂ là nguyên liệu để quang hợp tạo đường glucose nuôi cây.") }
    ]

    sceneComponent: Component {
        Rectangle {
            anchors.fill: parent
            radius: 12; color: "#E8F5E9"

            // Sky
            Rectangle {
                width: parent.width; height: parent.height * 0.4
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#87CEEB" }
                    GradientStop { position: 1.0; color: "#B2EBF2" }
                }
            }

            // Sun
            Rectangle {
                id: sun
                x: parent.width * 0.75; y: parent.height * 0.05
                width: 50; height: 50; radius: 25
                color: "#FFD600"
                opacity: 0.9

                SequentialAnimation on opacity {
                    running: true; loops: Animation.Infinite
                    NumberAnimation { from: 0.9; to: 1.0; duration: 1500; easing.type: Easing.InOutSine }
                    NumberAnimation { from: 1.0; to: 0.9; duration: 1500; easing.type: Easing.InOutSine }
                }
            }

            // Sun rays
            Repeater {
                model: 8
                Rectangle {
                    x: sun.x + 25; y: sun.y + 25
                    width: 30; height: 2; radius: 1
                    color: "#FFEB3B"
                    opacity: 0.6
                    rotation: index * 45
                    transformOrigin: Item.Left
                }
            }

            // Ground
            Rectangle {
                anchors.bottom: parent.bottom; width: parent.width
                height: parent.height * 0.25; color: "#795548"; radius: 8
                Rectangle {
                    anchors.top: parent.top; width: parent.width; height: 6; color: "#5D4037"
                }
            }

            // Green tree trunk
            Rectangle {
                id: trunk
                x: parent.width * 0.28; y: parent.height * 0.4
                width: 14; height: parent.height * 0.38
                color: "#5D4037"; radius: 3
            }

            // Tree crown (layered circles)
            Repeater {
                model: [
                    { cx: 0.30, cy: 0.22, sz: 70, clr: "#388E3C" },
                    { cx: 0.22, cy: 0.30, sz: 55, clr: "#43A047" },
                    { cx: 0.38, cy: 0.28, sz: 60, clr: "#2E7D32" },
                    { cx: 0.30, cy: 0.32, sz: 50, clr: "#4CAF50" }
                ]
                Rectangle {
                    x: parent.width * modelData.cx - modelData.sz / 2
                    y: parent.height * modelData.cy - modelData.sz / 2
                    width: modelData.sz; height: modelData.sz
                    radius: modelData.sz / 2; color: modelData.clr
                }
            }

            // Zoom circle showing chloroplasts
            Rectangle {
                id: zoomCircle
                x: parent.width * 0.58; y: parent.height * 0.25
                width: 80; height: 80; radius: 40
                color: "#C8E6C9"; border.width: 2; border.color: "#2E7D32"

                // Chloroplasts (small green ovals)
                Repeater {
                    model: [
                        { cx: 18, cy: 20 }, { cx: 45, cy: 15 },
                        { cx: 30, cy: 40 }, { cx: 55, cy: 38 },
                        { cx: 22, cy: 55 }, { cx: 50, cy: 58 }
                    ]
                    Rectangle {
                        x: modelData.cx; y: modelData.cy
                        width: 16; height: 10; radius: 5
                        color: "#1B5E20"

                        SequentialAnimation on opacity {
                            running: true; loops: Animation.Infinite
                            NumberAnimation { from: 0.6; to: 1.0; duration: 1200; easing.type: Easing.InOutSine }
                            NumberAnimation { from: 1.0; to: 0.6; duration: 1200; easing.type: Easing.InOutSine }
                        }
                    }
                }

                // Label
                Text {
                    anchors.top: parent.bottom; anchors.topMargin: 4
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Lục lạp trong lá")
                    font.pixelSize: 10; color: "#1B5E20"; font.bold: true
                }
            }

            // Zoom line
            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    ctx.beginPath()
                    ctx.moveTo(width * 0.38, height * 0.28)
                    ctx.lineTo(width * 0.58, height * 0.35)
                    ctx.strokeStyle = "#2E7D32"
                    ctx.lineWidth = 1.5
                    ctx.setLineDash([4, 3])
                    ctx.stroke()
                }
            }

            // Shade leaf comparison
            Row {
                anchors.right: parent.right; anchors.rightMargin: 10
                anchors.bottom: parent.bottom; anchors.bottomMargin: parent.height * 0.28
                spacing: 12

                // Sunlit leaf
                Column {
                    Rectangle {
                        width: 30; height: 22; radius: 8; color: "#2E7D32"
                        rotation: -15
                    }
                    Text { text: qsTr("Nắng"); font.pixelSize: 9; color: "#333"; anchors.horizontalCenter: parent.horizontalCenter }
                }

                // Shade leaf
                Column {
                    Rectangle {
                        width: 30; height: 22; radius: 8; color: "#81C784"
                        rotation: 10
                    }
                    Text { text: qsTr("Râm"); font.pixelSize: 9; color: "#333"; anchors.horizontalCenter: parent.horizontalCenter }
                }
            }

            // CO2 arrows
            Repeater {
                model: 3
                Text {
                    property real startX: parent.width * (0.45 + index * 0.08)
                    x: startX; y: parent.height * 0.48
                    text: "CO₂ ↓"
                    font.pixelSize: 9; color: "#78909C"
                    opacity: 0.7

                    SequentialAnimation on y {
                        running: true; loops: Animation.Infinite
                        NumberAnimation { from: parent.height * 0.44; to: parent.height * 0.50; duration: 2000; easing.type: Easing.InOutSine }
                        NumberAnimation { from: parent.height * 0.50; to: parent.height * 0.44; duration: 2000; easing.type: Easing.InOutSine }
                    }
                }
            }

            // Bottom label
            Text {
                anchors.bottom: parent.bottom; anchors.bottomMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Khu vườn xanh — Lá xanh nhờ diệp lục trong lục lạp")
                font.pixelSize: NeoConstants.fontCaption; color: "#1B5E20"; font.bold: true
            }
        }
    }
}
