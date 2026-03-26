import QtQuick
import "../../core"
import QtQuick.Layouts

InvestigationBase {
    title: qsTr("Thí nghiệm: 3 cách tách muối")
    instructions: qsTr("Thử 3 phương pháp tách muối khỏi nước biển. Quan sát hiệu quả từng cách.")
    requiredDataPoints: 4
    dataHeaders: [qsTr("Phương pháp"), qsTr("Mức năng lượng"), qsTr("Kết quả")]

    property int currentStation: 0  // 0=solar, 1=heat, 2=filter
    property real solarIntensity: 0.5
    property real heatIntensity: 0.5
    property real evapProgress: 0

    Timer {
        id: evapTimer
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            if (currentStation === 0) {
                evapProgress = Math.min(1.0, evapProgress + solarIntensity * 0.005)
            } else if (currentStation === 1) {
                evapProgress = Math.min(1.0, evapProgress + heatIntensity * 0.015)
            }
            // Station 2 (filter) doesn't change evapProgress
        }
    }

    experimentArea: [
        Item {
            anchors.fill: parent

            // Station tabs
            Row {
                id: stationTabs
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 8

                Repeater {
                    model: [qsTr("A: Phơi nắng"), qsTr("B: Đun nóng"), qsTr("C: Lọc")]

                    TouchButton {
                        text: modelData
                        buttonColor: currentStation === index ? NeoConstants.stepColors[index] : "#E0E0E0"
                        textColor: currentStation === index ? "white" : "#666666"
                        fontSize: 12
                        height: 36
                        onClicked: {
                            currentStation = index
                            evapProgress = 0
                        }
                    }
                }
            }

            // Station A: Solar evaporation
            Item {
                visible: currentStation === 0
                anchors.top: stationTabs.bottom
                anchors.topMargin: 8
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                // Sun
                Rectangle {
                    x: parent.width * 0.7
                    y: 10
                    width: 40
                    height: 40
                    radius: 20
                    color: NeoConstants.sunshine
                    opacity: solarIntensity
                }

                // Shallow pan
                Rectangle {
                    anchors.centerIn: parent
                    width: parent.width * 0.6
                    height: 40
                    radius: 4
                    color: "#8D6E63"

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 3
                        radius: 2
                        color: evapProgress < 0.8 ? Qt.rgba(0.6, 0.8, 0.9, 1 - evapProgress * 0.8) : "white"

                        ParticleEffects {
                            anchors.fill: parent
                            effectType: "crystal"
                            running: evapProgress > 0.5
                            intensity: (evapProgress - 0.5) * 2
                        }

                        ParticleEffects {
                            anchors.fill: parent
                            effectType: "steam"
                            running: evapProgress < 0.9
                            intensity: solarIntensity * (1 - evapProgress)
                            particleColor: Qt.rgba(1, 1, 1, 0.3)
                        }
                    }
                }

                Text {
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: evapProgress >= 0.9 ? qsTr("✓ Muối kết tinh!") : qsTr("Bay hơi: ") + Math.round(evapProgress * 100) + "%"
                    font.pixelSize: NeoConstants.fontCaption
                    font.bold: true
                    color: evapProgress >= 0.9 ? NeoConstants.successGreen : "#666666"
                }
            }

            // Station B: Heating
            Item {
                visible: currentStation === 1
                anchors.top: stationTabs.bottom
                anchors.topMargin: 8
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                // Pot
                Rectangle {
                    anchors.centerIn: parent
                    width: parent.width * 0.4
                    height: width * 0.6
                    radius: 8
                    color: "#78909C"
                    border.width: 2
                    border.color: "#546E7A"

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 4
                        radius: 6
                        color: evapProgress < 0.8 ? Qt.rgba(0.7, 0.85, 0.95, 1 - evapProgress * 0.8) : "white"

                        ParticleEffects {
                            anchors.fill: parent
                            effectType: "bubbles"
                            running: heatIntensity > 0.3
                            intensity: heatIntensity
                        }

                        ParticleEffects {
                            anchors.fill: parent
                            effectType: "crystal"
                            running: evapProgress > 0.6
                            intensity: (evapProgress - 0.6) * 2.5
                        }
                    }
                }

                // Flame
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: parent.height * 0.15
                    spacing: 3
                    visible: heatIntensity > 0.1

                    Repeater {
                        model: Math.floor(heatIntensity * 5)
                        Rectangle {
                            width: 5
                            height: 8 + heatIntensity * 10
                            radius: 2
                            color: "#FF5722"
                        }
                    }
                }

                Text {
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: evapProgress >= 0.9 ? qsTr("✓ Muối kết tinh (nhanh)!") : qsTr("Bay hơi: ") + Math.round(evapProgress * 100) + "%"
                    font.pixelSize: NeoConstants.fontCaption
                    font.bold: true
                    color: evapProgress >= 0.9 ? NeoConstants.successGreen : "#666666"
                }
            }

            // Station C: Filtering (fails!)
            Item {
                visible: currentStation === 2
                anchors.top: stationTabs.bottom
                anchors.topMargin: 8
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                Column {
                    anchors.centerIn: parent
                    spacing: 12

                    // Funnel with filter paper
                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 80
                        height: 60
                        color: "transparent"

                        // Funnel shape
                        Rectangle {
                            anchors.top: parent.top
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: 80
                            height: 30
                            color: "#E3F2FD"
                            radius: 4

                            Text {
                                anchors.centerIn: parent
                                text: qsTr("Nước muối")
                                font.pixelSize: 10
                                color: "#1565C0"
                            }
                        }

                        // Filter paper
                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            y: 28
                            width: 60
                            height: 4
                            color: "#FFF9C4"
                            border.width: 1
                            border.color: "#F9A825"

                            Text {
                                anchors.top: parent.bottom
                                anchors.topMargin: 2
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: qsTr("Giấy lọc")
                                font.pixelSize: 9
                                color: "#F9A825"
                            }
                        }

                        // Water passing through
                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            y: 34
                            width: 30
                            height: 26
                            color: "#B3E5FC"
                            radius: 4

                            Text {
                                anchors.centerIn: parent
                                text: qsTr("Vẫn mặn!")
                                font.pixelSize: 10
                                font.bold: true
                                color: "#E53935"
                            }
                        }
                    }

                    // Explanation
                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 250
                        height: failText.implicitHeight + 16
                        radius: 8
                        color: Qt.lighter(NeoConstants.errorRed, 1.8)
                        border.width: 1
                        border.color: NeoConstants.errorRed

                        Text {
                            id: failText
                            anchors.centerIn: parent
                            width: parent.width - 16
                            text: qsTr("✗ Lọc KHÔNG tách được muối khỏi nước! Muối hòa tan hoàn toàn ở mức phân tử — nhỏ hơn lỗ giấy lọc rất nhiều.")
                            font.pixelSize: 12
                            color: NeoConstants.errorRed
                            wrapMode: Text.WordWrap
                        }
                    }
                }
            }
        }
    ]

    controlsArea: [
        RowLayout {
            anchors.fill: parent
            anchors.margins: 4
            spacing: 12

            SliderControl {
                Layout.fillWidth: true
                visible: currentStation === 0
                label: qsTr("☀ Cường độ nắng")
                value: solarIntensity
                from: 0.1
                to: 1.0
                labels: [qsTr("Yếu"), qsTr("Vừa"), qsTr("Mạnh")]
                accentColor: NeoConstants.sunshine
                onValueChanged: solarIntensity = value
            }

            SliderControl {
                Layout.fillWidth: true
                visible: currentStation === 1
                label: qsTr("🔥 Cường độ lửa")
                value: heatIntensity
                from: 0.1
                to: 1.0
                labels: [qsTr("Nhỏ"), qsTr("Vừa"), qsTr("Lớn")]
                accentColor: NeoConstants.warmOrange
                onValueChanged: heatIntensity = value
            }

            Text {
                visible: currentStation === 2
                Layout.fillWidth: true
                text: qsTr("Phương pháp lọc không hiệu quả cho hỗn hợp dung dịch")
                font.pixelSize: NeoConstants.fontCaption
                color: "#999999"
                wrapMode: Text.WordWrap
            }
        }
    ]

    function recordCurrentData() {
        var methods = [qsTr("Phơi nắng"), qsTr("Đun nóng"), qsTr("Lọc")]
        var energyLevels = [
            Math.round(solarIntensity * 100) + "%",
            Math.round(heatIntensity * 100) + "%",
            "N/A"
        ]
        var results = [
            evapProgress >= 0.9 ? qsTr("Có muối") : Math.round(evapProgress * 100) + qsTr("% bay hơi"),
            evapProgress >= 0.9 ? qsTr("Có muối") : Math.round(evapProgress * 100) + qsTr("% bay hơi"),
            qsTr("Thất bại - vẫn mặn")
        ]
        addDataPoint([methods[currentStation], energyLevels[currentStation], results[currentStation]])
    }

    function getConclusion() {
        return qsTr("Kết luận: Muối biển được tách bằng phương pháp BAY HƠI. " +
                    "Nước (dung môi) bay hơi, muối (chất tan) không bay hơi → muối kết tinh lại. " +
                    "Phơi nắng: chậm nhưng tiết kiệm năng lượng (dùng năng lượng mặt trời). " +
                    "Đun nóng: nhanh nhưng tốn nhiên liệu. " +
                    "Lọc: KHÔNG hiệu quả vì muối hòa tan ở mức phân tử, lọt qua mọi bộ lọc thông thường.")
    }
}
