import QtQuick

Rectangle {
    id: root
    width: NeoConstants.dragItemSize
    height: NeoConstants.dragItemSize
    radius: 12
    color: NeoConstants.cardBg
    border.width: 2
    border.color: dragging ? NeoConstants.oceanBlue : "#DDDDDD"

    property string label: ""
    property string itemId: ""
    property bool dragging: false
    property bool placed: false
    property string targetDropZone: ""

    // Home position (set by ModelBuilder after layout)
    property real homeX: 0
    property real homeY: 0
    property Item homeParent: null

    // Drag overlay parent (set by ModelBuilder)
    property Item dragParent: null

    signal dragStarted()
    signal dragFinished(real dropX, real dropY)

    Drag.source: root
    Drag.hotSpot.x: width / 2
    Drag.hotSpot.y: height / 2

    Text {
        anchors.centerIn: parent
        text: root.label
        font.pixelSize: 12
        font.bold: true
        color: root.placed ? "white" : "#333333"
        width: parent.width - 8
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        onPressed: function(mouse) {
            if (root.placed) {
                mouse.accepted = false
                return
            }
            returnAnim.stop()
            snapAnim.stop()

            // Save home position before reparenting
            root.homeX = root.x
            root.homeY = root.y
            root.homeParent = root.parent

            // Reparent to drag overlay for free movement
            if (root.dragParent && root.dragParent !== root.parent) {
                var scenePos = root.mapToItem(root.dragParent, 0, 0)
                root.parent = root.dragParent
                root.x = scenePos.x
                root.y = scenePos.y
            }

            root.Drag.active = true
            root.dragging = true
            root.z = 100
            root.dragStarted()
        }

        onPositionChanged: function(mouse) {
            if (root.dragging) {
                // Manual position update (since drag.target doesn't work well with reparenting)
                root.x = root.x + mouse.x - width / 2
                root.y = root.y + mouse.y - height / 2
            }
        }

        onReleased: function(mouse) {
            if (root.dragging) {
                root.Drag.drop()
                root.Drag.active = false
                root.dragging = false
                root.z = 1

                if (!root.placed) {
                    root.returnToOrigin()
                }
                root.dragFinished(root.x + root.width / 2, root.y + root.height / 2)
            }
        }
    }

    function returnToOrigin() {
        root.placed = false
        root.targetDropZone = ""

        if (root.homeParent && root.parent !== root.homeParent) {
            // Map home position to current parent for animation
            var targetPos = root.homeParent.mapToItem(root.parent, root.homeX, root.homeY)
            returnAnim.toX = targetPos.x
            returnAnim.toY = targetPos.y
            returnAnim.reparentAfter = true
        } else {
            returnAnim.toX = root.homeX
            returnAnim.toY = root.homeY
            returnAnim.reparentAfter = false
        }
        returnAnim.start()
    }

    ParallelAnimation {
        id: returnAnim
        property real toX: 0
        property real toY: 0
        property bool reparentAfter: false

        NumberAnimation { target: root; property: "x"; to: returnAnim.toX; duration: NeoConstants.animNormal; easing.type: Easing.OutBack }
        NumberAnimation { target: root; property: "y"; to: returnAnim.toY; duration: NeoConstants.animNormal; easing.type: Easing.OutBack }

        onFinished: {
            if (reparentAfter && root.homeParent) {
                root.parent = root.homeParent
                root.x = root.homeX
                root.y = root.homeY
            }
        }
    }

    function snapTo(targetX, targetY) {
        root.placed = true
        snapAnim.toX = targetX - width / 2
        snapAnim.toY = targetY - height / 2
        snapAnim.start()
    }

    ParallelAnimation {
        id: snapAnim
        property real toX: 0
        property real toY: 0
        NumberAnimation { target: root; property: "x"; to: snapAnim.toX; duration: NeoConstants.animFast; easing.type: Easing.OutQuad }
        NumberAnimation { target: root; property: "y"; to: snapAnim.toY; duration: NeoConstants.animFast; easing.type: Easing.OutQuad }
    }

    // Visual feedback
    states: [
        State {
            name: "dragging"
            when: root.dragging
            PropertyChanges { target: root; scale: 1.15; opacity: 0.85 }
        },
        State {
            name: "placed"
            when: root.placed
            PropertyChanges { target: root; border.color: NeoConstants.successGreen; border.width: 3; color: NeoConstants.successGreen }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "scale,opacity"; duration: NeoConstants.animFast }
        ColorAnimation { duration: NeoConstants.animFast }
    }
}
