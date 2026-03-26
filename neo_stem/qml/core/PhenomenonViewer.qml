import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    anchors.fill: parent

    property int questionId: 0
    property int stepIndex: 0
    property string title: ""
    property string description: ""
    property var hotspots: []
    property int discoveredCount: 0

    // Scene content: set as a Component in subclass
    property Component sceneComponent: null

    signal stepCompleted(int stars)

    function showHelp() {
        helpBubble.visible = true
        helpTimer.start()
    }

    Rectangle {
        anchors.fill: parent
        color: NeoConstants.ricePaper
        radius: 12
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 12

        // Title bar
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 48
            radius: 8
            color: NeoConstants.stepCoral

            Text {
                anchors.centerIn: parent
                text: root.title || qsTr("Hiện tượng Neo")
                font.pixelSize: NeoConstants.fontBody
                font.bold: true
                color: "white"
            }
        }

        // Description
        Text {
            Layout.fillWidth: true
            text: root.description
            font.pixelSize: NeoConstants.fontCaption
            color: "#555555"
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
        }

        // Interactive content area
        Item {
            id: contentArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            // Scene loaded from sceneComponent
            Loader {
                id: sceneLoader
                anchors.fill: parent
                sourceComponent: root.sceneComponent
                z: 0
            }

            // Hotspot markers overlay
            Item {
                anchors.fill: parent
                z: 10

                Repeater {
                    model: root.hotspots

                    Item {
                        x: modelData.x * contentArea.width - 20
                        y: modelData.y * contentArea.height - 20
                        width: 40
                        height: 40

                        property bool discovered: false

                        Rectangle {
                            anchors.centerIn: parent
                            width: 40
                            height: 40
                            radius: 20
                            color: "transparent"
                            border.width: 3
                            border.color: discovered ? NeoConstants.successGreen : NeoConstants.warmOrange
                            opacity: discovered ? 0.6 : 1.0

                            SequentialAnimation on scale {
                                running: !discovered
                                loops: Animation.Infinite
                                NumberAnimation { from: 0.8; to: 1.2; duration: 800; easing.type: Easing.InOutSine }
                                NumberAnimation { from: 1.2; to: 0.8; duration: 800; easing.type: Easing.InOutSine }
                            }
                        }

                        Text {
                            anchors.centerIn: parent
                            text: discovered ? "✓" : "?"
                            font.pixelSize: 18
                            font.bold: true
                            color: discovered ? NeoConstants.successGreen : NeoConstants.warmOrange
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (!discovered) {
                                    discovered = true
                                    root.discoveredCount++
                                    hotspotPopup.text = modelData.label + "\n\n" + modelData.detail
                                    hotspotPopup.open()
                                }
                            }
                        }
                    }
                }
            }
        }

        // Progress and continue
        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 56

            Item { Layout.fillWidth: true }

            Text {
                text: qsTr("Khám phá: ") + root.discoveredCount + "/" + root.hotspots.length
                font.pixelSize: NeoConstants.fontCaption
                color: "#666666"
            }

            TouchButton {
                text: qsTr("Tiếp tục →")
                buttonColor: root.discoveredCount >= root.hotspots.length
                            ? NeoConstants.forestGreen : "#AAAAAA"
                textColor: "white"
                enabled: root.discoveredCount >= 1
                onClicked: {
                    var stars = root.discoveredCount >= root.hotspots.length ? 3
                             : root.discoveredCount >= 2 ? 2 : 1
                    root.stepCompleted(stars)
                }
            }

            Item { Layout.fillWidth: true }
        }
    }

    // Help bubble
    Rectangle {
        id: helpBubble
        visible: false
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 16
        width: 200; height: 80; radius: 12
        color: NeoConstants.hintBlue

        Text {
            anchors.centerIn: parent
            width: parent.width - 16
            text: qsTr("Chạm vào các dấu ? để khám phá hiện tượng nhé!")
            font.pixelSize: 13; color: "white"; wrapMode: Text.WordWrap
        }

        Timer {
            id: helpTimer
            interval: 4000
            onTriggered: helpBubble.visible = false
        }
    }

    // Hotspot detail popup
    Popup {
        id: hotspotPopup
        anchors.centerIn: parent
        width: Math.min(parent.width * 0.8, 320)
        height: 220; modal: true
        property string text: ""
        background: Rectangle { radius: 16; color: NeoConstants.cardBg }
        contentItem: Column {
            spacing: 12; padding: 16
            Text {
                width: parent.width - 32
                text: hotspotPopup.text
                font.pixelSize: NeoConstants.fontCaption
                color: "#333333"; wrapMode: Text.WordWrap
            }
            TouchButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("OK")
                buttonColor: NeoConstants.oceanBlue; textColor: "white"
                onClicked: hotspotPopup.close()
            }
        }
    }
}
