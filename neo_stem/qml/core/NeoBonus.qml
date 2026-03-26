import QtQuick
import QtQuick.Controls

Popup {
    id: root
    anchors.centerIn: parent
    width: Math.min(parent.width * 0.7, 400)
    height: 320
    modal: true
    closePolicy: Popup.NoAutoClose

    property int stars: 0
    property bool isQuestionComplete: false

    signal dismissed()

    background: Rectangle {
        radius: 24
        color: NeoConstants.cardBg
        border.width: 4
        border.color: stars >= 2 ? NeoConstants.sunshine : NeoConstants.warmOrange

        // Glow effect
        Rectangle {
            anchors.fill: parent
            anchors.margins: -8
            radius: 28
            color: "transparent"
            border.width: 4
            border.color: stars >= 2 ? Qt.rgba(1, 0.84, 0, 0.3) : "transparent"
        }
    }

    contentItem: Column {
        spacing: 16
        anchors.centerIn: parent

        // Title
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.isQuestionComplete
                  ? qsTr("🎉 Hoàn thành câu hỏi!")
                  : (root.stars >= 2 ? qsTr("Tuyệt vời!") : qsTr("Cố gắng thêm!"))
            font.pixelSize: NeoConstants.fontTitle
            font.bold: true
            color: NeoConstants.forestGreen
        }

        // Stars display
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 12

            Repeater {
                model: 3
                Text {
                    text: index < root.stars ? "★" : "☆"
                    font.pixelSize: 48
                    color: index < root.stars ? NeoConstants.sunshine : "#CCCCCC"

                    SequentialAnimation on scale {
                        running: root.visible && index < root.stars
                        PauseAnimation { duration: index * 200 }
                        NumberAnimation { from: 0; to: 1.3; duration: 200; easing.type: Easing.OutBack }
                        NumberAnimation { from: 1.3; to: 1.0; duration: 150 }
                    }
                }
            }
        }

        // Message
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: {
                if (root.isQuestionComplete) return qsTr("Bạn đã khám phá xong!")
                if (root.stars === 3) return qsTr("Hoàn hảo! Bạn giỏi lắm!")
                if (root.stars === 2) return qsTr("Rất tốt! Tiếp tục nhé!")
                if (root.stars === 1) return qsTr("Được rồi, thử bước tiếp!")
                return qsTr("Hãy thử lại nhé!")
            }
            font.pixelSize: NeoConstants.fontBody
            color: "#555555"
        }

        // Continue button
        TouchButton {
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.isQuestionComplete ? qsTr("Về bản đồ") : qsTr("Tiếp tục")
            buttonColor: NeoConstants.forestGreen
            textColor: "white"
            fontSize: NeoConstants.fontButton
            onClicked: {
                root.close()
                root.dismissed()
            }
        }
    }

    enter: Transition {
        NumberAnimation { property: "opacity"; from: 0; to: 1; duration: NeoConstants.animNormal }
        NumberAnimation { property: "scale"; from: 0.5; to: 1; duration: NeoConstants.animNormal; easing.type: Easing.OutBack }
    }

    exit: Transition {
        NumberAnimation { property: "opacity"; from: 1; to: 0; duration: NeoConstants.animFast }
    }
}
