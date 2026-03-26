import QtQuick
import "../core"
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

    signal backClicked()

    Rectangle {
        anchors.fill: parent
        color: NeoConstants.ricePaper
    }

    // Top bar
    Rectangle {
        id: topBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 56
        color: NeoConstants.oceanBlue

        Row {
            anchors.fill: parent
            anchors.leftMargin: 12
            spacing: 12

            TouchButton {
                width: 48; height: 48
                text: "◄"
                fontSize: 20
                buttonColor: "transparent"
                textColor: "white"
                anchors.verticalCenter: parent.verticalCenter
                onClicked: root.backClicked()
            }

            Text {
                text: qsTr("Hồ sơ Nhà khoa học")
                font.pixelSize: NeoConstants.fontBody
                font.bold: true
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Flickable {
        anchors.top: topBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 16
        contentHeight: contentColumn.height
        clip: true

        Column {
            id: contentColumn
            width: parent.width
            spacing: 20

            // Avatar and stars
            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 12

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 100
                    height: 100
                    radius: 50
                    color: NeoConstants.oceanBlue

                    Text {
                        anchors.centerIn: parent
                        text: "🤖"
                        font.pixelSize: 56
                    }
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Nhà khoa học Neo")
                    font.pixelSize: NeoConstants.fontTitle
                    font.bold: true
                    color: NeoConstants.forestGreen
                }

                // Total stars
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 8

                    Text {
                        text: "★"
                        font.pixelSize: 32
                        color: NeoConstants.sunshine
                    }

                    Text {
                        text: ProgressTracker.getTotalStars() + " / " + NeoConstants.maxStarsTotal
                        font.pixelSize: NeoConstants.fontTitle
                        font.bold: true
                        color: "#333333"
                    }
                }

                // Progress bar
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 300
                    height: 12
                    radius: 6
                    color: "#E0E0E0"

                    Rectangle {
                        width: parent.width * (ProgressTracker.getTotalStars() / NeoConstants.maxStarsTotal)
                        height: parent.height
                        radius: 6
                        color: NeoConstants.sunshine

                        Behavior on width { NumberAnimation { duration: NeoConstants.animNormal } }
                    }
                }
            }

            // Question progress
            Text {
                text: qsTr("Tiến độ câu hỏi")
                font.pixelSize: NeoConstants.fontBody
                font.bold: true
                color: NeoConstants.forestGreen
            }

            Grid {
                columns: Math.min(3, Math.floor(parent.width / 180))
                spacing: 12
                anchors.horizontalCenter: parent.horizontalCenter

                Repeater {
                    model: NeoConstants.questions

                    Rectangle {
                        width: 160
                        height: 100
                        radius: 12
                        color: NeoConstants.cardBg
                        border.width: 1
                        border.color: "#E0E0E0"

                        Column {
                            anchors.centerIn: parent
                            spacing: 4

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: modelData.icon + " Q" + modelData.id
                                font.pixelSize: NeoConstants.fontBody
                                font.bold: true
                                color: "#333333"
                            }

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: modelData.title
                                font.pixelSize: NeoConstants.fontCaption
                                color: "#666666"
                            }

                            Row {
                                anchors.horizontalCenter: parent.horizontalCenter
                                spacing: 4
                                Text {
                                    text: "★ " + ProgressTracker.getQuestionStars(modelData.id) + "/15"
                                    font.pixelSize: 13
                                    font.bold: true
                                    color: NeoConstants.warmOrange
                                }
                            }

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: ProgressTracker.isQuestionComplete(modelData.id)
                                      ? qsTr("✓ Hoàn thành") : qsTr("Đang học...")
                                font.pixelSize: 11
                                color: ProgressTracker.isQuestionComplete(modelData.id)
                                       ? NeoConstants.successGreen : "#999999"
                            }
                        }
                    }
                }
            }

            // Badges section
            Text {
                text: qsTr("Huy hiệu (") + BadgeSystem.getUnlockedCount() + "/15)"
                font.pixelSize: NeoConstants.fontBody
                font.bold: true
                color: NeoConstants.forestGreen
            }

            Flow {
                width: parent.width
                spacing: 12

                Repeater {
                    model: NeoConstants.badgeIds

                    Rectangle {
                        width: 80
                        height: 90
                        radius: 12
                        color: BadgeSystem.isBadgeUnlocked(modelData) ? NeoConstants.cardBg : "#F5F5F5"
                        border.width: 1
                        border.color: BadgeSystem.isBadgeUnlocked(modelData) ? NeoConstants.sunshine : "#E0E0E0"
                        opacity: BadgeSystem.isBadgeUnlocked(modelData) ? 1.0 : 0.5

                        Column {
                            anchors.centerIn: parent
                            spacing: 4

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: BadgeSystem.isBadgeUnlocked(modelData) ? BadgeSystem.getBadgeIcon(modelData) : "🔒"
                                font.pixelSize: 28
                            }

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: NeoConstants.badgeNames[modelData] || modelData
                                font.pixelSize: 10
                                color: "#333333"
                                width: 72
                                horizontalAlignment: Text.AlignHCenter
                                wrapMode: Text.WordWrap
                                maximumLineCount: 2
                            }
                        }
                    }
                }
            }
        }
    }
}
