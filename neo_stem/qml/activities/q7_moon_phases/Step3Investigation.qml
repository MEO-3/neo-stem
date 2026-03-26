import QtQuick
import "../../core"
import QtQuick.Layouts

InvestigationBase {
    title: qsTr("Thí nghiệm: Mô phỏng pha mặt trăng")
    instructions: qsTr("Kéo mặt trăng quay quanh Trái Đất. Quan sát phần sáng/tối thay đổi. Ghi lại vị trí và tên pha.")
    requiredDataPoints: 5
    dataHeaders: [qsTr("Vị trí (°)"), qsTr("% Sáng"), qsTr("Tên pha")]

    property real moonPosition: 0  // 0-360 degrees
    property int brightPercent: 0
    property string phaseName: qsTr("Trăng mới")

    onMoonPositionChanged: {
        var pos = moonPosition % 360
        if (pos < 22.5 || pos >= 337.5) {
            brightPercent = 0; phaseName = qsTr("Trăng mới")
        } else if (pos < 67.5) {
            brightPercent = 25; phaseName = qsTr("Lưỡi liềm đầu")
        } else if (pos < 112.5) {
            brightPercent = 50; phaseName = qsTr("Bán nguyệt đầu")
        } else if (pos < 157.5) {
            brightPercent = 75; phaseName = qsTr("Trăng khuyết tăng")
        } else if (pos < 202.5) {
            brightPercent = 100; phaseName = qsTr("Trăng tròn")
        } else if (pos < 247.5) {
            brightPercent = 75; phaseName = qsTr("Trăng khuyết giảm")
        } else if (pos < 292.5) {
            brightPercent = 50; phaseName = qsTr("Bán nguyệt cuối")
        } else {
            brightPercent = 25; phaseName = qsTr("Lưỡi liềm cuối")
        }
    }

    experimentArea: [
        Item {
            anchors.fill: parent

            // Sun (light source) indicator
            Rectangle {
                anchors.right: parent.right; anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                width: 40; height: 40; radius: 20
                color: "#FFD700"
                Text { anchors.centerIn: parent; text: "☀"; font.pixelSize: 24 }
            }

            // Earth (center)
            Rectangle {
                id: earth
                anchors.centerIn: parent
                width: 50; height: 50; radius: 25
                color: "#4CAF50"
                border.width: 2; border.color: "#2E7D32"
                Text { anchors.centerIn: parent; text: "🌍"; font.pixelSize: 28 }
            }

            // Orbit path
            Rectangle {
                anchors.centerIn: parent
                width: Math.min(parent.width, parent.height) * 0.7
                height: width; radius: width / 2
                color: "transparent"
                border.width: 1; border.color: "#37474F"
                opacity: 0.5
            }

            // Moon on orbit
            Rectangle {
                id: moonOrbit
                property real orbitRadius: Math.min(parent.width, parent.height) * 0.35
                x: parent.width / 2 + orbitRadius * Math.cos(moonPosition * Math.PI / 180) - width / 2
                y: parent.height / 2 + orbitRadius * Math.sin(moonPosition * Math.PI / 180) - height / 2
                width: 36; height: 36; radius: 18
                color: "#F5F5DC"

                // Shadow overlay
                Rectangle {
                    width: parent.width; height: parent.height; radius: parent.radius
                    color: "#1a1a2e"
                    opacity: 1.0 - brightPercent / 100
                }
            }

            // Phase display
            Rectangle {
                anchors.left: parent.left; anchors.leftMargin: 8
                anchors.top: parent.top; anchors.topMargin: 8
                width: phaseText.implicitWidth + 16; height: phaseText.implicitHeight + 8
                radius: 8; color: NeoConstants.stepIndigo
                Text {
                    id: phaseText; anchors.centerIn: parent
                    text: qsTr("%1 — %2% sáng").arg(phaseName).arg(brightPercent)
                    font.pixelSize: NeoConstants.fontCaption; font.bold: true; color: "white"
                }
            }
        }
    ]

    controlsArea: [
        SliderControl {
            anchors.fill: parent; anchors.margins: 8
            label: qsTr("🌙 Vị trí Mặt Trăng")
            value: moonPosition; from: 0; to: 360; stepSize: 1
            accentColor: NeoConstants.stepPurple
            labels: [qsTr("0°"), qsTr("90°"), qsTr("180°"), qsTr("360°")]
            onValueChanged: moonPosition = value
        }
    ]

    function recordCurrentData() {
        addDataPoint([Math.round(moonPosition), brightPercent, phaseName])
    }

    function getConclusion() {
        if (dataPoints.length >= requiredDataPoints) {
            return qsTr("Kết luận: Mặt trăng không tự phát sáng — nó phản chiếu ánh sáng mặt trời. " +
                        "Khi mặt trăng quay quanh Trái Đất (~29.5 ngày), góc nhìn từ Trái Đất thay đổi. " +
                        "Phần sáng ta thấy (pha) phụ thuộc vào vị trí tương đối giữa Mặt Trời, Trái Đất và Mặt Trăng. " +
                        "Đó là lý do mặt trăng 'thay đổi hình dạng' mỗi đêm!")
        }
        return qsTr("Cần thêm dữ liệu để kết luận.")
    }
}
