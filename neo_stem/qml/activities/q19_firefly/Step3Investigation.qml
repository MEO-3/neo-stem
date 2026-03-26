import QtQuick
import "../../core"
import QtQuick.Layouts

InvestigationBase {
    title: qsTr("Thí nghiệm: So sánh nguồn sáng")
    instructions: qsTr("So sánh 3 nguồn sáng: bóng đèn sợi đốt (nóng, 10% hiệu suất), que phát sáng (mát, hóa học), và đom đóm (mát, sinh học). Điều chỉnh năng lượng đầu vào và quan sát tỷ lệ ánh sáng so với nhiệt tỏa ra.")
    requiredDataPoints: 3
    dataHeaders: [qsTr("Nguồn sáng"), qsTr("Năng lượng vào"), qsTr("% Sáng"), qsTr("% Nhiệt")]

    property int lightSource: 0   // 0=bulb, 1=glowstick, 2=firefly
    property real energyInput: 50  // 0-100

    // Efficiency calculations per source
    property real lightPercent: lightSource === 0 ? energyInput * 0.10 :
                                (lightSource === 1 ? energyInput * 0.25 :
                                 energyInput * 0.95)
    property real heatPercent: lightSource === 0 ? energyInput * 0.90 :
                               (lightSource === 1 ? energyInput * 0.10 :
                                energyInput * 0.02)

    experimentArea: [
        Item {
            anchors.fill: parent

            // Background
            Rectangle {
                anchors.fill: parent
                color: "#1A1A2E"; radius: 8
            }

            // Title row
            Row {
                id: sourceLabelsRow
                anchors.top: parent.top; anchors.topMargin: 8
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: parent.width * 0.18

                Text {
                    text: qsTr("Bóng đèn")
                    font.pixelSize: NeoConstants.fontCaption; font.bold: true
                    color: lightSource === 0 ? "#FFD600" : "#666"
                }
                Text {
                    text: qsTr("Que sáng")
                    font.pixelSize: NeoConstants.fontCaption; font.bold: true
                    color: lightSource === 1 ? "#76FF03" : "#666"
                }
                Text {
                    text: qsTr("Đom đóm")
                    font.pixelSize: NeoConstants.fontCaption; font.bold: true
                    color: lightSource === 2 ? "#CCFF00" : "#666"
                }
            }

            // Three light sources side by side
            Row {
                id: sourcesRow
                anchors.centerIn: parent
                spacing: parent.width * 0.08

                // === Incandescent Bulb ===
                Item {
                    width: parent.parent.width * 0.26; height: parent.parent.height * 0.55

                    // Bulb shape
                    Rectangle {
                        id: bulbBody
                        anchors.centerIn: parent
                        width: 36; height: 44; radius: 18
                        color: lightSource === 0 ? Qt.rgba(1.0, 0.85, 0.2, energyInput / 100) : "#444"
                        border.width: 1; border.color: "#888"

                        Behavior on color { ColorAnimation { duration: 300 } }
                    }

                    // Heat waves for bulb
                    Repeater {
                        model: lightSource === 0 ? 3 : 0
                        Rectangle {
                            property int waveIndex: index
                            property int waveDuration: 1500 + index * 300
                            x: bulbBody.x + bulbBody.width + 4
                            y: bulbBody.y + 8 + index * 12
                            width: 14; height: 2; radius: 1
                            color: "#FF6D00"

                            SequentialAnimation on opacity {
                                running: true; loops: Animation.Infinite
                                NumberAnimation { from: 0.8; to: 0.1; duration: 1500; easing.type: Easing.InOutSine }
                                NumberAnimation { from: 0.1; to: 0.8; duration: 1500; easing.type: Easing.InOutSine }
                            }
                        }
                    }

                    // Light bar
                    Column {
                        anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 2

                        Rectangle {
                            width: 24
                            height: lightSource === 0 ? (energyInput * 0.10 / 100) * 50 : 5
                            color: "#FFD600"; radius: 2
                            anchors.horizontalCenter: parent.horizontalCenter

                            Behavior on height { NumberAnimation { duration: 300 } }
                        }
                        Text {
                            text: qsTr("Sáng")
                            font.pixelSize: 8; color: "#FFD600"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }

                // === Glow Stick ===
                Item {
                    width: parent.parent.width * 0.26; height: parent.parent.height * 0.55

                    // Stick shape
                    Rectangle {
                        id: stickBody
                        anchors.centerIn: parent
                        width: 12; height: 50; radius: 6
                        color: lightSource === 1 ? Qt.rgba(0.46, 1.0, 0.01, energyInput / 100) : "#444"
                        border.width: 1; border.color: "#888"

                        Behavior on color { ColorAnimation { duration: 300 } }
                    }

                    // Glow around stick
                    Rectangle {
                        anchors.centerIn: stickBody
                        width: 30; height: 60; radius: 15
                        color: "transparent"
                        border.width: lightSource === 1 ? 2 : 0
                        border.color: Qt.rgba(0.46, 1.0, 0.01, 0.3)
                        visible: lightSource === 1
                    }

                    // Light bar
                    Column {
                        anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 2

                        Rectangle {
                            width: 24
                            height: lightSource === 1 ? (energyInput * 0.25 / 100) * 50 : 5
                            color: "#76FF03"; radius: 2
                            anchors.horizontalCenter: parent.horizontalCenter

                            Behavior on height { NumberAnimation { duration: 300 } }
                        }
                        Text {
                            text: qsTr("Sáng")
                            font.pixelSize: 8; color: "#76FF03"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }

                // === Firefly ===
                Item {
                    width: parent.parent.width * 0.26; height: parent.parent.height * 0.55

                    // Firefly body
                    Rectangle {
                        id: fireflyBody
                        anchors.centerIn: parent
                        width: 18; height: 10; radius: 5
                        color: "#5D4037"
                    }

                    // Firefly abdomen glow
                    Rectangle {
                        id: fireflyGlow
                        anchors.centerIn: fireflyBody
                        anchors.verticalCenterOffset: 4
                        width: 28; height: 28; radius: 14
                        color: lightSource === 2 ? Qt.rgba(0.8, 1.0, 0.0, energyInput / 100) : "transparent"

                        Behavior on color { ColorAnimation { duration: 300 } }

                        SequentialAnimation on opacity {
                            running: lightSource === 2; loops: Animation.Infinite
                            NumberAnimation { from: 0.3; to: 1.0; duration: 700; easing.type: Easing.InOutSine }
                            NumberAnimation { from: 1.0; to: 0.3; duration: 700; easing.type: Easing.InOutSine }
                        }
                    }

                    // Light bar
                    Column {
                        anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 2

                        Rectangle {
                            width: 24
                            height: lightSource === 2 ? (energyInput * 0.95 / 100) * 50 : 5
                            color: "#CCFF00"; radius: 2
                            anchors.horizontalCenter: parent.horizontalCenter

                            Behavior on height { NumberAnimation { duration: 300 } }
                        }
                        Text {
                            text: qsTr("Sáng")
                            font.pixelSize: 8; color: "#CCFF00"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                    }
                }
            }

            // Efficiency display
            Rectangle {
                anchors.left: parent.left; anchors.leftMargin: 8
                anchors.top: parent.top; anchors.topMargin: 8
                width: effText.implicitWidth + 16; height: effText.implicitHeight + 8
                radius: 8; color: lightPercent > 50 ? NeoConstants.successGreen : (lightPercent > 15 ? NeoConstants.warmOrange : "#78909C")

                Behavior on color { ColorAnimation { duration: 300 } }

                Text {
                    id: effText; anchors.centerIn: parent
                    text: qsTr("Hiệu suất sáng: %1%").arg(Math.round(lightPercent))
                    font.pixelSize: NeoConstants.fontCaption; font.bold: true; color: "white"
                }
            }

            // Heat indicator
            Rectangle {
                anchors.right: parent.right; anchors.rightMargin: 8
                anchors.top: parent.top; anchors.topMargin: 8
                width: heatText.implicitWidth + 16; height: heatText.implicitHeight + 8
                radius: 8; color: heatPercent > 50 ? "#D32F2F" : (heatPercent > 10 ? NeoConstants.warmOrange : NeoConstants.successGreen)

                Behavior on color { ColorAnimation { duration: 300 } }

                Text {
                    id: heatText; anchors.centerIn: parent
                    text: qsTr("Nhiệt tỏa: %1%").arg(Math.round(heatPercent))
                    font.pixelSize: NeoConstants.fontCaption; font.bold: true; color: "white"
                }
            }

            // Bottom comparison label
            Text {
                anchors.bottom: parent.bottom; anchors.bottomMargin: 8
                anchors.horizontalCenter: parent.horizontalCenter
                text: lightSource === 0 ? qsTr("Bóng đèn sợi đốt: nhiều nhiệt, ít sáng") :
                      (lightSource === 1 ? qsTr("Que phát sáng: hóa học, mát, hiệu suất vừa") :
                       qsTr("Đom đóm: sinh học, gần 100% sáng, không nhiệt"))
                font.pixelSize: NeoConstants.fontCaption; font.bold: true; color: "#E0E0E0"
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
                label: qsTr("Năng lượng đầu vào")
                value: energyInput; from: 0; to: 100; stepSize: 5
                accentColor: NeoConstants.sunshine
                labels: [qsTr("Thấp"), qsTr("Vừa"), qsTr("Cao")]
                onValueChanged: energyInput = value
            }

            Column {
                Layout.fillWidth: true
                spacing: 4

                Text {
                    text: qsTr("Nguồn sáng:")
                    font.pixelSize: NeoConstants.fontCaption; font.bold: true; color: "#333"
                }

                Row {
                    spacing: 6

                    Repeater {
                        model: [
                            { label: qsTr("Bóng đèn"), idx: 0, clr: "#FFD600" },
                            { label: qsTr("Que sáng"), idx: 1, clr: "#76FF03" },
                            { label: qsTr("Đom đóm"), idx: 2, clr: "#CCFF00" }
                        ]
                        Rectangle {
                            width: btnLabel.implicitWidth + 16; height: 28
                            radius: 14
                            color: lightSource === modelData.idx ? modelData.clr : "#E0E0E0"
                            border.width: lightSource === modelData.idx ? 2 : 0
                            border.color: "#333"

                            Text {
                                id: btnLabel
                                anchors.centerIn: parent
                                text: modelData.label
                                font.pixelSize: NeoConstants.fontCaption; font.bold: true
                                color: lightSource === modelData.idx ? "#1A1A2E" : "#666"
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: { lightSource = modelData.idx }
                            }
                        }
                    }
                }
            }
        }
    ]

    function recordCurrentData() {
        var sourceName = lightSource === 0 ? qsTr("Bóng đèn") : (lightSource === 1 ? qsTr("Que sáng") : qsTr("Đom đóm"))
        var energyLabel = energyInput < 33 ? qsTr("Thấp") : (energyInput < 66 ? qsTr("Vừa") : qsTr("Cao"))
        var lightLabel = Math.round(lightPercent) + "%"
        var heatLabel = Math.round(heatPercent) + "%"
        addDataPoint([sourceName, energyLabel, lightLabel, heatLabel])
    }

    function getConclusion() {
        if (dataPoints.length >= requiredDataPoints) {
            return qsTr("Kết luận: Đom đóm phát sáng bằng PHÁT QUANG SINH HỌC (bioluminescence) — hiệu suất gần 100%, " +
                        "gần như toàn bộ năng lượng chuyển thành ánh sáng, không tỏa nhiệt. " +
                        "Bóng đèn sợi đốt chỉ đạt 10% hiệu suất sáng, 90% mất thành nhiệt. " +
                        "Que phát sáng dùng phản ứng hóa học, hiệu suất khoảng 25%. " +
                        "Đom đóm là nguồn sáng hiệu quả nhất trong tự nhiên nhờ phản ứng Luciferin + O₂ + Luciferase!")
        }
        return qsTr("Cần thêm dữ liệu để kết luận.")
    }
}
