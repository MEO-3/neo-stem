import QtQuick
import "../../core"
import QtQuick.Layouts

InvestigationBase {
    title: qsTr("Thí nghiệm: Cần tây trong nước muối")
    instructions: qsTr("Đặt cần tây vào 3 cốc nước khác nhau. Quan sát sự thay đổi sau vài giờ (mô phỏng nhanh).")
    requiredDataPoints: 4
    dataHeaders: [qsTr("Nồng độ muối"), qsTr("Trạng thái cần tây"), qsTr("Tế bào")]

    property real saltLevel: 0.0  // 0=ngọt, 0.5=hơi mặn, 1.0=rất mặn
    property real timeElapsed: 0  // simulation time

    Timer {
        id: simTimer
        interval: 50
        running: true
        repeat: true
        onTriggered: {
            if (timeElapsed < 100)
                timeElapsed += 0.5
        }
    }

    property string celeryState: {
        if (saltLevel < 0.2) return qsTr("Tươi, cứng")
        if (saltLevel < 0.6) return timeElapsed > 50 ? qsTr("Hơi mềm") : qsTr("Bình thường")
        return timeElapsed > 30 ? qsTr("Héo, mềm nhũn") : qsTr("Bắt đầu héo")
    }

    property string cellState: {
        if (saltLevel < 0.2) return qsTr("Nước vào tế bào → căng")
        if (saltLevel < 0.6) return qsTr("Cân bằng")
        return qsTr("Nước rút ra → tế bào co")
    }

    experimentArea: [
        Item {
            anchors.fill: parent

            Row {
                anchors.centerIn: parent
                spacing: 20

                // Three cups
                Repeater {
                    model: [
                        { salt: 0, label: qsTr("Nước ngọt"), color: "#E3F2FD" },
                        { salt: 0.5, label: qsTr("Hơi mặn (1%)"), color: "#B3E5FC" },
                        { salt: 1.0, label: qsTr("Rất mặn (5%)"), color: "#81D4FA" }
                    ]

                    Column {
                        spacing: 4
                        width: Math.min(120, (parent.parent.width - 60) / 3)

                        // Cup
                        Rectangle {
                            width: parent.width
                            height: width * 1.2
                            radius: 8
                            color: modelData.color
                            border.width: 2
                            border.color: Qt.darker(modelData.color, 1.2)

                            // Celery stick
                            Rectangle {
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 8
                                width: 8
                                height: parent.height * 0.8
                                radius: 4
                                color: {
                                    if (modelData.salt < 0.2) return "#4CAF50"
                                    if (modelData.salt < 0.6 && timeElapsed > 50) return "#8BC34A"
                                    if (modelData.salt >= 0.6 && timeElapsed > 30) return "#A1887F"
                                    return "#66BB6A"
                                }

                                // Wilting bend for high salt
                                rotation: modelData.salt >= 0.6 && timeElapsed > 30 ? 15 : 0
                                transformOrigin: Item.Bottom

                                Behavior on rotation { NumberAnimation { duration: 1000 } }
                                Behavior on color { ColorAnimation { duration: 500 } }
                            }

                            // Salt particles
                            Repeater {
                                model: Math.floor(modelData.salt * 10)
                                Rectangle {
                                    x: 8 + Math.random() * (parent.width - 16)
                                    y: parent.height * 0.5 + Math.random() * parent.height * 0.4
                                    width: 3
                                    height: 3
                                    color: "white"
                                    opacity: 0.6
                                }
                            }
                        }

                        // Label
                        Text {
                            width: parent.width
                            text: modelData.label
                            font.pixelSize: 11
                            font.bold: true
                            color: "#333333"
                            horizontalAlignment: Text.AlignHCenter
                            wrapMode: Text.WordWrap
                        }

                        // Cell view indicator
                        Rectangle {
                            width: parent.width
                            height: 28
                            radius: 6
                            color: modelData.salt === saltLevel ? NeoConstants.oceanBlue : "#F5F5F5"

                            Text {
                                anchors.centerIn: parent
                                text: modelData.salt === saltLevel ? qsTr("🔬 Đang xem") : qsTr("Chọn xem")
                                font.pixelSize: 10
                                color: modelData.salt === saltLevel ? "white" : "#999999"
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    saltLevel = modelData.salt
                                    timeElapsed = 0
                                }
                            }
                        }
                    }
                }
            }

            // Microscopic cell view
            Rectangle {
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                width: Math.min(140, parent.width * 0.3)
                height: width
                radius: width / 2
                color: "#F3E5F5"
                border.width: 2
                border.color: "#CE93D8"

                Text {
                    anchors.top: parent.top
                    anchors.topMargin: 8
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "🔬"
                    font.pixelSize: 20
                }

                // Cell representation
                Rectangle {
                    anchors.centerIn: parent
                    width: {
                        if (saltLevel < 0.2) return parent.width * 0.55
                        if (saltLevel < 0.6) return parent.width * 0.45
                        return parent.width * 0.3  // Plasmolysis
                    }
                    height: width
                    radius: width / 2
                    color: Qt.rgba(0.5, 0.8, 0.5, 0.6)
                    border.width: 2
                    border.color: "#4CAF50"

                    Behavior on width { NumberAnimation { duration: NeoConstants.animSlow } }

                    Text {
                        anchors.centerIn: parent
                        text: qsTr("Tế bào")
                        font.pixelSize: 9
                        color: "#1B5E20"
                    }
                }

                // Arrows showing water direction
                Text {
                    anchors.centerIn: parent
                    anchors.horizontalCenterOffset: parent.width * 0.3
                    text: saltLevel < 0.2 ? "→" : (saltLevel >= 0.6 ? "←" : "↔")
                    font.pixelSize: 18
                    font.bold: true
                    color: NeoConstants.oceanBlue
                }

                Text {
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 8
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: cellState
                    font.pixelSize: 9
                    color: "#555555"
                    width: parent.width - 16
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    ]

    controlsArea: [
        RowLayout {
            anchors.fill: parent
            anchors.margins: 4

            SliderControl {
                Layout.fillWidth: true
                label: qsTr("🧂 Nồng độ muối")
                value: saltLevel
                from: 0.0
                to: 1.0
                accentColor: NeoConstants.stepTeal
                labels: [qsTr("Ngọt"), qsTr("Nhạt"), qsTr("Mặn"), qsTr("Rất mặn")]
                onValueChanged: {
                    saltLevel = value
                    timeElapsed = 0
                }
            }

            Text {
                text: qsTr("Thời gian: ") + Math.round(timeElapsed) + qsTr("h")
                font.pixelSize: NeoConstants.fontCaption
                color: "#666666"
            }
        }
    ]

    function recordCurrentData() {
        var saltLabel = saltLevel < 0.2 ? qsTr("Ngọt") : (saltLevel < 0.6 ? qsTr("Hơi mặn") : qsTr("Rất mặn"))
        addDataPoint([saltLabel, celeryState, cellState])
    }

    function getConclusion() {
        return qsTr("Kết luận: Nước di chuyển từ nơi có nồng độ muối THẤP sang nơi có nồng độ muối CAO (thẩm thấu). " +
                    "Trong nước mặn, nước rút ra khỏi tế bào → cây héo. " +
                    "Cây đước có cơ chế đặc biệt: rễ lọc muối, lá tiết muối, giữ nước bên trong tế bào. " +
                    "Đó là lý do chỉ cây ngập mặn mới sống được trong môi trường mặn.")
    }
}
