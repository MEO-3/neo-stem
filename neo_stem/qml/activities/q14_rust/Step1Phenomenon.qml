import QtQuick
import "../../core"

PhenomenonViewer {
    title: qsTr("Hiện tượng: Sắt bị rỉ sét")
    description: qsTr("Quan sát cánh cổng sắt cũ trong hẻm Việt Nam. Sau nhiều năm mưa nắng — bạn thấy gì trên bề mặt sắt?")

    hotspots: [
        { x: 0.35, y: 0.45, label: qsTr("Lớp gỉ"), detail: qsTr("Lớp gỉ nâu đỏ phủ trên bề mặt sắt. Đó là oxit sắt (Fe₂O₃) — sản phẩm của phản ứng giữa sắt với oxy và nước. Gỉ xốp, bong tróc, không bảo vệ được sắt bên trong.") },
        { x: 0.6, y: 0.3, label: qsTr("Nước mưa"), detail: qsTr("Nước mưa là chất xúc tác quan trọng. Nước tạo môi trường điện ly giúp electron di chuyển từ sắt sang oxy, đẩy nhanh phản ứng oxy hóa.") },
        { x: 0.7, y: 0.55, label: qsTr("Không khí (oxy)"), detail: qsTr("Oxy trong không khí là chất oxy hóa. Oxy nhận electron từ sắt, kết hợp với sắt và nước tạo thành gỉ sét Fe₂O₃. Không có oxy, sắt không gỉ.") }
    ]

    sceneComponent: Component {
        Rectangle {
            anchors.fill: parent
            radius: 12; color: "#F5F5F5"

            // Alley background
            Rectangle {
                anchors.fill: parent; radius: 12
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#B0BEC5" }
                    GradientStop { position: 0.5; color: "#CFD8DC" }
                    GradientStop { position: 1.0; color: "#90A4AE" }
                }
            }

            // Wall on left
            Rectangle {
                x: 0; y: 0
                width: parent.width * 0.15; height: parent.height
                color: "#BCAAA4"
            }

            // Wall on right
            Rectangle {
                x: parent.width * 0.85; y: 0
                width: parent.width * 0.15; height: parent.height
                color: "#A1887F"
            }

            // Iron gate frame
            Rectangle {
                id: gateFrame
                anchors.centerIn: parent
                width: parent.width * 0.55; height: parent.height * 0.75
                color: "transparent"
                border.width: 6; border.color: "#5D4037"
                radius: 4

                // Gate bars
                Repeater {
                    model: 5
                    Rectangle {
                        x: (index + 1) * parent.width / 6 - 3
                        y: 6
                        width: 6; height: parent.height - 12
                        color: "#78909C"

                        // Rust patches on bars
                        Repeater {
                            model: 2
                            Rectangle {
                                x: -2
                                y: parent.height * (0.2 + index * 0.4)
                                width: 10; height: 15 + index * 5
                                radius: 4
                                color: "#BF360C"
                                opacity: 0.7 + index * 0.15
                            }
                        }
                    }
                }

                // Large rust patches on frame
                Rectangle {
                    x: 8; y: parent.height * 0.6
                    width: 30; height: 20; radius: 8
                    color: "#D84315"; opacity: 0.8
                }
                Rectangle {
                    x: parent.width - 40; y: parent.height * 0.3
                    width: 25; height: 25; radius: 10
                    color: "#BF360C"; opacity: 0.7
                }
            }

            // Comparison: New nail (shiny) vs Old nail (rusty)
            Row {
                anchors.bottom: parent.bottom; anchors.bottomMargin: 12
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 30

                // New shiny nail
                Column {
                    spacing: 4
                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 8; height: 50; radius: 2
                        color: "#B0BEC5"
                        border.width: 1; border.color: "#78909C"
                        // Nail head
                        Rectangle {
                            anchors.top: parent.top; anchors.horizontalCenter: parent.horizontalCenter
                            width: 16; height: 5; radius: 2; color: "#90A4AE"
                        }
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("Đinh mới")
                        font.pixelSize: 11; font.bold: true; color: "#546E7A"
                    }
                }

                // Old rusty nail
                Column {
                    spacing: 4
                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 8; height: 50; radius: 2
                        color: "#8D6E63"
                        border.width: 1; border.color: "#5D4037"
                        // Nail head with rust
                        Rectangle {
                            anchors.top: parent.top; anchors.horizontalCenter: parent.horizontalCenter
                            width: 16; height: 5; radius: 2; color: "#BF360C"
                        }
                        // Rust spots
                        Rectangle { x: -2; y: 15; width: 12; height: 8; radius: 4; color: "#D84315"; opacity: 0.8 }
                        Rectangle { x: 0; y: 30; width: 10; height: 6; radius: 3; color: "#BF360C"; opacity: 0.7 }
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("Đinh cũ (gỉ)")
                        font.pixelSize: 11; font.bold: true; color: "#BF360C"
                    }
                }
            }

            // Rain drops
            Repeater {
                model: 12
                Rectangle {
                    property real startX: Math.random()
                    property real animDur: 1200 + Math.random() * 800

                    x: parent.width * startX
                    width: 2; height: 10; radius: 1
                    color: "#64B5F6"
                    opacity: 0.5

                    SequentialAnimation on y {
                        running: true; loops: Animation.Infinite
                        NumberAnimation { from: -10; to: parent.height; duration: animDur }
                    }
                }
            }

            // Label
            Text {
                anchors.top: parent.top; anchors.topMargin: 8
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Cổng sắt cũ trong hẻm")
                font.pixelSize: NeoConstants.fontCaption; color: "#37474F"; font.bold: true
            }
        }
    }
}
