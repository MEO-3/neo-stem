import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    anchors.fill: parent

    property int questionId: 0
    property int stepIndex: 2
    property string title: qsTr("Thí nghiệm")
    property string instructions: ""
    property alias experimentArea: experimentContent.data
    property alias controlsArea: controlsContent.data

    // Data recording
    property var dataPoints: []
    property int requiredDataPoints: 5
    property var dataHeaders: []  // ["Nhiệt độ", "Trạng thái"]

    signal stepCompleted(int stars)
    signal dataRecorded(var point)

    function showHelp() {
        helpPopup.open()
    }

    Rectangle {
        anchors.fill: parent
        color: NeoConstants.ricePaper
        radius: 12
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 8

        // Title
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 44
            radius: 8
            color: NeoConstants.stepTeal

            Text {
                anchors.centerIn: parent
                text: root.title
                font.pixelSize: NeoConstants.fontBody
                font.bold: true
                color: "white"
            }
        }

        // Instructions
        Text {
            Layout.fillWidth: true
            text: root.instructions
            font.pixelSize: NeoConstants.fontCaption
            color: "#555555"
            wrapMode: Text.WordWrap
        }

        // Experiment visualization
        Item {
            id: experimentContent
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: 120
        }

        // Controls
        Item {
            id: controlsContent
            Layout.fillWidth: true
            Layout.preferredHeight: 80
            Layout.minimumHeight: 60
        }

        // Data table
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 120
            Layout.minimumHeight: 80
            radius: 8
            color: NeoConstants.cardBg
            border.width: 1
            border.color: "#E0E0E0"

            Column {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 4

                // Table header
                Row {
                    spacing: 2
                    width: parent.width

                    Text {
                        width: 30
                        text: "#"
                        font.pixelSize: 12
                        font.bold: true
                        color: "#666666"
                    }

                    Repeater {
                        model: root.dataHeaders
                        Text {
                            width: (parent.width - 30) / root.dataHeaders.length
                            text: modelData
                            font.pixelSize: 12
                            font.bold: true
                            color: "#666666"
                            elide: Text.ElideRight
                        }
                    }
                }

                Rectangle { width: parent.width; height: 1; color: "#E0E0E0" }

                // Data rows
                ListView {
                    width: parent.width
                    height: parent.height - 30
                    clip: true
                    model: root.dataPoints

                    delegate: Row {
                        required property int index
                        required property var modelData
                        property int rowIndex: index
                        property var rowData: modelData
                        spacing: 2
                        width: ListView.view.width

                        Text {
                            width: 30
                            text: (rowIndex + 1)
                            font.pixelSize: 11
                            color: "#333333"
                        }

                        Repeater {
                            model: root.dataHeaders.length
                            Text {
                                required property int index
                                property int colIndex: index
                                width: (parent.width - 30) / root.dataHeaders.length
                                text: rowData ? (rowData[colIndex] !== undefined ? String(rowData[colIndex]) : "") : ""
                                font.pixelSize: 11
                                color: "#333333"
                                elide: Text.ElideRight
                            }
                        }
                    }
                }
            }
        }

        // Record feedback
        Text {
            id: recordFeedback
            Layout.fillWidth: true
            visible: false
            text: ""
            font.pixelSize: 12
            font.bold: true
            color: NeoConstants.successGreen
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        Timer {
            id: feedbackTimer
            interval: 3000
            onTriggered: recordFeedback.visible = false
        }

        // Record + Complete buttons
        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            TouchButton {
                text: qsTr("📝 Ghi dữ liệu")
                buttonColor: NeoConstants.oceanBlue
                textColor: "white"
                fontSize: NeoConstants.fontCaption
                onClicked: root.recordCurrentData()
            }

            Text {
                text: root.dataPoints.length + "/" + root.requiredDataPoints
                font.pixelSize: NeoConstants.fontCaption
                font.bold: true
                color: root.dataPoints.length >= root.requiredDataPoints
                       ? NeoConstants.successGreen : "#666666"
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignCenter
            }

            TouchButton {
                text: qsTr("Kết luận →")
                buttonColor: root.dataPoints.length >= root.requiredDataPoints
                             ? NeoConstants.forestGreen : "#AAAAAA"
                textColor: "white"
                fontSize: NeoConstants.fontCaption
                enabled: root.dataPoints.length >= root.requiredDataPoints
                onClicked: conclusionPopup.open()
            }
        }
    }

    function recordCurrentData() {
        // Override in subclass to capture current experiment state
        // Call addDataPoint({header1: value1, header2: value2})
    }

    function addDataPoint(point) {
        var newArr = dataPoints.slice()
        newArr.push(point)
        dataPoints = newArr
        dataRecorded(point)
        // Show recorded feedback
        recordFeedback.text = qsTr("✅ Đã ghi: ") + point.join(", ")
        recordFeedback.visible = true
        feedbackTimer.restart()
    }

    // Conclusion popup
    Popup {
        id: conclusionPopup
        anchors.centerIn: parent
        width: Math.min(parent.width * 0.85, 400)
        height: 250
        modal: true

        background: Rectangle { radius: 16; color: NeoConstants.cardBg }

        contentItem: Column {
            spacing: 12
            padding: 16

            Text {
                text: qsTr("🔬 Kết luận thí nghiệm")
                font.pixelSize: NeoConstants.fontBody
                font.bold: true
                color: NeoConstants.stepTeal
            }

            Text {
                id: conclusionText
                width: parent.width - 32
                text: root.getConclusion()
                font.pixelSize: NeoConstants.fontCaption
                color: "#333333"
                wrapMode: Text.WordWrap
            }

            TouchButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Hoàn thành thí nghiệm")
                buttonColor: NeoConstants.forestGreen
                textColor: "white"
                onClicked: {
                    conclusionPopup.close()
                    var stars = root.dataPoints.length >= root.requiredDataPoints + 2 ? 3
                             : root.dataPoints.length >= root.requiredDataPoints ? 2 : 1
                    root.stepCompleted(stars)
                }
            }
        }
    }

    function getConclusion() {
        return qsTr("Dựa trên dữ liệu thu thập, bạn đã hoàn thành thí nghiệm!")
    }

    // Help popup
    Popup {
        id: helpPopup
        anchors.centerIn: parent
        width: Math.min(parent.width * 0.8, 360)
        height: 200
        modal: true
        background: Rectangle { radius: 16; color: NeoConstants.cardBg }
        contentItem: Column {
            spacing: 12
            padding: 16
            Text {
                text: qsTr("💡 Hướng dẫn thí nghiệm")
                font.pixelSize: NeoConstants.fontBody
                font.bold: true
                color: NeoConstants.stepTeal
            }
            Text {
                width: parent.width - 32
                text: qsTr("1. Điều chỉnh biến số bằng slider\n2. Quan sát thay đổi\n3. Bấm 'Ghi dữ liệu' để lưu\n4. Lặp lại ít nhất ") + root.requiredDataPoints + qsTr(" lần\n5. Bấm 'Kết luận' khi đủ dữ liệu")
                font.pixelSize: NeoConstants.fontCaption
                color: "#555555"
                wrapMode: Text.WordWrap
            }
            TouchButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Đã hiểu!")
                buttonColor: NeoConstants.oceanBlue
                textColor: "white"
                onClicked: helpPopup.close()
            }
        }
    }
}
