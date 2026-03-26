import QtQuick
import "../../core"
import QtQuick.Layouts

InvestigationBase {
    title: qsTr("Thí nghiệm: Chai nước và tần số")
    instructions: qsTr("Chọn từng chai (1-5), điều chỉnh mực nước và gõ thử. Quan sát tần số âm thanh thay đổi theo cột không khí. Ghi lại dữ liệu.")
    requiredDataPoints: 5
    dataHeaders: [qsTr("Chai #"), qsTr("% Nước"), qsTr("Tần số (Hz)"), qsTr("Cao/Trầm")]

    property int selectedBottle: 0
    property var waterLevels: [20, 40, 50, 70, 90]
    property real currentWater: waterLevels[selectedBottle]
    property real airColumn: 100 - currentWater
    property real frequency: 200 + (currentWater / 100) * 600  // more water = shorter air = higher freq

    experimentArea: [
        Item {
            anchors.fill: parent

            // Background
            Rectangle {
                anchors.fill: parent; radius: 8
                color: "#E8F5E9"
            }

            // Title
            Text {
                anchors.top: parent.top; anchors.topMargin: 6
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Gõ chai — Quan sát tần số âm thanh")
                font.pixelSize: NeoConstants.fontCaption; font.bold: true; color: "#2E7D32"
            }

            // 5 bottles side by side
            Row {
                id: bottleRow
                anchors.centerIn: parent; spacing: 8

                Repeater {
                    model: 5
                    Item {
                        id: bottleItem
                        property real wLevel: waterLevels[index]
                        property bool isSelected: selectedBottle === index
                        property real waveBaseScale: 1.0
                        property real waveTargetScale: 1.6
                        width: (bottleRow.parent.width - 60) / 5; height: bottleRow.parent.height * 0.6

                        // Selection highlight
                        Rectangle {
                            anchors.fill: parent; anchors.margins: -3
                            radius: 8; color: "transparent"
                            border.width: isSelected ? 3 : 0; border.color: "#FF6F00"
                        }

                        // Bottle body
                        Rectangle {
                            id: bBody
                            anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.8; height: parent.height * 0.7
                            radius: 4; color: "transparent"
                            border.width: 2; border.color: "#78909C"

                            // Water
                            Rectangle {
                                anchors.bottom: parent.bottom; anchors.horizontalCenter: parent.horizontalCenter
                                anchors.margins: 2
                                width: parent.width - 4
                                height: Math.max(0, (parent.height - 4) * wLevel / 100)
                                radius: 3; color: isSelected ? "#42A5F5" : "#90CAF9"; opacity: 0.85
                            }
                        }

                        // Bottle neck
                        Rectangle {
                            anchors.bottom: bBody.top; anchors.bottomMargin: -2
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width * 0.35; height: parent.height * 0.25
                            radius: 3; color: "transparent"
                            border.width: 2; border.color: "#78909C"
                        }

                        // Sound wave when selected
                        Rectangle {
                            id: selWave
                            anchors.centerIn: bBody
                            width: bBody.width * 1.2; height: width; radius: width / 2
                            color: "transparent"
                            border.width: 2; border.color: "#FF9800"
                            visible: isSelected

                            SequentialAnimation on scale {
                                running: isSelected; loops: Animation.Infinite
                                NumberAnimation { from: selWave.parent.waveBaseScale; to: selWave.parent.waveTargetScale; duration: 800 }
                                PauseAnimation { duration: 200 }
                            }
                            SequentialAnimation on opacity {
                                running: isSelected; loops: Animation.Infinite
                                NumberAnimation { from: 0.6; to: 0.0; duration: 800 }
                                PauseAnimation { duration: 200 }
                            }
                        }

                        // Bottle number
                        Text {
                            anchors.top: parent.bottom; anchors.topMargin: 2
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: qsTr("Chai %1").arg(index + 1)
                            font.pixelSize: 10; font.bold: isSelected; color: isSelected ? "#FF6F00" : "#5D4037"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: { selectedBottle = index }
                        }
                    }
                }
            }

            // Sound wave visualization bar
            Row {
                anchors.bottom: parent.bottom; anchors.bottomMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 2
                Repeater {
                    model: 30
                    Rectangle {
                        property real waveH: (frequency / 800) * 30 * Math.abs(Math.sin((index / 30.0) * Math.PI * (2 + currentWater / 25)))
                        width: 3; height: Math.max(2, waveH); radius: 1
                        color: NeoConstants.warmOrange
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            // Frequency display badge
            Rectangle {
                anchors.right: parent.right; anchors.rightMargin: 8
                anchors.top: parent.top; anchors.topMargin: 8
                width: freqText.implicitWidth + 16; height: freqText.implicitHeight + 8
                radius: 8; color: frequency > 500 ? "#E53935" : (frequency > 350 ? "#FF9800" : "#1565C0")
                Text {
                    id: freqText; anchors.centerIn: parent
                    text: qsTr("%1 Hz — %2").arg(Math.round(frequency)).arg(frequency > 500 ? qsTr("Cao") : (frequency > 350 ? qsTr("Vừa") : qsTr("Trầm")))
                    font.pixelSize: NeoConstants.fontCaption; font.bold: true; color: "white"
                }
            }

            // Air column info
            Rectangle {
                anchors.left: parent.left; anchors.leftMargin: 8
                anchors.top: parent.top; anchors.topMargin: 8
                width: airText.implicitWidth + 16; height: airText.implicitHeight + 8
                radius: 8; color: "#26A69A"
                Text {
                    id: airText; anchors.centerIn: parent
                    text: qsTr("Cột khí: %1%").arg(Math.round(airColumn))
                    font.pixelSize: NeoConstants.fontCaption; font.bold: true; color: "white"
                }
            }
        }
    ]

    controlsArea: [
        Column {
            anchors.fill: parent; anchors.margins: 8
            spacing: 4

            // Bottle selector row
            Row {
                width: parent.width; spacing: 4
                Repeater {
                    model: 5
                    Rectangle {
                        width: (parent.width - 16) / 5; height: 32
                        radius: 6; color: selectedBottle === index ? "#FF6F00" : "#E0E0E0"
                        Text {
                            anchors.centerIn: parent
                            text: qsTr("Chai %1").arg(index + 1)
                            font.pixelSize: 11; font.bold: true
                            color: selectedBottle === index ? "white" : "#333"
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: { selectedBottle = index }
                        }
                    }
                }
            }

            SliderControl {
                width: parent.width; height: parent.height - 40
                label: qsTr("Mực nước chai %1").arg(selectedBottle + 1)
                value: waterLevels[selectedBottle]; from: 5; to: 95; stepSize: 1
                accentColor: "#1565C0"
                labels: [qsTr("5%"), qsTr("50%"), qsTr("95%")]
                onValueChanged: {
                    var lvls = waterLevels
                    lvls[selectedBottle] = value
                    waterLevels = lvls
                }
            }
        }
    ]

    function recordCurrentData() {
        var pitchLabel = frequency > 500 ? qsTr("Cao") : (frequency > 350 ? qsTr("Vừa") : qsTr("Trầm"))
        addDataPoint([selectedBottle + 1, Math.round(currentWater), Math.round(frequency), pitchLabel])
    }

    function getConclusion() {
        if (dataPoints.length >= requiredDataPoints) {
            return qsTr("Kết luận: Khi gõ chai nước, cột không khí bên trong chai rung tạo sóng âm. " +
                        "Chai nhiều nước → cột không khí NGẮN → rung NHANH → tần số CAO → tiếng cao. " +
                        "Chai ít nước → cột không khí DÀI → rung CHẬM → tần số THẤP → tiếng trầm. " +
                        "Chiều dài cột không khí quyết định tần số và cao độ âm thanh!")
        }
        return qsTr("Cần thêm dữ liệu để kết luận.")
    }
}
