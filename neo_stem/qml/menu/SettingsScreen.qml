import QtQuick
import "../core"
import QtQuick.Controls

Item {
    id: root

    signal backClicked()

    Rectangle {
        anchors.fill: parent
        color: NeoConstants.ricePaper
    }

    // Top bar
    Rectangle {
        id: topBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 56
        color: NeoConstants.oceanBlue

        Row {
            anchors.fill: parent
            anchors.leftMargin: 12
            spacing: 12

            TouchButton {
                width: 48; height: 48
                text: "⬅"
                fontSize: 20
                buttonColor: "transparent"
                textColor: "white"
                anchors.verticalCenter: parent.verticalCenter
                onClicked: root.backClicked()
            }

            Text {
                text: qsTr("Cài đặt")
                font.pixelSize: NeoConstants.fontBody
                font.bold: true
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Column {
        anchors.top: topBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 24
        spacing: 24

        // Sound effects volume
        SliderControl {
            width: parent.width
            label: qsTr("🔊 Âm lượng hiệu ứng")
            value: 0.8
            from: 0.0
            to: 1.0
            accentColor: NeoConstants.oceanBlue
        }

        // Voice volume
        SliderControl {
            width: parent.width
            label: qsTr("🗣 Âm lượng giọng nói")
            value: 0.8
            from: 0.0
            to: 1.0
            accentColor: NeoConstants.forestGreen
        }

        // Separator
        Rectangle { width: parent.width; height: 1; color: "#E0E0E0" }

        // Large text mode
        Column {
            width: parent.width
            spacing: 8

            Text {
                text: qsTr("🔤 Cỡ chữ")
                font.pixelSize: NeoConstants.fontCaption
                font.bold: true
                color: "#555555"
            }

            Row {
                spacing: 12

                TouchButton {
                    text: qsTr("Bình thường")
                    buttonColor: !NeoConstants.largeTextMode ? NeoConstants.forestGreen : "#E0E0E0"
                    textColor: !NeoConstants.largeTextMode ? "white" : "#666666"
                    fontSize: NeoConstants.fontCaption
                    onClicked: NeoConstants.largeTextMode = false
                }

                TouchButton {
                    text: qsTr("Chữ lớn")
                    buttonColor: NeoConstants.largeTextMode ? NeoConstants.warmOrange : "#E0E0E0"
                    textColor: NeoConstants.largeTextMode ? "white" : "#666666"
                    fontSize: NeoConstants.fontCaption
                    onClicked: NeoConstants.largeTextMode = true
                }
            }

            Text {
                width: parent.width
                text: NeoConstants.largeTextMode
                      ? qsTr("Chữ to hơn 25%, phù hợp trẻ nhỏ và màn hình lớn")
                      : qsTr("Cỡ chữ mặc định, phù hợp hầu hết màn hình")
                font.pixelSize: NeoConstants.fontSmall
                color: "#888888"
                wrapMode: Text.WordWrap
            }
        }

        // Separator
        Rectangle { width: parent.width; height: 1; color: "#E0E0E0" }

        // Language
        Column {
            width: parent.width
            spacing: 8

            Text {
                text: qsTr("🌐 Ngôn ngữ / Language")
                font.pixelSize: NeoConstants.fontCaption
                font.bold: true
                color: "#555555"
            }

            Row {
                spacing: 12

                TouchButton {
                    text: "Tiếng Việt"
                    buttonColor: NeoConstants.forestGreen
                    textColor: "white"
                    fontSize: NeoConstants.fontCaption
                }

                TouchButton {
                    text: "English"
                    buttonColor: "#E0E0E0"
                    textColor: "#666666"
                    fontSize: NeoConstants.fontCaption
                }
            }
        }

        // Separator
        Rectangle { width: parent.width; height: 1; color: "#E0E0E0" }

        // Reset progress
        Column {
            width: parent.width
            spacing: 8

            Text {
                text: qsTr("⚠ Đặt lại tiến độ")
                font.pixelSize: NeoConstants.fontCaption
                font.bold: true
                color: NeoConstants.errorRed
            }

            TouchButton {
                text: qsTr("Xóa tất cả tiến độ")
                buttonColor: NeoConstants.errorRed
                textColor: "white"
                fontSize: NeoConstants.fontCaption
                onClicked: resetDialog.open()
            }
        }

        // About
        Column {
            width: parent.width
            spacing: 4

            Rectangle { width: parent.width; height: 1; color: "#E0E0E0" }

            Text {
                text: qsTr("Về NEO STEM")
                font.pixelSize: NeoConstants.fontCaption
                font.bold: true
                color: "#555555"
                topPadding: 12
            }

            Text {
                width: parent.width
                text: qsTr("NEO STEM v1.0\nPhần mềm giáo dục STEM cho trẻ em Việt Nam\nDựa trên phương pháp OpenSciEd\n\nCộng đồng Bình Dân Học STEM & Robot")
                font.pixelSize: NeoConstants.fontSmall
                color: "#888888"
                wrapMode: Text.WordWrap
            }
        }
    }

    // Reset confirmation dialog
    Dialog {
        id: resetDialog
        anchors.centerIn: parent
        width: 300
        title: qsTr("Xác nhận")
        modal: true
        standardButtons: Dialog.Ok | Dialog.Cancel

        contentItem: Text {
            text: qsTr("Bạn có chắc muốn xóa tất cả tiến độ? Hành động này không thể hoàn tác.")
            font.pixelSize: NeoConstants.fontCaption
            color: "#333333"
            wrapMode: Text.WordWrap
            padding: 12
        }

        onAccepted: ProgressTracker.resetAll()
    }
}
