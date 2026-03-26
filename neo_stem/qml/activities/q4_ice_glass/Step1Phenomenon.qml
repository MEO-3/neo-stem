import QtQuick
import "../../core"

PhenomenonViewer {
    id: step
    title: qsTr("Hiện tượng: Giọt nước trên ly đá")
    description: qsTr("Bàn ăn Việt Nam, trời nóng. Thả đá vào ly nước — chờ một lát... bạn thấy gì bên ngoài ly?")

    hotspots: [
        { x: 0.5, y: 0.35, label: qsTr("Giọt nước bên ngoài ly"), detail: qsTr("Giọt nước xuất hiện bên ngoài thành ly. Ly không bị rò rỉ! Nước này đến từ không khí — hơi nước gặp thành ly lạnh và ngưng tụ.") },
        { x: 0.5, y: 0.55, label: qsTr("Đá trong ly"), detail: qsTr("Đá làm lạnh nước và thành ly. Nhiệt độ thành ly giảm xuống dưới 'điểm sương' — nhiệt độ mà hơi nước bắt đầu ngưng tụ.") },
        { x: 0.3, y: 0.7, label: qsTr("Vũng nước dưới ly"), detail: qsTr("Giọt nước ngưng tụ chảy xuống tạo thành vũng nước quanh đáy ly. Đó là lý do cần dùng lót ly khi uống nước đá!") }
    ]

    property bool iceAdded: false

    sceneComponent: Component {
        Item {
            anchors.fill: parent

            Rectangle { anchors.fill: parent; radius: 12; color: "#FFF8E1"
                Rectangle { anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right; height: parent.height * 0.3; color: "#D7CCC8"; radius: 8 }
            }

            Rectangle {
                id: glass
                anchors.centerIn: parent; anchors.verticalCenterOffset: 20
                width: Math.min(parent.width * 0.25, 120); height: width * 1.6
                radius: 8; color: "transparent"; border.width: 3; border.color: Qt.rgba(0.7,0.85,1.0,0.7)

                Rectangle {
                    anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right; anchors.margins: 4
                    height: parent.height * 0.7; radius: 6; color: Qt.rgba(0.7,0.9,1.0,0.5)
                    Repeater {
                        model: step.iceAdded ? 3 : 0
                        Rectangle { x: 8+index*20; y: 10+index*8; width: 22; height: 18; radius: 4; color: Qt.rgba(0.85,0.95,1.0,0.8); border.width: 1; border.color: Qt.rgba(0.7,0.88,1.0,0.6); rotation: index*15-10 }
                    }
                }

                ParticleEffects { anchors.fill: parent; anchors.margins: -8; effectType: "condensation"; running: step.iceAdded; intensity: 0.9 }
            }

            Rectangle {
                visible: step.iceAdded; anchors.horizontalCenter: glass.horizontalCenter; anchors.top: glass.bottom; anchors.topMargin: -2
                width: glass.width * 1.3; height: 8; radius: 4; color: Qt.rgba(0.7,0.85,1.0,0.4)
            }

            Rectangle {
                anchors.right: parent.right; anchors.top: parent.top; anchors.margins: 12
                width: neoText.implicitWidth + 20; height: neoText.implicitHeight + 16; radius: 12; color: NeoConstants.hintBlue
                Text { id: neoText; anchors.centerIn: parent; text: step.iceAdded ? qsTr("Ly không bị rò mà! 🤔") : qsTr("Thử thả đá vào ly xem!"); font.pixelSize: 13; font.bold: true; color: "white" }
            }

            TouchButton {
                anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter; anchors.bottomMargin: 12
                text: step.iceAdded ? qsTr("🧊 Đã thêm đá") : qsTr("🧊 Thả đá vào ly")
                buttonColor: step.iceAdded ? NeoConstants.successGreen : NeoConstants.oceanBlue; textColor: "white"; fontSize: NeoConstants.fontCaption
                onClicked: step.iceAdded = true
            }
        }
    }
}
