import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import NEO_STEM

ApplicationWindow {
    id: window
    visible: true
    width: 1024
    height: 768
    minimumWidth: 800
    minimumHeight: 600
    title: "NEO STEM"
    color: NeoConstants.ricePaper

    property string currentView: "splash"

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: splashComponent
    }

    // Splash Screen
    Component {
        id: splashComponent
        Rectangle {
            color: NeoConstants.forestGreen

            Column {
                anchors.centerIn: parent
                spacing: 24

                // Logo / Title
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "NEO"
                    font.pixelSize: 72
                    font.bold: true
                    color: NeoConstants.sunshine
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "STEM"
                    font.pixelSize: 48
                    font.bold: true
                    color: "white"
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Khám phá Khoa học cùng Neo!")
                    font.pixelSize: NeoConstants.fontBody
                    color: "#C8E6C9"
                }

                Item { width: 1; height: 20 }

                // NEO mascot
                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: 120
                    height: 120
                    radius: 60
                    color: NeoConstants.oceanBlue
                    border.width: 4
                    border.color: NeoConstants.sunshine

                    Text {
                        anchors.centerIn: parent
                        text: "🤖"
                        font.pixelSize: 64
                    }

                    SequentialAnimation on scale {
                        running: true
                        loops: Animation.Infinite
                        NumberAnimation { from: 1.0; to: 1.1; duration: 1000; easing.type: Easing.InOutSine }
                        NumberAnimation { from: 1.1; to: 1.0; duration: 1000; easing.type: Easing.InOutSine }
                    }
                }

                Item { width: 1; height: 20 }

                TouchButton {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Bắt đầu khám phá!")
                    buttonColor: NeoConstants.warmOrange
                    textColor: "white"
                    fontSize: NeoConstants.fontButton
                    width: 280
                    onClicked: stackView.push(questionSelectorComponent)
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 16

                    TouchButton {
                        text: qsTr("📊 Hồ sơ")
                        buttonColor: "transparent"
                        textColor: "white"
                        fontSize: NeoConstants.fontCaption
                        onClicked: stackView.push(profileComponent)
                    }

                    TouchButton {
                        text: qsTr("⚙️ Cài đặt")
                        buttonColor: "transparent"
                        textColor: "white"
                        fontSize: NeoConstants.fontCaption
                        onClicked: stackView.push(settingsComponent)
                    }
                }
            }

            // Version
            Text {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 12
                text: "NEO STEM v1.0 — Bình Dân Học STEM & Robot — Lớp 3-9"
                font.pixelSize: NeoConstants.fontSmall
                color: "#80FFFFFF"
            }
        }
    }

    // Question Selector (Vietnam Village Map)
    Component {
        id: questionSelectorComponent
        QuestionSelector {
            onQuestionSelected: (questionId) => {
                stackView.push(stepSelectorComponent, { questionId: questionId })
            }
            onBackClicked: stackView.pop()
        }
    }

    // Step Selector
    Component {
        id: stepSelectorComponent
        StepSelector {
            onStepSelected: (questionId, stepId) => {
                loadActivity(questionId, stepId)
            }
            onBackClicked: stackView.pop()
        }
    }

    // Profile
    Component {
        id: profileComponent
        ProfileScreen {
            onBackClicked: stackView.pop()
        }
    }

    // Settings
    Component {
        id: settingsComponent
        SettingsScreen {
            onBackClicked: stackView.pop()
        }
    }

    // Activity components
    Component { id: q1Component; Q1RiceCooker { onBackToMenu: stackView.pop() } }
    Component { id: q2Component; Q2DalatFog { onBackToMenu: stackView.pop() } }
    Component { id: q3Component; Q3Mangrove { onBackToMenu: stackView.pop() } }
    Component { id: q4Component; Q4IceGlass { onBackToMenu: stackView.pop() } }
    Component { id: q5Component; Q5SeaSalt { onBackToMenu: stackView.pop() } }
    Component { id: q6Component; Q6Rainbow { onBackToMenu: stackView.pop() } }
    Component { id: q7Component; Q7MoonPhases { onBackToMenu: stackView.pop() } }
    Component { id: q8Component; Q8DrumSound { onBackToMenu: stackView.pop() } }
    Component { id: q9Component; Q9ElectricFan { onBackToMenu: stackView.pop() } }
    Component { id: q10Component; Q10Magnet { onBackToMenu: stackView.pop() } }
    Component { id: q11Component; Q11Bicycle { onBackToMenu: stackView.pop() } }
    Component { id: q12Component; Q12LeafColor { onBackToMenu: stackView.pop() } }
    Component { id: q13Component; Q13LightBulb { onBackToMenu: stackView.pop() } }
    Component { id: q14Component; Q14Rust { onBackToMenu: stackView.pop() } }
    Component { id: q15Component; Q15FishGills { onBackToMenu: stackView.pop() } }
    Component { id: q16Component; Q16SodaFizz { onBackToMenu: stackView.pop() } }
    Component { id: q17Component; Q17IceCream { onBackToMenu: stackView.pop() } }
    Component { id: q18Component; Q18HeliumBalloon { onBackToMenu: stackView.pop() } }
    Component { id: q19Component; Q19Firefly { onBackToMenu: stackView.pop() } }
    Component { id: q20Component; Q20WaterXylophone { onBackToMenu: stackView.pop() } }

    function loadActivity(questionId, startStep) {
        var components = [null, q1Component, q2Component, q3Component, q4Component, q5Component,
                          q6Component, q7Component, q8Component, q9Component, q10Component,
                          q11Component, q12Component, q13Component, q14Component, q15Component,
                          q16Component, q17Component, q18Component, q19Component, q20Component]
        if (questionId >= 1 && questionId <= 20) {
            stackView.push(components[questionId])
        }
    }
}
