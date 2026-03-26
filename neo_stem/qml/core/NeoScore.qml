import QtQuick

Row {
    id: root
    spacing: 4

    property int stars: 0
    property int maxStars: 3
    property int starSize: 28

    Repeater {
        model: root.maxStars
        Text {
            text: index < root.stars ? "★" : "☆"
            font.pixelSize: root.starSize
            color: index < root.stars ? NeoConstants.sunshine : "#CCCCCC"

            Behavior on color {
                ColorAnimation { duration: NeoConstants.animFast }
            }
        }
    }
}
