import QtQuick
import "../../core"
import QtQuick.Layouts

InvestigationBase {
    title: qsTr("Thí nghiệm: Chai nước ngọt")
    instructions: qsTr("Thay đổi nhiệt độ nước và lắc chai. Quan sát mức bọt và áp suất. Ghi lại dữ liệu.")
    requiredDataPoints: 4
    dataHeaders: [qsTr("Nhiệt độ"), qsTr("Lắc"), qsTr("Mức bọt"), qsTr("Áp suất")]

    property int temperature: 0      // 0 = lạnh, 1 = ấm, 2 = nóng
    property bool shaken: false

    property real fizzLevel: {
        var base = 0
        if (temperature === 0) {
            base = 20
        } else if (temperature === 1) {
            base = 50
        } else {
            base = 85
        }
        if (shaken) {
            base = Math.min(100, base + 35)
        }
        return base
    }

    property real pressure: {
        var base = 0
        if (temperature === 0) {
            base = 30
        } else if (temperature === 1) {
            base = 55
        } else {
            base = 80
        }
        if (shaken) {
            base = Math.min(100, base + 25)
        }
        return base
    }

    experimentArea: [
        Item {
            anchors.fill: parent

            // Background
            Rectangle {
                anchors.fill: parent; radius: 8
                color: "#FAFAFA"
            }

            // Bottle body
            Rectangle {
                id: expBottle
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -parent.width * 0.12
                y: parent.height * 0.2
                width: 44; height: parent.height * 0.55
                radius: 8
                color: {
                    if (temperature === 0) {
                        return "#B3E5FC"
                    } else if (temperature === 1) {
                        return "#FFF9C4"
                    } else {
                        return "#FFCCBC"
                    }
                }
                border.width: 2
                border.color: {
                    if (temperature === 0) {
                        return "#0288D1"
                    } else if (temperature === 1) {
                        return "#F9A825"
                    } else {
                        return "#E64A19"
                    }
                }

                Behavior on color { ColorAnimation { duration: 400 } }
                Behavior on border.color { ColorAnimation { duration: 400 } }

                // Liquid
                Rectangle {
                    anchors.bottom: parent.bottom; anchors.bottomMargin: 4
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 8
                    height: parent.height * 0.7
                    radius: 6
                    color: {
                        if (temperature === 0) {
                            return "#81D4FA"
                        } else if (temperature === 1) {
                            return "#FFF176"
                        } else {
                            return "#FF8A65"
                        }
                    }
                    opacity: 0.5
                    Behavior on color { ColorAnimation { duration: 400 } }
                }

                // Bottle label
                Rectangle {
                    anchors.centerIn: parent
                    width: parent.width - 6; height: 22; radius: 3
                    color: "#43A047"
                    Text {
                        anchors.centerIn: parent
                        text: qsTr("CO₂")
                        font.pixelSize: 10; font.bold: true; color: "white"
                    }
                }
            }

            // Bottle neck
            Rectangle {
                anchors.horizontalCenter: expBottle.horizontalCenter
                y: expBottle.y - parent.height * 0.08
                width: 18; height: parent.height * 0.1
                radius: 4
                color: expBottle.color
                border.width: 2; border.color: expBottle.border.color
            }

            // Bubbles inside bottle
            Repeater {
                model: 10
                Rectangle {
                    property real bx: expBottle.x + 8 + (index % 4) * 8
                    property real bubSize: 3 + (index % 3) * 2
                    property int bubDur: 600 + index * 80

                    visible: fizzLevel > index * 10
                    x: bx
                    width: bubSize; height: bubSize; radius: bubSize / 2
                    color: "white"; opacity: 0.8

                    SequentialAnimation on y {
                        running: fizzLevel > index * 10; loops: Animation.Infinite
                        NumberAnimation {
                            from: expBottle.y + expBottle.height * 0.7
                            to: expBottle.y + expBottle.height * 0.1
                            duration: bubDur
                        }
                        NumberAnimation {
                            from: expBottle.y + expBottle.height * 0.7
                            to: expBottle.y + expBottle.height * 0.7
                            duration: 0
                        }
                    }
                }
            }

            // Foam at top
            Rectangle {
                visible: fizzLevel > 30
                anchors.horizontalCenter: expBottle.horizontalCenter
                y: expBottle.y - 8
                width: 50; height: fizzLevel > 60 ? 18 : 8
                radius: 10; color: "#FFFDE7"; opacity: 0.85

                Behavior on height { NumberAnimation { duration: 400 } }
            }

            // Pressure gauge
            Rectangle {
                id: gaugeArea
                anchors.right: parent.right; anchors.rightMargin: parent.width * 0.08
                anchors.verticalCenter: parent.verticalCenter
                width: 24; height: parent.height * 0.5
                radius: 12; color: "#ECEFF1"
                border.width: 1; border.color: "#B0BEC5"

                // Gauge fill
                Rectangle {
                    anchors.bottom: parent.bottom; anchors.bottomMargin: 3
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 16; radius: 8
                    height: Math.max(8, (parent.height - 6) * pressure / 100)
                    color: {
                        if (pressure < 40) {
                            return "#4CAF50"
                        } else if (pressure < 70) {
                            return "#FF9800"
                        } else {
                            return "#F44336"
                        }
                    }

                    Behavior on height { NumberAnimation { duration: 400 } }
                    Behavior on color { ColorAnimation { duration: 400 } }
                }
            }

            // Gauge label
            Text {
                anchors.horizontalCenter: gaugeArea.horizontalCenter
                anchors.top: gaugeArea.bottom; anchors.topMargin: 4
                text: qsTr("Áp suất")
                font.pixelSize: 10; font.bold: true; color: "#555"
            }

            // Pressure value badge
            Rectangle {
                anchors.horizontalCenter: gaugeArea.horizontalCenter
                anchors.bottom: gaugeArea.top; anchors.bottomMargin: 4
                width: pressText.implicitWidth + 10; height: pressText.implicitHeight + 4
                radius: 6
                color: pressure < 40 ? "#4CAF50" : (pressure < 70 ? "#FF9800" : "#F44336")
                Text {
                    id: pressText; anchors.centerIn: parent
                    text: qsTr("%1%").arg(Math.round(pressure))
                    font.pixelSize: NeoConstants.fontCaption; font.bold: true; color: "white"
                }
            }

            // Fizz level bar
            Rectangle {
                id: fizzBar
                x: parent.width * 0.55
                anchors.verticalCenter: parent.verticalCenter
                width: 24; height: parent.height * 0.5
                radius: 12; color: "#ECEFF1"
                border.width: 1; border.color: "#B0BEC5"

                Rectangle {
                    anchors.bottom: parent.bottom; anchors.bottomMargin: 3
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 16; radius: 8
                    height: Math.max(8, (parent.height - 6) * fizzLevel / 100)
                    color: "#29B6F6"

                    Behavior on height { NumberAnimation { duration: 400 } }
                }
            }

            // Fizz label
            Text {
                anchors.horizontalCenter: fizzBar.horizontalCenter
                anchors.top: fizzBar.bottom; anchors.topMargin: 4
                text: qsTr("Bọt")
                font.pixelSize: 10; font.bold: true; color: "#555"
            }

            // Fizz value badge
            Rectangle {
                anchors.horizontalCenter: fizzBar.horizontalCenter
                anchors.bottom: fizzBar.top; anchors.bottomMargin: 4
                width: fizzText.implicitWidth + 10; height: fizzText.implicitHeight + 4
                radius: 6; color: "#29B6F6"
                Text {
                    id: fizzText; anchors.centerIn: parent
                    text: qsTr("%1%").arg(Math.round(fizzLevel))
                    font.pixelSize: NeoConstants.fontCaption; font.bold: true; color: "white"
                }
            }

            // Temperature indicator text
            Text {
                anchors.horizontalCenter: expBottle.horizontalCenter
                anchors.top: expBottle.bottom; anchors.topMargin: 6
                text: {
                    if (temperature === 0) {
                        return qsTr("Lạnh")
                    } else if (temperature === 1) {
                        return qsTr("Ấm")
                    } else {
                        return qsTr("Nóng")
                    }
                }
                font.pixelSize: 12; font.bold: true
                color: {
                    if (temperature === 0) {
                        return "#0288D1"
                    } else if (temperature === 1) {
                        return "#F9A825"
                    } else {
                        return "#E64A19"
                    }
                }
            }

            // Shaken indicator
            Text {
                visible: shaken
                anchors.left: parent.left; anchors.leftMargin: 8
                anchors.top: parent.top; anchors.topMargin: 8
                text: qsTr("Đang lắc!")
                font.pixelSize: 12; font.bold: true; color: "#E65100"

                SequentialAnimation on opacity {
                    running: shaken; loops: Animation.Infinite
                    NumberAnimation { from: 0.5; to: 1.0; duration: 400 }
                    NumberAnimation { from: 1.0; to: 0.5; duration: 400 }
                }
            }
        }
    ]

    controlsArea: [
        Column {
            anchors.fill: parent; anchors.margins: 8; spacing: 4
            SliderControl {
                width: parent.width; height: (parent.height - 12) / 2
                label: qsTr("Nhiệt độ nước")
                value: temperature; from: 0; to: 2; stepSize: 1
                accentColor: {
                    if (temperature === 0) {
                        return "#0288D1"
                    } else if (temperature === 1) {
                        return "#F9A825"
                    } else {
                        return "#E64A19"
                    }
                }
                labels: [qsTr("Lạnh"), qsTr("Ấm"), qsTr("Nóng")]
                onValueChanged: { temperature = Math.round(value) }
            }

            // Shake toggle button
            Rectangle {
                width: parent.width; height: (parent.height - 12) / 2
                radius: 8; color: shaken ? "#FFF3E0" : "#F5F5F5"
                border.width: 2; border.color: shaken ? "#E65100" : "#BDBDBD"

                Column {
                    anchors.centerIn: parent; spacing: 4
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("Lắc chai")
                        font.pixelSize: NeoConstants.fontCaption; font.bold: true
                        color: "#555"
                    }
                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 56; height: 28; radius: 14
                        color: shaken ? "#FF6D00" : "#BDBDBD"

                        Rectangle {
                            y: 2
                            x: shaken ? parent.width - width - 2 : 2
                            width: 24; height: 24; radius: 12
                            color: "white"

                            Behavior on x { NumberAnimation { duration: 200 } }
                        }

                        Behavior on color { ColorAnimation { duration: 200 } }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: { shaken = !shaken }
                        }
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: shaken ? qsTr("BẬT") : qsTr("TẮT")
                        font.pixelSize: 11; font.bold: true
                        color: shaken ? "#E65100" : "#999"
                    }
                }
            }
        }
    ]

    function recordCurrentData() {
        var tempName = ""
        if (temperature === 0) {
            tempName = qsTr("Lạnh")
        } else if (temperature === 1) {
            tempName = qsTr("Ấm")
        } else {
            tempName = qsTr("Nóng")
        }
        var shakeName = shaken ? qsTr("Có") : qsTr("Không")
        var fizzName = ""
        if (fizzLevel < 35) {
            fizzName = qsTr("Ít")
        } else if (fizzLevel < 65) {
            fizzName = qsTr("Vừa")
        } else {
            fizzName = qsTr("Nhiều")
        }
        var pressName = ""
        if (pressure < 40) {
            pressName = qsTr("Thấp")
        } else if (pressure < 70) {
            pressName = qsTr("TB")
        } else {
            pressName = qsTr("Cao")
        }
        addDataPoint([tempName, shakeName, fizzName, pressName])
    }

    function getConclusion() {
        if (dataPoints.length >= requiredDataPoints) {
            return qsTr("Kết luận: CO₂ hòa tan trong nước dưới áp suất cao. " +
                        "Khi nhiệt độ TĂNG, độ tan CO₂ GIẢM → bọt phun nhiều hơn. " +
                        "Khi LẮC, CO₂ thoát ra nhanh hơn → áp suất tăng → phun mạnh hơn. " +
                        "Nước lạnh giữ ga tốt nhất vì CO₂ tan nhiều hơn ở nhiệt độ thấp.")
        }
        return qsTr("Cần thêm dữ liệu để kết luận.")
    }
}
