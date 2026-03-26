import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    height: 64
    color: NeoConstants.forestGreen

    property string questionTitle: ""
    property int currentStep: 0
    property int totalSteps: 5
    property var stepStars: [0, 0, 0, 0, 0]

    signal homeClicked()
    signal backClicked()
    signal helpClicked()

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        spacing: 8

        // Home button
        TouchButton {
            Layout.preferredWidth: 48
            Layout.preferredHeight: 48
            text: "⌂"
            fontSize: 24
            buttonColor: "transparent"
            textColor: "white"
            onClicked: root.homeClicked()
        }

        // Back button
        TouchButton {
            Layout.preferredWidth: 48
            Layout.preferredHeight: 48
            text: "◄"
            fontSize: 20
            buttonColor: "transparent"
            textColor: "white"
            onClicked: root.backClicked()
        }

        // Title
        Text {
            Layout.fillWidth: true
            text: root.questionTitle
            color: "white"
            font.pixelSize: NeoConstants.fontBody
            font.bold: true
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignHCenter
        }

        // Step indicator dots
        Row {
            spacing: 6
            Repeater {
                model: root.totalSteps
                Rectangle {
                    width: 32
                    height: 32
                    radius: 16
                    color: index === root.currentStep
                           ? NeoConstants.stepColors[index]
                           : (root.stepStars[index] > 0 ? Qt.lighter(NeoConstants.stepColors[index], 1.4) : "#80FFFFFF")
                    border.width: index === root.currentStep ? 3 : 0
                    border.color: "white"

                    Text {
                        anchors.centerIn: parent
                        text: root.stepStars[index] > 0 ? "★" : (index + 1)
                        color: index === root.currentStep ? "white" : "#333333"
                        font.pixelSize: 14
                        font.bold: true
                    }

                    scale: index === root.currentStep ? 1.2 : 1.0
                    Behavior on scale { NumberAnimation { duration: NeoConstants.animFast } }
                }
            }
        }

        // Help button
        TouchButton {
            Layout.preferredWidth: 48
            Layout.preferredHeight: 48
            text: "?"
            fontSize: 22
            buttonColor: NeoConstants.warmOrange
            textColor: "white"
            onClicked: root.helpClicked()
        }
    }
}
