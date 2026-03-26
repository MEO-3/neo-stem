import QtQuick
import QtQuick.Controls

Item {
    id: root
    anchors.fill: parent

    property int questionId: 0
    property int stepIndex: 4
    property string title: qsTr("Thách thức")
    property string scenario: ""
    property string challengeQuestion: ""
    property var choices: []       // [{text: "...", correct: false, explanation: "..."}, ...]
    property string extendedInfo: ""

    // State
    property int selectedChoice: -1
    property bool answered: false
    property bool isCorrect: false

    signal stepCompleted(int stars)

    function showHelp() {
        helpPopup.open()
    }

    Rectangle {
        anchors.fill: parent
        color: NeoConstants.ricePaper
        radius: 12
    }

    Flickable {
        anchors.fill: parent
        anchors.margins: 12
        contentHeight: contentCol.height
        clip: true

        Column {
            id: contentCol
            width: parent.width
            spacing: 10

            // Title
            Rectangle {
                width: parent.width
                height: 44
                radius: 8
                color: NeoConstants.stepPurple

                Text {
                    anchors.centerIn: parent
                    text: root.title
                    font.pixelSize: NeoConstants.fontBody
                    font.bold: true
                    color: "white"
                }
            }

            // Scenario
            Rectangle {
                width: parent.width
                height: scenarioText.implicitHeight + 24
                radius: 12
                color: Qt.lighter(NeoConstants.stepPurple, 1.8)

                Text {
                    id: scenarioText
                    anchors.centerIn: parent
                    width: parent.width - 24
                    text: root.scenario
                    font.pixelSize: NeoConstants.fontCaption
                    color: "#333333"
                    wrapMode: Text.WordWrap
                }
            }

            // Challenge question
            Text {
                width: parent.width
                text: root.challengeQuestion
                font.pixelSize: NeoConstants.fontBody
                font.bold: true
                color: NeoConstants.stepPurple
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
            }

            // Choices
            Column {
                width: parent.width
                spacing: 8

                Repeater {
                    model: root.choices

                    Rectangle {
                        width: parent.width
                        height: choiceCol.height + 24
                        radius: 12
                        color: {
                            if (!root.answered) {
                                return index === root.selectedChoice
                                       ? Qt.lighter(NeoConstants.oceanBlue, 1.7)
                                       : NeoConstants.cardBg
                            }
                            if (modelData.correct) return Qt.lighter(NeoConstants.successGreen, 1.6)
                            if (index === root.selectedChoice && !modelData.correct)
                                return Qt.lighter(NeoConstants.errorRed, 1.7)
                            return NeoConstants.cardBg
                        }
                        border.width: index === root.selectedChoice ? 3 : 1
                        border.color: {
                            if (!root.answered) {
                                return index === root.selectedChoice
                                       ? NeoConstants.oceanBlue : "#E0E0E0"
                            }
                            if (modelData.correct) return NeoConstants.successGreen
                            if (index === root.selectedChoice) return NeoConstants.errorRed
                            return "#E0E0E0"
                        }

                        Column {
                            id: choiceCol
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.margins: 12
                            spacing: 4

                            Text {
                                width: parent.width
                                text: String.fromCharCode(65 + index) + ". " + modelData.text
                                font.pixelSize: NeoConstants.fontCaption
                                color: "#333333"
                                wrapMode: Text.WordWrap
                            }

                            // Explanation (shown after answering)
                            Text {
                                width: parent.width
                                text: modelData.explanation || ""
                                font.pixelSize: 12
                                color: "#666666"
                                wrapMode: Text.WordWrap
                                visible: root.answered && (modelData.correct || index === root.selectedChoice)
                                font.italic: true
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            enabled: !root.answered
                            onClicked: root.selectedChoice = index
                        }

                        Behavior on color { ColorAnimation { duration: NeoConstants.animFast } }
                        Behavior on border.color { ColorAnimation { duration: NeoConstants.animFast } }
                    }
                }
            }

            // Submit button
            TouchButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: root.answered ? qsTr("Tiếp tục →") : qsTr("Kiểm tra")
                buttonColor: root.selectedChoice >= 0
                             ? NeoConstants.forestGreen : "#AAAAAA"
                textColor: "white"
                enabled: root.selectedChoice >= 0

                onClicked: {
                    if (!root.answered) {
                        root.answered = true
                        root.isCorrect = root.choices[root.selectedChoice].correct
                    } else {
                        var stars = root.isCorrect ? 3 : 1
                        root.stepCompleted(stars)
                    }
                }
            }

            // Extended info (shown after answering correctly)
            Rectangle {
                visible: root.answered && root.extendedInfo !== ""
                width: parent.width
                height: extInfoCol.height + 24
                radius: 12
                color: Qt.lighter(NeoConstants.hintBlue, 1.7)
                border.width: 1
                border.color: NeoConstants.hintBlue

                Column {
                    id: extInfoCol
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: 12
                    spacing: 8

                    Text {
                        width: parent.width
                        text: qsTr("🌟 Mở rộng kiến thức")
                        font.pixelSize: NeoConstants.fontCaption
                        font.bold: true
                        color: NeoConstants.oceanBlue
                    }

                    Text {
                        width: parent.width
                        text: root.extendedInfo
                        font.pixelSize: NeoConstants.fontCaption
                        color: "#333333"
                        wrapMode: Text.WordWrap
                    }
                }
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
                text: qsTr("💡 Gợi ý")
                font.pixelSize: NeoConstants.fontBody
                font.bold: true
                color: NeoConstants.stepPurple
            }
            Text {
                width: parent.width - 32
                text: qsTr("Đọc kỹ tình huống và suy nghĩ dựa trên những gì bạn đã học từ các bước trước. Hãy áp dụng kiến thức vào tình huống mới!")
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
