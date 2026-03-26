import QtQuick

Rectangle {
    id: root
    width: 160
    height: 100
    radius: 4
    rotation: -3 + Math.random() * 6  // Slight random tilt like real sticky notes
    color: {
        var colors = ["#FFF59D", "#FFCC80", "#A5D6A7", "#90CAF9", "#CE93D8"]
        return colors[noteIndex % colors.length]
    }

    property int noteIndex: 0
    property string noteText: ""
    property bool answered: false
    property bool editable: true

    signal noteClicked()
    signal noteEdited(string newText)

    // Sticky note shadow
    Rectangle {
        anchors.fill: parent
        anchors.topMargin: 3
        anchors.leftMargin: 3
        radius: parent.radius
        color: "#40000000"
        z: -1
    }

    Column {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 4

        // Question number
        Text {
            text: "?" + (root.noteIndex + 1)
            font.pixelSize: 12
            font.bold: true
            color: "#666666"
        }

        // Note content
        Text {
            id: noteLabel
            width: parent.width
            text: root.noteText
            font.pixelSize: 13
            color: "#333333"
            wrapMode: Text.WordWrap
            maximumLineCount: 3
            elide: Text.ElideRight
            visible: !editMode.visible
        }

        TextInput {
            id: editMode
            width: parent.width
            text: root.noteText
            font.pixelSize: 13
            color: "#333333"
            wrapMode: TextInput.WordWrap
            visible: false

            function finishEdit() {
                if (!visible) return
                visible = false
                noteLabel.visible = true
                root.noteText = text
                root.noteEdited(text)
            }

            onAccepted: finishEdit()
            onActiveFocusChanged: {
                if (!activeFocus) finishEdit()
            }
        }
    }

    // Answered checkmark
    Rectangle {
        visible: root.answered
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 4
        width: 22
        height: 22
        radius: 11
        color: NeoConstants.successGreen

        Text {
            anchors.centerIn: parent
            text: "✓"
            color: "white"
            font.pixelSize: 14
            font.bold: true
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (root.editable && !root.answered) {
                editMode.visible = true
                noteLabel.visible = false
                editMode.forceActiveFocus()
            }
            root.noteClicked()
        }
    }

    Behavior on scale {
        NumberAnimation { duration: NeoConstants.animFast; easing.type: Easing.OutBack }
    }
}
