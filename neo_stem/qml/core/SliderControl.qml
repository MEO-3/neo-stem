import QtQuick
import QtQuick.Controls

Column {
    id: root
    spacing: 8

    property string label: ""
    property real value: 0.5
    property real from: 0.0
    property real to: 1.0
    property real stepSize: 0.01
    property string unit: ""
    property color accentColor: NeoConstants.warmOrange
    property var labels: []  // e.g. ["Thấp", "Vừa", "Cao"]

    Text {
        text: root.label
        font.pixelSize: NeoConstants.fontCaption
        font.bold: true
        color: "#555555"
    }

    Row {
        spacing: 8
        width: parent.width

        Slider {
            id: slider
            width: parent.width - valueText.width - 16
            from: root.from
            to: root.to
            value: root.value
            stepSize: root.stepSize
            onValueChanged: root.value = value

            background: Rectangle {
                x: slider.leftPadding
                y: slider.topPadding + slider.availableHeight / 2 - 4
                width: slider.availableWidth
                height: 8
                radius: 4
                color: "#E0E0E0"

                Rectangle {
                    width: slider.visualPosition * parent.width
                    height: parent.height
                    radius: 4
                    color: root.accentColor
                }
            }

            handle: Rectangle {
                x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                y: slider.topPadding + slider.availableHeight / 2 - height / 2
                width: 28
                height: 28
                radius: 14
                color: slider.pressed ? Qt.darker(root.accentColor, 1.1) : root.accentColor
                border.width: 3
                border.color: "white"

                Behavior on color { ColorAnimation { duration: 100 } }
            }
        }

        Text {
            id: valueText
            width: 60
            text: {
                if (root.labels.length > 0) {
                    var idx = Math.round((root.value - root.from) / (root.to - root.from) * (root.labels.length - 1))
                    return root.labels[Math.max(0, Math.min(idx, root.labels.length - 1))]
                }
                return Math.round(root.value * 100) / 100 + (root.unit ? " " + root.unit : "")
            }
            font.pixelSize: NeoConstants.fontCaption
            font.bold: true
            color: root.accentColor
            horizontalAlignment: Text.AlignRight
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
