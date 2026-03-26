import QtQuick
import "../../core"
import QtQuick.Layouts

InvestigationBase {
    title: qsTr("Thí nghiệm: Mang cá và oxy")
    instructions: qsTr("Điều chỉnh nồng độ oxy trong nước và tốc độ dòng chảy. Quan sát mang cá hấp thụ O₂ vào máu. Ghi lại dữ liệu.")
    requiredDataPoints: 5
    dataHeaders: [qsTr("O₂ nước (%)"), qsTr("Tốc độ nước"), qsTr("O₂ hấp thụ")]

    property real oxygenLevel: 50    // 0-100%
    property real waterSpeed: 0.5    // 0-1
    property real absorbedO2: Math.min(oxygenLevel, oxygenLevel * (0.3 + waterSpeed * 0.7))

    experimentArea: [
        Item {
            anchors.fill: parent

            // Background: gill cross-section
            Rectangle {
                anchors.fill: parent; radius: 8
                color: "#FFEBEE"
            }

            // Gill arch (central structure)
            Rectangle {
                id: gillArch
                x: parent.width * 0.45; y: parent.height * 0.1
                width: 12; height: parent.height * 0.75; radius: 4
                color: "#C62828"

                // Gill filaments (branches)
                Repeater {
                    model: 6
                    Rectangle {
                        property real fy: index * (gillArch.height / 6) + 10
                        x: gillArch.width; y: fy
                        width: parent.width * 0.6; height: 4; radius: 2
                        color: "#E53935"

                        // Capillaries on filament
                        Repeater {
                            model: 4
                            Rectangle {
                                x: 8 + index * 14; y: -2
                                width: 2; height: 8; radius: 1
                                color: absorbedO2 > 30 ? "#D32F2F" : "#EF9A9A"
                            }
                        }
                    }
                }
            }

            // Water flow arrows (left side)
            Repeater {
                model: 5
                Text {
                    id: waterArrow
                    property real baseX: parent.width * 0.05
                    property real targetX: parent.width * 0.40
                    property real arrowY: parent.height * (0.15 + index * 0.15)
                    property int flowDur: Math.max(400, 2000 - Math.round(waterSpeed * 1500))
                    x: baseX; y: arrowY
                    text: qsTr("→ H₂O")
                    font.pixelSize: 11; color: "#1565C0"; opacity: 0.7

                    SequentialAnimation on x {
                        running: true; loops: Animation.Infinite
                        NumberAnimation { from: waterArrow.baseX; to: waterArrow.targetX; duration: waterArrow.flowDur; easing.type: Easing.Linear }
                    }
                }
            }

            // O2 molecules moving toward gill
            Repeater {
                model: 6
                Rectangle {
                    id: o2Mol
                    property real startX: parent.width * (0.10 + index * 0.05)
                    property real endX: parent.width * 0.44
                    property real molY: parent.height * (0.12 + index * 0.13)
                    property int molDur: Math.max(500, 2500 - Math.round(waterSpeed * 1800))
                    x: startX; y: molY
                    width: 10; height: 10; radius: 5
                    color: "#42A5F5"
                    visible: oxygenLevel > index * 15

                    Text {
                        anchors.centerIn: parent
                        text: qsTr("O₂"); font.pixelSize: 6; color: "white"; font.bold: true
                    }

                    SequentialAnimation on x {
                        running: true; loops: Animation.Infinite
                        NumberAnimation { from: o2Mol.startX; to: o2Mol.endX; duration: o2Mol.molDur; easing.type: Easing.InOutSine }
                    }
                }
            }

            // Absorbed O2 in blood vessels (right side)
            Repeater {
                model: 4
                Rectangle {
                    id: bloodO2
                    property real bStartY: parent.height * (0.2 + index * 0.16)
                    property real bEndY: parent.height * (0.1 + index * 0.16)
                    x: parent.width * 0.65; y: bStartY
                    width: 8; height: 8; radius: 4
                    color: "#D32F2F"
                    visible: absorbedO2 > index * 20

                    Text {
                        anchors.centerIn: parent
                        text: qsTr("O₂"); font.pixelSize: 5; color: "white"; font.bold: true
                    }

                    SequentialAnimation on y {
                        running: true; loops: Animation.Infinite
                        NumberAnimation { from: bloodO2.bStartY; to: bloodO2.bEndY; duration: 1500; easing.type: Easing.InOutSine }
                        NumberAnimation { from: bloodO2.bEndY; to: bloodO2.bStartY; duration: 1500; easing.type: Easing.InOutSine }
                    }
                }
            }

            // CO2 exiting (right to left)
            Repeater {
                model: 3
                Text {
                    id: co2Exit
                    property real co2StartX: parent.width * 0.50
                    property real co2EndX: parent.width * 0.80
                    property real co2Y: parent.height * (0.25 + index * 0.2)
                    x: co2StartX; y: co2Y
                    text: qsTr("CO₂"); font.pixelSize: 9; color: "#78909C"; opacity: 0.6

                    SequentialAnimation on x {
                        running: true; loops: Animation.Infinite
                        NumberAnimation { from: co2Exit.co2StartX; to: co2Exit.co2EndX; duration: 2000; easing.type: Easing.Linear }
                    }
                }
            }

            // Labels
            Text {
                anchors.top: parent.top; anchors.topMargin: 5
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Mô hình mang cá — Mao mạch hấp thụ O₂")
                font.pixelSize: NeoConstants.fontCaption; font.bold: true; color: "#B71C1C"
            }

            // Absorption indicator
            Rectangle {
                anchors.right: parent.right; anchors.rightMargin: 8
                anchors.bottom: parent.bottom; anchors.bottomMargin: 8
                width: absorbText.implicitWidth + 16; height: absorbText.implicitHeight + 8
                radius: 8; color: absorbedO2 > 40 ? "#43A047" : (absorbedO2 > 20 ? "#FF9800" : "#E53935")
                Text {
                    id: absorbText; anchors.centerIn: parent
                    text: qsTr("O₂ hấp thụ: %1%").arg(Math.round(absorbedO2))
                    font.pixelSize: NeoConstants.fontCaption; font.bold: true; color: "white"
                }
            }

            // Water-side / Blood-side labels
            Text {
                x: parent.width * 0.1; y: parent.height * 0.88
                text: qsTr("← Nước vào"); font.pixelSize: 10; color: "#1565C0"; font.bold: true
            }
            Text {
                x: parent.width * 0.65; y: parent.height * 0.88
                text: qsTr("Máu mang O₂ →"); font.pixelSize: 10; color: "#C62828"; font.bold: true
            }
        }
    ]

    controlsArea: [
        Column {
            anchors.fill: parent; anchors.margins: 8
            spacing: 4

            SliderControl {
                width: parent.width; height: parent.height * 0.5 - 2
                label: qsTr("Nồng độ O₂ trong nước")
                value: oxygenLevel; from: 0; to: 100; stepSize: 1
                accentColor: "#1565C0"
                labels: [qsTr("0%"), qsTr("50%"), qsTr("100%")]
                onValueChanged: oxygenLevel = value
            }

            SliderControl {
                width: parent.width; height: parent.height * 0.5 - 2
                label: qsTr("Tốc độ dòng nước")
                value: waterSpeed; from: 0; to: 1; stepSize: 0.05
                accentColor: "#0277BD"
                labels: [qsTr("Chậm"), qsTr("Vừa"), qsTr("Nhanh")]
                onValueChanged: waterSpeed = value
            }
        }
    ]

    function recordCurrentData() {
        var speedLabel = waterSpeed < 0.33 ? qsTr("Chậm") : (waterSpeed < 0.66 ? qsTr("Vừa") : qsTr("Nhanh"))
        addDataPoint([Math.round(oxygenLevel), speedLabel, Math.round(absorbedO2) + "%"])
    }

    function getConclusion() {
        if (dataPoints.length >= requiredDataPoints) {
            return qsTr("Kết luận: Mang cá hấp thụ oxy HÒA TAN trong nước. " +
                        "Nước chảy qua hàng nghìn mao mạch trong mang — O₂ khuếch tán từ nước vào máu, " +
                        "còn CO₂ từ máu khuếch tán ra nước. " +
                        "Nồng độ O₂ trong nước càng cao và dòng nước càng mạnh thì mang hấp thụ O₂ càng nhiều. " +
                        "Đây là trao đổi khí ngược dòng — rất hiệu quả!")
        }
        return qsTr("Cần thêm dữ liệu để kết luận.")
    }
}
