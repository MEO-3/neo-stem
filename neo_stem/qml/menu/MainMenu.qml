import QtQuick
import "../core"
import QtQuick.Controls
import QtQuick.Layouts

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
                    width: 100
                    height: 100
                    radius: 50
                    color: NeoConstants.oceanBlue

                    Text {
                        anchors.centerIn: parent
                        text: "🤖"
                        font.pixelSize: 56
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
                        text: qsTr("Hồ sơ")
                        buttonColor: "transparent"
                        textColor: "white"
                        fontSize: NeoConstants.fontCaption
                        onClicked: stackView.push(profileComponent)
                    }

                    TouchButton {
                        text: qsTr("Cài đặt")
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
                font.pixelSize: 11
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

    // Activity directory mapping — loaded dynamically by file URL
    readonly property var activityFiles: ({
        1:  "q1_rice_cooker/Q1RiceCooker.qml",
        2:  "q2_dalat_fog/Q2DalatFog.qml",
        3:  "q3_mangrove/Q3Mangrove.qml",
        4:  "q4_ice_glass/Q4IceGlass.qml",
        5:  "q5_sea_salt/Q5SeaSalt.qml",
        6:  "q6_rainbow/Q6Rainbow.qml",
        7:  "q7_moon_phases/Q7MoonPhases.qml",
        8:  "q8_drum_sound/Q8DrumSound.qml",
        9:  "q9_electric_fan/Q9ElectricFan.qml",
        10: "q10_magnet/Q10Magnet.qml",
        11: "q11_bicycle/Q11Bicycle.qml",
        12: "q12_leaf_color/Q12LeafColor.qml",
        13: "q13_light_bulb/Q13LightBulb.qml",
        14: "q14_rust/Q14Rust.qml",
        15: "q15_fish_gills/Q15FishGills.qml",
        16: "q16_soda_fizz/Q16SodaFizz.qml",
        17: "q17_ice_cream/Q17IceCream.qml",
        18: "q18_helium_balloon/Q18HeliumBalloon.qml",
        19: "q19_firefly/Q19Firefly.qml",
        20: "q20_water_xylophone/Q20WaterXylophone.qml"
    })

    // Wrapper component that loads an activity QML file and wires backToMenu
    Component {
        id: activityLoaderComponent
        Loader {
            property string activitySource: ""
            anchors.fill: parent
            source: activitySource
            onLoaded: {
                if (item && item.backToMenu)
                    item.backToMenu.connect(function() { stackView.pop() })
            }
        }
    }

    function loadActivity(questionId, startStep) {
        var file = activityFiles[questionId]
        if (file) {
            var url = Qt.resolvedUrl("../activities/" + file)
            stackView.push(activityLoaderComponent, { activitySource: url })
        }
    }
}
