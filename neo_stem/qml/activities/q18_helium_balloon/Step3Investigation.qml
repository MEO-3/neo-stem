import QtQuick
import "../../core"
import QtQuick.Layouts

InvestigationBase {
    title: qsTr("Thí nghiệm: So sánh bóng bay")
    instructions: qsTr("So sánh 3 loại bóng chứa khí khác nhau: heli, không khí, hơi nước. Thay đổi kích thước và loại khí. Quan sát hành vi và ghi dữ liệu.")
    requiredDataPoints: 5
    dataHeaders: [qsTr("Loại khí"), qsTr("Kích thước"), qsTr("Mật độ"), qsTr("Hành vi")]

    property int gasType: 0    // 0=helium, 1=air, 2=water vapor
    property real balloonSize: 0.5  // 0-1

    readonly property var gasData: [
        { name: qsTr("Heli"), density: 0.164, color: "#EF5350", behavior: qsTr("Bay lên") },
        { name: qsTr("Không khí"), density: 1.225, color: "#AB47BC", behavior: qsTr("Lơ lửng / Rơi nhẹ") },
        { name: qsTr("Hơi nước nóng"), density: 0.590, color: "#78909C", behavior: qsTr("Bay lên chậm") }
    ]

    readonly property real airDensity: 1.225

    experimentArea: [
        Item {
            anchors.fill: parent

            // Background sky
            Rectangle {
                anchors.fill: parent; radius: 8
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#E3F2FD" }
                    GradientStop { position: 1.0; color: "#BBDEFB" }
                }
            }

            // Ground line
            Rectangle {
                anchors.bottom: parent.bottom; width: parent.width
                height: 4; color: "#8D6E63"
            }

            // Density reference line (air density level)
            Rectangle {
                x: 0; y: parent.height * 0.50
                width: parent.width; height: 1
                color: "#90A4AE"; opacity: 0.6
            }
            Text {
                x: 4; y: parent.height * 0.50 - 14
                text: qsTr("Mật độ không khí = 1.225 kg/m³")
                font.pixelSize: 8; color: "#607D8B"
            }

            // Helium balloon (always visible for comparison)
            Rectangle {
                id: heliumBalloon
                property real baseSize: 28 + balloonSize * 24
                x: parent.width * 0.15 - baseSize / 2
                width: baseSize; height: baseSize * 1.15
                radius: baseSize / 2; color: "#EF5350"
                border.width: gasType === 0 ? 3 : 1
                border.color: gasType === 0 ? "#C62828" : "#E0E0E0"

                Behavior on width { NumberAnimation { duration: 300 } }
                Behavior on height { NumberAnimation { duration: 300 } }

                SequentialAnimation on y {
                    running: true; loops: Animation.Infinite
                    NumberAnimation { from: parent.height * 0.12; to: parent.height * 0.06; duration: 2400; easing.type: Easing.InOutSine }
                    NumberAnimation { from: parent.height * 0.06; to: parent.height * 0.12; duration: 2400; easing.type: Easing.InOutSine }
                }

                Rectangle {
                    x: 6; y: 5; width: 6; height: 9; radius: 3
                    color: "white"; opacity: 0.3; rotation: -15
                }
            }
            Text {
                x: parent.width * 0.15 - 12; y: parent.height * 0.32
                text: qsTr("Heli"); font.pixelSize: 10; font.bold: true; color: "#C62828"
            }
            Text {
                x: parent.width * 0.15 - 18; y: parent.height * 0.40
                text: qsTr("0.164 kg/m³"); font.pixelSize: 8; color: "#E53935"
            }

            // Air balloon (always visible for comparison)
            Rectangle {
                id: airBalloon
                property real baseSize: 28 + balloonSize * 24
                x: parent.width * 0.50 - baseSize / 2
                width: baseSize; height: baseSize * 1.15
                radius: baseSize / 2; color: "#AB47BC"
                border.width: gasType === 1 ? 3 : 1
                border.color: gasType === 1 ? "#7B1FA2" : "#E0E0E0"

                Behavior on width { NumberAnimation { duration: 300 } }
                Behavior on height { NumberAnimation { duration: 300 } }

                SequentialAnimation on y {
                    running: true; loops: Animation.Infinite
                    NumberAnimation { from: parent.height * 0.52; to: parent.height * 0.56; duration: 2000; easing.type: Easing.InOutSine }
                    NumberAnimation { from: parent.height * 0.56; to: parent.height * 0.52; duration: 2000; easing.type: Easing.InOutSine }
                }

                Rectangle {
                    x: 6; y: 5; width: 6; height: 9; radius: 3
                    color: "white"; opacity: 0.3; rotation: -15
                }
            }
            Text {
                x: parent.width * 0.50 - 18; y: parent.height * 0.72
                text: qsTr("Không khí"); font.pixelSize: 10; font.bold: true; color: "#7B1FA2"
            }
            Text {
                x: parent.width * 0.50 - 18; y: parent.height * 0.80
                text: qsTr("1.225 kg/m³"); font.pixelSize: 8; color: "#9C27B0"
            }

            // Water vapor balloon (always visible for comparison)
            Rectangle {
                id: waterBalloon
                property real baseSize: 28 + balloonSize * 24
                x: parent.width * 0.85 - baseSize / 2
                width: baseSize; height: baseSize * 1.15
                radius: baseSize / 2; color: "#78909C"
                border.width: gasType === 2 ? 3 : 1
                border.color: gasType === 2 ? "#455A64" : "#E0E0E0"

                Behavior on width { NumberAnimation { duration: 300 } }
                Behavior on height { NumberAnimation { duration: 300 } }

                SequentialAnimation on y {
                    running: true; loops: Animation.Infinite
                    NumberAnimation { from: parent.height * 0.30; to: parent.height * 0.24; duration: 2800; easing.type: Easing.InOutSine }
                    NumberAnimation { from: parent.height * 0.24; to: parent.height * 0.30; duration: 2800; easing.type: Easing.InOutSine }
                }

                Rectangle {
                    x: 6; y: 5; width: 6; height: 9; radius: 3
                    color: "white"; opacity: 0.3; rotation: -15
                }
            }
            Text {
                x: parent.width * 0.85 - 22; y: parent.height * 0.50
                text: qsTr("Hơi nước"); font.pixelSize: 10; font.bold: true; color: "#455A64"
            }
            Text {
                x: parent.width * 0.85 - 22; y: parent.height * 0.58
                text: qsTr("0.590 kg/m³"); font.pixelSize: 8; color: "#607D8B"
            }

            // Status display
            Rectangle {
                anchors.left: parent.left; anchors.leftMargin: 6
                anchors.top: parent.top; anchors.topMargin: 6
                width: statusText.implicitWidth + 14; height: statusText.implicitHeight + 8
                radius: 8
                color: gasData[gasType].density < airDensity ? NeoConstants.successGreen : NeoConstants.warmOrange

                Behavior on color { ColorAnimation { duration: 300 } }

                Text {
                    id: statusText; anchors.centerIn: parent
                    text: qsTr("Chọn: %1 — %2").arg(gasData[gasType].name).arg(gasData[gasType].behavior)
                    font.pixelSize: NeoConstants.fontCaption; font.bold: true; color: "white"
                }
            }

            // Bottom explanation
            Text {
                anchors.bottom: parent.bottom; anchors.bottomMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Mật độ nhỏ hơn không khí → bay lên | Mật độ lớn hơn → rơi xuống")
                font.pixelSize: NeoConstants.fontCaption; font.bold: true; color: "#37474F"
            }
        }
    ]

    controlsArea: [
        RowLayout {
            anchors.fill: parent
            anchors.margins: 4
            spacing: 8

            SliderControl {
                Layout.fillWidth: true
                label: qsTr("Kích thước bóng")
                value: balloonSize; from: 0; to: 1.0; stepSize: 0.05
                accentColor: NeoConstants.oceanBlue
                labels: [qsTr("Nhỏ"), qsTr("Vừa"), qsTr("Lớn")]
                onValueChanged: balloonSize = value
            }

            Column {
                Layout.fillWidth: true
                spacing: 4

                Text {
                    text: qsTr("Loại khí:")
                    font.pixelSize: NeoConstants.fontCaption; font.bold: true; color: "#333"
                }

                Row {
                    spacing: 4
                    Repeater {
                        model: gasData
                        Rectangle {
                            width: 68; height: 28; radius: 6
                            color: gasType === index ? modelData.color : "#E0E0E0"
                            border.width: gasType === index ? 2 : 1
                            border.color: gasType === index ? "#333" : "#999"
                            Text {
                                anchors.centerIn: parent
                                text: modelData.name
                                font.pixelSize: 10; color: gasType === index ? "white" : "#333"
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: { gasType = index }
                            }
                        }
                    }
                }
            }
        }
    ]

    function recordCurrentData() {
        var g = gasData[gasType]
        var sizeLabel = balloonSize < 0.33 ? qsTr("Nhỏ") : (balloonSize < 0.66 ? qsTr("Vừa") : qsTr("Lớn"))
        var densityLabel = g.density.toFixed(3) + " kg/m³"
        addDataPoint([g.name, sizeLabel, densityLabel, g.behavior])
    }

    function getConclusion() {
        if (dataPoints.length >= requiredDataPoints) {
            return qsTr("Kết luận: Bóng bay lên hay rơi xuống phụ thuộc vào MẬT ĐỘ khí bên trong so với không khí. " +
                        "Heli (0.164 kg/m³) nhẹ hơn không khí (1.225 kg/m³) rất nhiều → lực đẩy Archimedes > trọng lượng → bay lên. " +
                        "Không khí thổi vào bóng có mật độ tương đương không khí xung quanh → không bay lên. " +
                        "Quy tắc: Mật độ khí < Mật độ không khí → vật nổi (bay lên)!")
        }
        return qsTr("Cần thêm dữ liệu để kết luận.")
    }
}
