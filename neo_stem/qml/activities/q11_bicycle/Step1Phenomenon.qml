import QtQuick
import "../../core"

PhenomenonViewer {
    title: qsTr("Hiện tượng: Xe đạp xuống dốc")
    description: qsTr("Quan sát con đường làng Việt Nam có dốc. Xe đạp xuống dốc — bạn thấy gì?")

    hotspots: [
        { x: 0.4, y: 0.4, label: qsTr("Bánh xe lăn"), detail: qsTr("Khi xuống dốc, bánh xe quay ngày càng nhanh mà không cần đạp. Năng lượng từ đâu để xe tăng tốc?") },
        { x: 0.3, y: 0.6, label: qsTr("Trọng lực"), detail: qsTr("Trái Đất kéo mọi vật xuống — đó là trọng lực. Trên dốc, trọng lực có thành phần kéo xe theo hướng dốc, làm xe tăng tốc.") },
        { x: 0.7, y: 0.35, label: qsTr("Phanh xe"), detail: qsTr("Phanh tạo ma sát với vành bánh, chuyển động năng thành nhiệt. Lực ma sát ngược chiều chuyển động giúp giảm tốc.") }
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

            // Hill/slope
            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    ctx.beginPath()
                    ctx.moveTo(0, height * 0.3)
                    ctx.lineTo(width, height * 0.7)
                    ctx.lineTo(width, height)
                    ctx.lineTo(0, height)
                    ctx.closePath()
                    ctx.fillStyle = "#4CAF50"
                    ctx.fill()
                }
            }

            // Road on slope
            Canvas {
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    ctx.beginPath()
                    ctx.moveTo(0, height * 0.35)
                    ctx.lineTo(width, height * 0.75)
                    ctx.lineTo(width, height * 0.78)
                    ctx.lineTo(0, height * 0.38)
                    ctx.closePath()
                    ctx.fillStyle = "#9E9E9E"
                    ctx.fill()
                }
            }

            // Bicycle (simplified)
            Item {
                id: bike
                width: 50; height: 40

                SequentialAnimation on x {
                    running: true; loops: Animation.Infinite
                    NumberAnimation { from: parent.width * 0.1; to: parent.width * 0.8; duration: 3000; easing.type: Easing.InQuad }
                    NumberAnimation { from: parent.width * 0.1; to: parent.width * 0.1; duration: 0 }
                }
                SequentialAnimation on y {
                    running: true; loops: Animation.Infinite
                    NumberAnimation { from: parent.height * 0.28; to: parent.height * 0.65; duration: 3000; easing.type: Easing.InQuad }
                    NumberAnimation { from: parent.height * 0.28; to: parent.height * 0.28; duration: 0 }
                }

                // Wheels
                Repeater {
                    model: [{wx: 5, wy: 28}, {wx: 40, wy: 28}]
                    Rectangle {
                        x: modelData.wx; y: modelData.wy
                        width: 16; height: 16; radius: 8
                        color: "transparent"; border.width: 2; border.color: "#333"
                        NumberAnimation on rotation {
                            running: true; from: 0; to: 360; duration: 400; loops: Animation.Infinite
                        }
                        Rectangle { anchors.centerIn: parent; width: 4; height: 4; radius: 2; color: "#333" }
                    }
                }

                // Frame
                Rectangle { x: 12; y: 20; width: 30; height: 3; color: "#1565C0"; rotation: -10 }
                // Rider
                Rectangle { x: 15; y: 8; width: 8; height: 15; radius: 4; color: "#FF9800" }
                Rectangle { x: 16; y: 2; width: 6; height: 6; radius: 3; color: "#FFE0B2" }
            }

            // Speed indicator arrow
            Text {
                anchors.bottom: parent.bottom; anchors.bottomMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Xuống dốc → Nhanh dần! 🚴‍♂️💨")
                font.pixelSize: NeoConstants.fontCaption; color: "#1B5E20"; font.bold: true
            }
        }
    }
}
