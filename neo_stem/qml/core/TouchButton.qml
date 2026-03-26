import QtQuick

Rectangle {
    id: root
    width: Math.max(buttonContent.implicitWidth + 32, NeoConstants.touchMin)
    height: NeoConstants.buttonHeight
    radius: height / 2
    color: enabled ? buttonColor : "#CCCCCC"

    property string text: ""
    property color buttonColor: NeoConstants.forestGreen
    property color textColor: "white"
    property int fontSize: NeoConstants.fontButton
    property string iconText: ""

    signal clicked()

    Row {
        id: buttonContent
        anchors.centerIn: parent
        spacing: 8

        Text {
            visible: root.iconText !== ""
            text: root.iconText
            font.pixelSize: root.fontSize
            color: root.textColor
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: root.text
            font.pixelSize: root.fontSize
            font.bold: true
            color: root.textColor
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    MouseArea {
        anchors.fill: parent
        onPressed: root.scale = 0.92
        onReleased: root.scale = 1.0
        onClicked: root.clicked()
        onCanceled: root.scale = 1.0
    }

    Behavior on scale {
        NumberAnimation { duration: 100; easing.type: Easing.OutQuad }
    }

    Behavior on color {
        ColorAnimation { duration: NeoConstants.animFast }
    }
}
