import QtQuick

Item {
    id: root
    width: 60
    height: 200

    property real temperature: 25  // °C
    property real minTemp: 0
    property real maxTemp: 120
    property color mercuryColor: {
        if (temperature >= 100) return "#E53935"
        if (temperature >= 60) return "#FF7043"
        if (temperature >= 30) return "#FFB300"
        return "#29B6F6"
    }

    // Thermometer body
    Rectangle {
        id: tube
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        width: 20
        height: parent.height - 50
        radius: 10
        color: "#F5F5F5"
        border.width: 2
        border.color: "#BDBDBD"

        // Mercury fill
        Rectangle {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 6
            height: Math.max(8, (parent.height - 6) * (root.temperature - root.minTemp) / (root.maxTemp - root.minTemp))
            radius: 7
            color: root.mercuryColor

            Behavior on height {
                NumberAnimation { duration: NeoConstants.animSlow; easing.type: Easing.OutQuad }
            }
            Behavior on color {
                ColorAnimation { duration: NeoConstants.animNormal }
            }
        }

        // Temperature marks
        Repeater {
            model: 5
            Rectangle {
                anchors.right: tube.left
                anchors.rightMargin: 2
                y: tube.height - (tube.height * (index + 1) / 5) - 1
                width: 10
                height: 2
                color: "#999999"

                Text {
                    anchors.right: parent.left
                    anchors.rightMargin: 4
                    anchors.verticalCenter: parent.verticalCenter
                    text: Math.round(root.minTemp + (root.maxTemp - root.minTemp) * (index + 1) / 5) + "°"
                    font.pixelSize: 10
                    color: "#666666"
                }
            }
        }
    }

    // Bulb
    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: tube.bottom
        anchors.topMargin: -6
        width: 32
        height: 32
        radius: 16
        color: root.mercuryColor
        border.width: 2
        border.color: "#BDBDBD"
    }

    // Digital readout
    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        width: 56
        height: 22
        radius: 4
        color: "#333333"

        Text {
            anchors.centerIn: parent
            text: Math.round(root.temperature) + "°C"
            font.pixelSize: 13
            font.bold: true
            color: root.mercuryColor
            font.family: "monospace"
        }
    }
}
