import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    anchors.fill: parent

    property int questionId: 0
    property string drivingQuestion: ""
    property var subQuestions: []  // [{text: "...", answered: false}, ...]
    property int stepIndex: 0

    signal stepCompleted(int stars)
    signal subQuestionAnswered(int index)

    // DQB Board background
    Rectangle {
        anchors.fill: parent
        color: "#8B4513"  // Cork board color
        radius: 16

        // Cork texture pattern
        Repeater {
            model: 30
            Rectangle {
                x: Math.random() * parent.width
                y: Math.random() * parent.height
                width: 2 + Math.random() * 4
                height: 2 + Math.random() * 4
                radius: 1
                color: Qt.rgba(0.6, 0.35, 0.1, 0.3)
            }
        }
    }

    Column {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 16

        // Driving question header
        Rectangle {
            width: parent.width
            height: dqHeaderText.implicitHeight + 24
            radius: 8
            color: NeoConstants.oceanBlue

            Text {
                id: dqHeaderText
                anchors.centerIn: parent
                width: parent.width - 24
                text: root.drivingQuestion
                font.pixelSize: NeoConstants.fontBody
                font.bold: true
                color: "white"
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // Instructions
        Text {
            width: parent.width
            text: qsTr("Ghi lại những câu hỏi phụ của bạn vào bảng dưới đây:")
            font.pixelSize: NeoConstants.fontCaption
            color: "#FFE0B2"
            horizontalAlignment: Text.AlignHCenter
        }

        // Sticky notes grid
        Flow {
            id: notesFlow
            width: parent.width
            spacing: 16

            Repeater {
                model: root.subQuestions.length

                DQBItem {
                    noteIndex: index
                    noteText: root.subQuestions[index].text || ""
                    answered: root.subQuestions[index].answered || false

                    onNoteEdited: (newText) => {
                        root.subQuestions[index].text = newText
                    }

                    onNoteClicked: {
                        // Tap answered note for details
                    }
                }
            }
        }

        // Add note button
        TouchButton {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("+ Thêm câu hỏi")
            buttonColor: NeoConstants.warmOrange
            textColor: "white"
            visible: root.subQuestions.length < 8

            onClicked: {
                root.subQuestions.push({ text: "", answered: false })
                root.subQuestionsChanged()
            }
        }

        Item { width: 1; height: 10 }

        // Progress indicator
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 4

            Text {
                text: qsTr("Câu hỏi đã khám phá: ")
                font.pixelSize: NeoConstants.fontCaption
                color: "#FFE0B2"
            }

            Text {
                text: {
                    var count = 0
                    for (var i = 0; i < root.subQuestions.length; i++) {
                        if (root.subQuestions[i].text && root.subQuestions[i].text.length > 5)
                            count++
                    }
                    return count + "/" + root.subQuestions.length
                }
                font.pixelSize: NeoConstants.fontCaption
                font.bold: true
                color: NeoConstants.sunshine
            }
        }

        // Complete button
        TouchButton {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Hoàn thành bảng câu hỏi")
            buttonColor: NeoConstants.forestGreen
            textColor: "white"
            enabled: {
                var filled = 0
                for (var i = 0; i < root.subQuestions.length; i++) {
                    if (root.subQuestions[i].text && root.subQuestions[i].text.length > 5)
                        filled++
                }
                return filled >= 3
            }
            onClicked: {
                var filled = 0
                for (var i = 0; i < root.subQuestions.length; i++) {
                    if (root.subQuestions[i].text && root.subQuestions[i].text.length > 5)
                        filled++
                }
                var stars = filled >= 5 ? 3 : (filled >= 4 ? 2 : 1)
                root.stepCompleted(stars)
            }
        }
    }

    function showHelp() {
        helpPopup.open()
    }

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
                color: NeoConstants.forestGreen
            }

            Text {
                width: parent.width - 32
                text: qsTr("Hãy ghi lại những thắc mắc của bạn về hiện tượng vừa xem. Ví dụ: \"Tại sao...?\", \"Điều gì xảy ra nếu...?\", \"Làm sao mà...?\"")
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
