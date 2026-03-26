import QtQuick
import QtQuick.Controls

Item {
    id: root
    anchors.fill: parent

    property int questionId: 0
    property int stepIndex: 3
    property string title: qsTr("Xây dựng mô hình")
    property string instructions: ""

    // Model definition
    property var correctSequence: []   // [{id: "water", label: "Nước lỏng"}, ...]
    property var distractors: []       // [{id: "freeze", label: "Đóng băng"}, ...]
    property var dropZoneLabels: []    // ["Bước 1", "Bước 2", ...]

    // State
    property var placedItems: ({})     // {zoneId: itemId}
    property int correctCount: 0
    property bool completed: false

    signal stepCompleted(int stars)

    function showHelp() {
        helpPopup.open()
    }

    Rectangle {
        anchors.fill: parent
        color: NeoConstants.ricePaper
        radius: 12
    }

    Column {
        id: mainColumn
        anchors.fill: parent
        anchors.margins: 12
        spacing: 12

        // Title
        Rectangle {
            width: parent.width
            height: 44
            radius: 8
            color: NeoConstants.stepIndigo

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
            width: parent.width
            text: root.instructions || qsTr("Kéo các ô vào đúng vị trí để xây dựng mô hình giải thích hiện tượng")
            font.pixelSize: NeoConstants.fontCaption
            color: "#555555"
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
        }

        // Drop zones (diagram flow)
        Flow {
            id: dropZonesFlow
            width: parent.width
            spacing: 2

            Repeater {
                id: dropZoneRepeater
                model: root.correctSequence.length

                Row {
                    spacing: 2

                    DropZone {
                        id: dropZoneItem
                        zoneId: "zone_" + index
                        expectedItemId: root.correctSequence[index].id
                        label: root.dropZoneLabels.length > index ? root.dropZoneLabels[index] : (qsTr("Bước ") + (index + 1))
                        width: {
                            var n = root.correctSequence.length
                            var arrowSpace = (n - 1) * 20
                            return Math.max(60, (root.width - 24 - arrowSpace) / n - 4)
                        }
                        height: 65

                        onItemDropped: function(itemId) {
                            root.handleDrop(dropZoneItem.zoneId, itemId, dropZoneItem)
                        }
                    }

                    // Arrow between zones
                    Text {
                        visible: index < root.correctSequence.length - 1
                        text: "→"
                        font.pixelSize: 16
                        color: NeoConstants.stepIndigo
                        height: 65
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
        }

        // Divider
        Rectangle {
            width: parent.width
            height: 2
            color: "#E0E0E0"
        }

        // Draggable tiles label
        Text {
            text: qsTr("Kéo các ô dưới đây:")
            font.pixelSize: NeoConstants.fontCaption
            color: "#666666"
        }

        // Tile container (explicit positioning, not Flow)
        Item {
            id: tileContainer
            width: parent.width
            height: 130

            property real tileWidth: Math.min(120, (width - 60) / 3)

            Repeater {
                id: tilesRepeater
                model: root._shuffledTiles

                DragItem {
                    itemId: modelData.id
                    label: modelData.label
                    width: tileContainer.tileWidth
                    height: 56
                    dragParent: dragOverlay
                }
            }

            Component.onCompleted: Qt.callLater(layoutTiles)
            onWidthChanged: Qt.callLater(layoutTiles)

            function layoutTiles() {
                var tileW = tileWidth
                var spacing = 10
                var xPos = 0
                var yPos = 0
                for (var i = 0; i < tilesRepeater.count; i++) {
                    var tile = tilesRepeater.itemAt(i)
                    if (!tile) continue
                    if (tile.placed) continue  // Don't reposition placed tiles
                    tile.x = xPos
                    tile.y = yPos
                    tile.homeX = xPos
                    tile.homeY = yPos
                    tile.homeParent = tileContainer
                    xPos += tileW + spacing
                    if (xPos + tileW > tileContainer.width) {
                        xPos = 0
                        yPos += 66
                    }
                }
            }
        }

        // Status
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 16

            Text {
                text: qsTr("Đúng: ") + root.correctCount + "/" + root.correctSequence.length
                font.pixelSize: NeoConstants.fontCaption
                font.bold: true
                color: root.correctCount === root.correctSequence.length
                       ? NeoConstants.successGreen : "#666666"
                anchors.verticalCenter: parent.verticalCenter
            }

            TouchButton {
                visible: root.completed
                text: qsTr("Hoàn thành →")
                buttonColor: NeoConstants.forestGreen
                textColor: "white"
                onClicked: {
                    var stars = root.correctCount === root.correctSequence.length ? 3
                             : root.correctCount >= root.correctSequence.length - 1 ? 2 : 1
                    root.stepCompleted(stars)
                }
            }
        }
    }

    // Drag overlay - tiles are reparented here during drag for free movement
    Item {
        id: dragOverlay
        anchors.fill: parent
        z: 1000
    }

    // Shuffled tiles (computed once)
    property var _shuffledTiles: {
        var all = correctSequence.concat(distractors)
        for (var i = all.length - 1; i > 0; i--) {
            var j = Math.floor(Math.random() * (i + 1))
            var tmp = all[i]; all[i] = all[j]; all[j] = tmp
        }
        return all
    }

    function handleDrop(zoneId, itemId, dropZone) {
        var isCorrect = dropZone.checkAnswer(itemId)

        // Find the drag item
        for (var i = 0; i < tilesRepeater.count; i++) {
            var tile = tilesRepeater.itemAt(i)
            if (tile && tile.itemId === itemId) {
                if (isCorrect) {
                    // Snap tile to drop zone center (in drag overlay coords)
                    var center = dropZone.mapToItem(dragOverlay, dropZone.width / 2, dropZone.height / 2)
                    tile.snapTo(center.x, center.y)
                    tile.targetDropZone = zoneId
                    placedItems[zoneId] = itemId
                    correctCount++

                    if (correctCount === correctSequence.length) {
                        completed = true
                        completionAnim.start()
                    }
                } else {
                    tile.returnToOrigin()
                }
                break
            }
        }
    }

    SequentialAnimation {
        id: completionAnim
        PauseAnimation { duration: 500 }
        ScriptAction {
            script: {
                // All correct - celebration
            }
        }
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
                text: qsTr("💡 Hướng dẫn")
                font.pixelSize: NeoConstants.fontBody
                font.bold: true
                color: NeoConstants.stepIndigo
            }
            Text {
                width: parent.width - 32
                text: qsTr("Kéo từng ô vào vị trí phù hợp trong sơ đồ. Ô đúng sẽ chuyển xanh, ô sai sẽ bật lại. Cẩn thận với các ô nhiễu!")
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
