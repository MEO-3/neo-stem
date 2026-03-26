import QtQuick
import "../../core"
import QtQuick.Layouts

InvestigationBase {
    title: qsTr("Thí nghiệm: Kem tan trong các môi trường")
    instructions: qsTr("Đặt kem vào 3 môi trường: phòng (25°C), ngoài nắng (40°C), và nắng+gió (40°C+gió). Điều chỉnh thời gian và quan sát tốc độ tan.")
    requiredDataPoints: 5
    dataHeaders: [qsTr("Môi trường"), qsTr("Thời gian (phút)"), qsTr("% Tan")]

    // 0 = room temp, 1 = sun, 2 = fan+sun
    property int environment: 0
    property real timeMinutes: 0  // 0-30
    property real meltPercent: {
        var rate = 0
        if (environment === 0) {
            rate = 2.5  // room: slow
        } else if (environment === 1) {
            rate = 5.0  // sun: fast
        } else {
            rate = 6.5  // fan+sun: fastest (convection)
        }
        return Math.min(100, timeMinutes * rate)
    }

    property var envNames: [qsTr("Phòng 25°C"), qsTr("Ngoài nắng 40°C"), qsTr("Nắng+Gió 40°C")]

    experimentArea: [
        Item {
            anchors.fill: parent

            // Background based on environment
            Rectangle {
                anchors.fill: parent; radius: 8
                color: {
                    if (environment === 0) return "#E3F2FD"
                    if (environment === 1) return "#FFF8E1"
                    return "#FFF3E0"
                }
            }

            // Sun indicator (visible for sun and fan+sun)
            Rectangle {
                visible: environment > 0
                x: parent.width * 0.8; y: 10
                width: 36; height: 36; radius: 18
                color: "#FFD600"

                SequentialAnimation on opacity {
                    running: environment > 0; loops: Animation.Infinite
                    NumberAnimation { from: 0.7; to: 1.0; duration: 1000; easing.type: Easing.InOutSine }
                    NumberAnimation { from: 1.0; to: 0.7; duration: 1000; easing.type: Easing.InOutSine }
                }
            }

            // Wind lines (visible for fan+sun)
            Repeater {
                model: environment === 2 ? 4 : 0
                Rectangle {
                    id: windLine
                    property real windStartX: parent.width * 0.05
                    property real windEndX: parent.width * 0.4
                    y: parent.height * (0.25 + index * 0.15)
                    width: 20; height: 2; radius: 1
                    color: "#90CAF9"

                    property int windDuration: 800 + index * 200

                    SequentialAnimation on x {
                        running: environment === 2; loops: Animation.Infinite
                        NumberAnimation { from: windLine.windStartX; to: windLine.windEndX; duration: windLine.windDuration }
                        NumberAnimation { from: windLine.windStartX; to: windLine.windStartX; duration: 0 }
                    }
                    SequentialAnimation on opacity {
                        running: environment === 2; loops: Animation.Infinite
                        NumberAnimation { from: 0.0; to: 1.0; duration: 200 }
                        NumberAnimation { from: 1.0; to: 0.0; duration: windLine.windDuration - 200 }
                    }
                }
            }

            // Ice cream visualization
            Item {
                anchors.centerIn: parent
                width: 80; height: 130

                // Cone
                Canvas {
                    anchors.fill: parent
                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.clearRect(0, 0, width, height)
                        ctx.beginPath()
                        ctx.moveTo(width * 0.15, height * 0.45)
                        ctx.lineTo(width * 0.5, height * 0.95)
                        ctx.lineTo(width * 0.85, height * 0.45)
                        ctx.closePath()
                        ctx.fillStyle = "#D4A056"
                        ctx.fill()
                    }
                }

                // Scoop - changes shape based on melt
                Rectangle {
                    id: scoopVis
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: parent.height * 0.08
                    width: 55 + meltPercent * 0.15
                    height: Math.max(10, 50 - meltPercent * 0.35)
                    radius: height / 2
                    color: {
                        var r = 0.97 - meltPercent * 0.001
                        var g = 0.73 - meltPercent * 0.002
                        var b = 0.82 - meltPercent * 0.001
                        return Qt.rgba(r, g, b, 1.0)
                    }
                }

                // Puddle (grows with melt)
                Rectangle {
                    visible: meltPercent > 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: parent.height * 0.88
                    width: meltPercent * 0.8 + 10
                    height: Math.min(meltPercent * 0.15 + 3, 18)
                    radius: height / 2
                    color: "#F8BBD0"
                    opacity: Math.min(1.0, meltPercent / 50)
                }

                // Drips (visible when melting)
                Repeater {
                    model: meltPercent > 15 ? 2 : 0
                    Rectangle {
                        id: meltDrip
                        property real dripX: parent.width * (0.3 + index * 0.4)
                        property real meltDripStart: parent.height * 0.5
                        property real meltDripEnd: parent.height * 0.88
                        x: dripX; width: 4; height: 6; radius: 3
                        color: "#F48FB1"

                        property int meltDripDur: 1500 + index * 500

                        SequentialAnimation on y {
                            running: meltPercent > 15; loops: Animation.Infinite
                            NumberAnimation { from: meltDrip.meltDripStart; to: meltDrip.meltDripEnd; duration: meltDrip.meltDripDur; easing.type: Easing.InQuad }
                            NumberAnimation { from: meltDrip.meltDripStart; to: meltDrip.meltDripStart; duration: 0 }
                        }
                    }
                }
            }

            // Melt percentage display
            Rectangle {
                anchors.right: parent.right; anchors.rightMargin: 8
                anchors.top: parent.top; anchors.topMargin: 8
                width: meltLabel.implicitWidth + 16; height: meltLabel.implicitHeight + 8
                radius: 8
                color: meltPercent < 30 ? NeoConstants.oceanBlue : (meltPercent < 70 ? NeoConstants.warmOrange : NeoConstants.errorRed)

                Text {
                    id: meltLabel; anchors.centerIn: parent
                    text: qsTr("Tan: %1%").arg(Math.round(meltPercent))
                    font.pixelSize: NeoConstants.fontCaption; font.bold: true; color: "white"
                }
            }

            // Environment label
            Text {
                anchors.bottom: parent.bottom; anchors.bottomMargin: 4
                anchors.horizontalCenter: parent.horizontalCenter
                text: envNames[environment]
                font.pixelSize: NeoConstants.fontCaption; color: "#555555"; font.bold: true
            }
        }
    ]

    controlsArea: [
        RowLayout {
            anchors.fill: parent; anchors.margins: 4
            spacing: 8

            // Environment selector
            Column {
                Layout.preferredWidth: parent.width * 0.35
                spacing: 4

                Text {
                    text: qsTr("Môi trường:")
                    font.pixelSize: 12; font.bold: true; color: "#555555"
                }

                Row {
                    spacing: 4

                    Repeater {
                        model: [qsTr("Phòng"), qsTr("Nắng"), qsTr("Nắng+Gió")]

                        Rectangle {
                            width: 58; height: 28; radius: 6
                            color: environment === index ? NeoConstants.oceanBlue : "#E0E0E0"
                            border.width: environment === index ? 2 : 0
                            border.color: NeoConstants.oceanBlue

                            Text {
                                anchors.centerIn: parent
                                text: modelData
                                font.pixelSize: 10; font.bold: true
                                color: environment === index ? "white" : "#666666"
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: { environment = index }
                            }
                        }
                    }
                }
            }

            // Time slider
            SliderControl {
                Layout.fillWidth: true; Layout.fillHeight: true
                label: qsTr("Thời gian (phút)")
                value: timeMinutes; from: 0; to: 30; stepSize: 1
                unit: qsTr("phút")
                accentColor: NeoConstants.warmOrange
                onValueChanged: { timeMinutes = value }
            }
        }
    ]

    function recordCurrentData() {
        addDataPoint([envNames[environment], Math.round(timeMinutes), Math.round(meltPercent)])
    }

    function getConclusion() {
        if (dataPoints.length >= requiredDataPoints) {
            return qsTr("Kết luận: Kem tan nhanh nhất khi ở ngoài nắng có gió (đối lưu + bức xạ), " +
                        "nhanh vừa khi ở ngoài nắng (bức xạ nhiệt), và chậm nhất trong phòng (chỉ dẫn nhiệt). " +
                        "Nhiệt truyền từ môi trường nóng hơn vào kem lạnh hơn bằng 3 cách: dẫn nhiệt, đối lưu, và bức xạ. " +
                        "Càng nhiều cách truyền nhiệt cùng lúc, kem tan càng nhanh!")
        }
        return qsTr("Cần thêm dữ liệu để kết luận. Hãy thử các môi trường và thời gian khác nhau.")
    }
}
