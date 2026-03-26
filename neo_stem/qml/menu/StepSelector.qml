import QtQuick
import "../core"
import QtQuick.Controls

Item {
    id: root

    property int questionId: 1
    property var questionData: NeoConstants.questions[questionId - 1] || {}

    signal stepSelected(int questionId, int stepId)
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
        color: NeoConstants.stepColors[questionId - 1] || NeoConstants.forestGreen

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
                text: "Q" + root.questionId + ": " + (root.questionData.title || "")
                font.pixelSize: NeoConstants.fontBody
                font.bold: true
                color: "white"
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    // Driving question
    Rectangle {
        id: dqBox
        anchors.top: topBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 16
        height: dqText.implicitHeight + 24
        radius: 12
        color: NeoConstants.oceanBlue

        Text {
            id: dqText
            anchors.centerIn: parent
            width: parent.width - 24
            text: root.questionData.question || ""
            font.pixelSize: NeoConstants.fontBody
            font.bold: true
            color: "white"
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
        }
    }

    // Step path
    Item {
        anchors.top: dqBox.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 16

        // Winding path
        Canvas {
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d")
                ctx.clearRect(0, 0, width, height)
                ctx.strokeStyle = "#BDBDBD"
                ctx.lineWidth = 4

                var stepW = width / 5
                ctx.beginPath()
                for (var i = 0; i < 5; i++) {
                    var x = stepW * i + stepW / 2
                    var y = height / 2 + (i % 2 === 0 ? -30 : 30)
                    if (i === 0) ctx.moveTo(x, y)
                    else ctx.lineTo(x, y)
                }
                ctx.stroke()
            }
        }

        // Step nodes
        Repeater {
            model: 5

            Item {
                id: stepNode
                x: (parent.width / 5) * index + (parent.width / 5 - 120) / 2
                y: parent.height / 2 + (index % 2 === 0 ? -80 : -20) - 50
                width: 120
                height: 140

                property var stepProgress: ProgressTracker.getStepProgress(root.questionId, index)
                property int stepStars: stepProgress ? stepProgress.stars : 0
                property bool stepCompleted: stepProgress ? stepProgress.completed : false
                property bool unlocked: index === 0 || (ProgressTracker.getStepProgress(root.questionId, index - 1) !== null)

                Column {
                    anchors.centerIn: parent
                    spacing: 6

                    // Step circle
                    Rectangle {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 72
                        height: 72
                        radius: 36
                        color: stepNode.stepCompleted ? NeoConstants.stepColors[index]
                             : stepNode.unlocked ? Qt.lighter(NeoConstants.stepColors[index], 1.4)
                             : "#E0E0E0"
                        border.width: 3
                        border.color: stepNode.stepCompleted ? Qt.darker(NeoConstants.stepColors[index], 1.2) : "#BDBDBD"

                        Text {
                            anchors.centerIn: parent
                            text: stepNode.unlocked ? (index + 1) : "🔒"
                            font.pixelSize: stepNode.unlocked ? 28 : 24
                            font.bold: true
                            color: stepNode.unlocked ? "white" : "#999999"
                        }

                        MouseArea {
                            anchors.fill: parent
                            enabled: stepNode.unlocked
                            onClicked: root.stepSelected(root.questionId, index)
                            onPressed: parent.scale = 0.9
                            onReleased: parent.scale = 1.0
                            onCanceled: parent.scale = 1.0
                        }

                        Behavior on scale { NumberAnimation { duration: 100 } }
                    }

                    // Step name
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: NeoConstants.stepNames[index]
                        font.pixelSize: 12
                        font.bold: true
                        color: stepNode.unlocked ? "#333333" : "#999999"
                        width: 120
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap
                    }

                    // Stars
                    NeoScore {
                        anchors.horizontalCenter: parent.horizontalCenter
                        stars: stepNode.stepStars
                        starSize: 16
                        visible: stepNode.stepCompleted
                    }
                }
            }
        }
    }

    // Start all button
    TouchButton {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 24
        text: qsTr("▶ Bắt đầu từ đầu")
        buttonColor: NeoConstants.forestGreen
        textColor: "white"
        onClicked: root.stepSelected(root.questionId, 0)
    }
}
