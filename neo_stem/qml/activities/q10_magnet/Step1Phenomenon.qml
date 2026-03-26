import QtQuick
import "../../core"

PhenomenonViewer {
    title: qsTr("Hiện tượng: Nam châm hút vật")
    description: qsTr("Quan sát bàn học Việt Nam. Đưa nam châm lại gần các vật — bạn thấy gì?")

    hotspots: [
        { x: 0.3, y: 0.45, label: qsTr("Cực nam châm"), detail: qsTr("Nam châm có 2 cực: Bắc (N) và Nam (S). Cùng cực đẩy nhau, khác cực hút nhau. Từ trường mạnh nhất ở 2 đầu cực.") },
        { x: 0.55, y: 0.4, label: qsTr("Vật sắt bị hút"), detail: qsTr("Đinh sắt, kẹp giấy thép bị nam châm hút mạnh. Các vật chứa sắt, thép, niken, coban có tính sắt từ — electron sắp xếp theo từ trường.") },
        { x: 0.7, y: 0.55, label: qsTr("Vật không bị hút"), detail: qsTr("Lon nhôm, xu đồng, cục tẩy, gỗ — không bị hút. Hầu hết vật liệu KHÔNG có tính sắt từ, nên nam châm không ảnh hưởng.") }
    ]

    sceneComponent: Component {
        Rectangle {
            anchors.fill: parent
            radius: 12; color: "#EFEBE9"

            // Desk surface
            Rectangle {
                anchors.bottom: parent.bottom; width: parent.width
                height: parent.height * 0.6; color: "#D7CCC8"; radius: 8
                Rectangle {
                    anchors.top: parent.top; width: parent.width; height: 4; color: "#BCAAA4"
                }
            }

            // Magnet (U-shape representation)
            Rectangle {
                id: magnet
                x: parent.width * 0.15; y: parent.height * 0.35
                width: 60; height: 30; radius: 4; color: "#F44336"
                Text { anchors.centerIn: parent; text: "N   S"; font.pixelSize: 14; font.bold: true; color: "white" }

                SequentialAnimation on x {
                    running: true; loops: Animation.Infinite
                    NumberAnimation { from: parent.width * 0.15; to: parent.width * 0.25; duration: 2000; easing.type: Easing.InOutSine }
                    NumberAnimation { from: parent.width * 0.25; to: parent.width * 0.15; duration: 2000; easing.type: Easing.InOutSine }
                }
            }

            // Iron nails (attracted)
            Repeater {
                model: [
                    { ox: 0.45, oy: 0.4, lbl: qsTr("Đinh sắt") },
                    { ox: 0.5, oy: 0.45, lbl: qsTr("Kẹp giấy") }
                ]
                Column {
                    x: parent.width * modelData.ox; y: parent.height * modelData.oy
                    Rectangle {
                        width: 20; height: 6; radius: 1; color: "#78909C"
                        SequentialAnimation on x {
                            running: true; loops: Animation.Infinite
                            NumberAnimation { from: 0; to: -8; duration: 2000; easing.type: Easing.InOutSine }
                            NumberAnimation { from: -8; to: 0; duration: 2000; easing.type: Easing.InOutSine }
                        }
                    }
                    Text { text: modelData.lbl; font.pixelSize: 10; color: "#555" }
                }
            }

            // Non-magnetic items
            Repeater {
                model: [
                    { ox: 0.65, oy: 0.42, lbl: qsTr("Lon nhôm"), clr: "#BDBDBD" },
                    { ox: 0.75, oy: 0.48, lbl: qsTr("Xu đồng"), clr: "#FF8A65" },
                    { ox: 0.85, oy: 0.45, lbl: qsTr("Cục tẩy"), clr: "#F48FB1" }
                ]
                Column {
                    x: parent.width * modelData.ox; y: parent.height * modelData.oy
                    Rectangle { width: 20; height: 16; radius: 3; color: modelData.clr }
                    Text { text: modelData.lbl; font.pixelSize: 10; color: "#555" }
                }
            }

            // Result labels
            Text {
                anchors.bottom: parent.bottom; anchors.bottomMargin: 15
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Sắt/Thép → HÚT     |     Nhôm/Đồng/Gỗ → KHÔNG HÚT")
                font.pixelSize: NeoConstants.fontCaption; color: "#5D4037"; font.bold: true
            }
        }
    }
}
