import QtQuick

Rectangle {
    id: root
    width: 80
    height: 80
    radius: 12
    color: highlighted ? Qt.lighter(NeoConstants.oceanBlue, 1.8) : "#F5F5F5"
    border.width: 2
    border.color: {
        if (isCorrect) return NeoConstants.successGreen
        if (isWrong) return NeoConstants.errorRed
        if (highlighted) return NeoConstants.oceanBlue
        return "#CCCCCC"
    }
    // Visual dashed effect when empty
    opacity: occupied ? 1.0 : 0.85

    property string zoneId: ""
    property string expectedItemId: ""
    property string label: ""
    property bool occupied: false
    property bool highlighted: false
    property bool isCorrect: false
    property bool isWrong: false

    signal itemDropped(string itemId)

    Text {
        anchors.centerIn: parent
        text: root.label
        font.pixelSize: 11
        color: "#999999"
        visible: !root.occupied
        width: parent.width - 6
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        elide: Text.ElideNone
    }

    DropArea {
        anchors.fill: parent
        onEntered: function(drag) { root.highlighted = true }
        onExited: { root.highlighted = false }
        onDropped: function(drop) {
            root.highlighted = false
            if (drop.source && drop.source.itemId) {
                root.itemDropped(drop.source.itemId)
            }
        }
    }

    function checkAnswer(itemId) {
        if (itemId === expectedItemId) {
            isCorrect = true
            isWrong = false
            occupied = true
            correctAnim.start()
            return true
        } else {
            isWrong = true
            isCorrect = false
            wrongAnim.start()
            return false
        }
    }

    function reset() {
        occupied = false
        isCorrect = false
        isWrong = false
    }

    SequentialAnimation {
        id: correctAnim
        ColorAnimation { target: root; property: "color"; to: Qt.lighter(NeoConstants.successGreen, 1.7); duration: 200 }
        ColorAnimation { target: root; property: "color"; to: Qt.lighter(NeoConstants.successGreen, 1.9); duration: 200 }
    }

    SequentialAnimation {
        id: wrongAnim
        NumberAnimation { target: root; property: "x"; from: root.x - 10; to: root.x + 10; duration: 50 }
        NumberAnimation { target: root; property: "x"; from: root.x + 10; to: root.x - 5; duration: 50 }
        NumberAnimation { target: root; property: "x"; to: root.x; duration: 50 }
        PropertyAction { target: root; property: "isWrong"; value: false }
    }

    Behavior on color { ColorAnimation { duration: NeoConstants.animFast } }
    Behavior on border.color { ColorAnimation { duration: NeoConstants.animFast } }
}
