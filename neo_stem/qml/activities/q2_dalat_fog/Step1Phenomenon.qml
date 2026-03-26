import QtQuick
import "../../core"

PhenomenonViewer {
    id: step
    title: qsTr("Hiện tượng: Sương mù Đà Lạt")
    description: qsTr("Đà Lạt sáng sớm phủ đầy sương mù. Kéo slider thời gian để xem sương thay đổi trong ngày.")

    hotspots: [
        { x: 0.3, y: 0.4, label: qsTr("Sương mù dày đặc"), detail: qsTr("Sáng sớm (5-7h), nhiệt độ thấp nhất trong ngày. Hơi nước trong không khí ngưng tụ thành giọt nước li ti lơ lửng — đó là sương mù.") },
        { x: 0.7, y: 0.3, label: qsTr("Mặt trời lên"), detail: qsTr("Khi mặt trời lên, nhiệt độ tăng dần. Giọt nước nhỏ trong sương mù hấp thụ nhiệt và bay hơi trở lại thành khí — sương tan dần.") },
        { x: 0.5, y: 0.75, label: qsTr("Thung lũng Đà Lạt"), detail: qsTr("Đà Lạt nằm ở cao nguyên 1500m, có nhiều thung lũng. Không khí lạnh nặng chảy xuống thung lũng ban đêm, tạo điều kiện lý tưởng cho sương mù.") }
    ]

    property real timeOfDay: 0.0

    sceneComponent: Component {
        Item {
            anchors.fill: parent

            Rectangle {
                anchors.fill: parent; radius: 12
                gradient: Gradient {
                    GradientStop { position: 0.0; color: step.timeOfDay < 0.3 ? "#1A237E" : (step.timeOfDay < 0.6 ? "#FF8F00" : "#42A5F5") }
                    GradientStop { position: 1.0; color: step.timeOfDay < 0.3 ? "#311B92" : (step.timeOfDay < 0.6 ? "#FFD600" : "#90CAF9") }
                }
            }

            Repeater {
                model: 4
                Rectangle {
                    anchors.bottom: parent.bottom; anchors.bottomMargin: parent.height * 0.2
                    x: parent.width * (index * 0.25); width: parent.width * 0.4; height: parent.height * (0.3 + index * 0.05)
                    radius: width / 2; color: Qt.rgba(0.15, 0.3, 0.15, 0.6 + index * 0.1)
                }
            }

            Rectangle {
                anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right
                height: parent.height * 0.25; color: "#2E7D32"; radius: 8
            }

            ParticleEffects {
                anchors.fill: parent; effectType: "fog"; running: true
                intensity: Math.max(0, 1.0 - step.timeOfDay * 1.5); particleColor: "white"
            }

            Rectangle {
                visible: step.timeOfDay > 0.3
                x: parent.width * 0.7; y: parent.height * (0.8 - step.timeOfDay * 0.6)
                width: 50 + step.timeOfDay * 20; height: width; radius: width / 2
                color: NeoConstants.sunshine; opacity: Math.min(1, (step.timeOfDay - 0.3) * 3)
            }

            SliderControl {
                anchors.bottom: parent.bottom; anchors.left: parent.left; anchors.right: parent.right; anchors.margins: 12
                label: qsTr("⏰ Thời gian"); value: step.timeOfDay; from: 0.0; to: 1.0
                labels: [qsTr("Đêm"), qsTr("Sáng sớm"), qsTr("Sáng"), qsTr("Trưa")]
                accentColor: NeoConstants.warmOrange; onValueChanged: step.timeOfDay = value
            }
        }
    }
}
