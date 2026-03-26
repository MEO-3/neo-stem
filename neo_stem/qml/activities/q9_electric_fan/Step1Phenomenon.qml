import QtQuick
import "../../core"

PhenomenonViewer {
    title: qsTr("Hiện tượng: Quạt điện quay")
    description: qsTr("Quan sát phòng khách Việt Nam. Cắm quạt và bật công tắc — bạn thấy gì?")

    hotspots: [
        { x: 0.2, y: 0.6, label: qsTr("Ổ cắm điện"), detail: qsTr("Ổ cắm nối với lưới điện — nguồn năng lượng điện từ nhà máy phát điện truyền đến qua dây dẫn bằng đồng.") },
        { x: 0.5, y: 0.5, label: qsTr("Dây điện"), detail: qsTr("Dây điện bằng đồng dẫn dòng điện từ ổ cắm đến motor quạt. Đồng dẫn điện tốt vì electron tự do di chuyển dễ dàng.") },
        { x: 0.65, y: 0.35, label: qsTr("Motor quạt"), detail: qsTr("Motor (động cơ điện) chuyển năng lượng điện thành chuyển động quay. Bên trong có cuộn dây và nam châm tạo lực quay.") }
    ]

    sceneComponent: Component {
        Rectangle {
            anchors.fill: parent
            radius: 12; color: "#FFF3E0"

            // Wall outlet
            Rectangle {
                x: parent.width * 0.1; y: parent.height * 0.5
                width: 30; height: 40; radius: 4
                color: "#ECEFF1"; border.width: 2; border.color: "#90A4AE"
                Column {
                    anchors.centerIn: parent; spacing: 6
                    Repeater {
                        model: 2
                        Rectangle { width: 8; height: 3; radius: 1; color: "#455A64"; anchors.horizontalCenter: parent.horizontalCenter }
                    }
                }
            }

            // Power cord
            Rectangle {
                x: parent.width * 0.13; y: parent.height * 0.55
                width: parent.width * 0.35; height: 3; color: "#37474F"
            }

            // Fan stand
            Rectangle {
                id: fanStand
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: parent.width * 0.15
                anchors.bottom: parent.bottom; anchors.bottomMargin: parent.height * 0.15
                width: 12; height: parent.height * 0.35; color: "#78909C"
            }

            // Fan base
            Rectangle {
                anchors.horizontalCenter: fanStand.horizontalCenter
                anchors.bottom: parent.bottom; anchors.bottomMargin: parent.height * 0.12
                width: 80; height: 15; radius: 8; color: "#546E7A"
            }

            // Fan hub
            Rectangle {
                id: fanHub
                anchors.horizontalCenter: fanStand.horizontalCenter
                anchors.bottom: fanStand.top
                width: 20; height: 20; radius: 10; color: "#1565C0"
                z: 2
            }

            // Fan blades
            Item {
                id: bladeGroup
                anchors.centerIn: fanHub
                width: 120; height: 120

                Repeater {
                    model: 3
                    Rectangle {
                        width: 50; height: 14; radius: 7
                        color: "#90CAF9"
                        opacity: 0.8
                        x: parent.width / 2; y: parent.height / 2 - height / 2
                        transformOrigin: Item.Left
                        rotation: index * 120
                    }
                }

                NumberAnimation on rotation {
                    running: true; from: 0; to: 360
                    duration: 800; loops: Animation.Infinite
                }
            }

            // Wind lines
            Repeater {
                model: 5
                Rectangle {
                    property real wy: 0.3 + Math.random() * 0.3
                    property real wDur: 800 + Math.random() * 400
                    y: parent.height * wy; height: 2; radius: 1; color: "#B3E5FC"
                    opacity: 0.6
                    SequentialAnimation on x {
                        running: true; loops: Animation.Infinite
                        NumberAnimation { from: parent.width * 0.7; to: parent.width; duration: wDur }
                    }
                    SequentialAnimation on width {
                        running: true; loops: Animation.Infinite
                        NumberAnimation { from: 20; to: 40; duration: wDur }
                    }
                }
            }

            // Floor
            Rectangle {
                anchors.bottom: parent.bottom; width: parent.width
                height: parent.height * 0.12; color: "#8D6E63"; radius: 0
            }
        }
    }
}
