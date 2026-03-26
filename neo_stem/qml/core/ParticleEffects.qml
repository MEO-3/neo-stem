import QtQuick

Item {
    id: root

    property string effectType: "steam"  // "steam", "fog", "crystal", "condensation", "bubbles"
    property bool running: false
    property real intensity: 1.0  // 0.0 - 1.0
    property color particleColor: "white"

    // Steam particles (for Q1 rice cooker, Q5 evaporation)
    Repeater {
        model: effectType === "steam" && running ? Math.floor(20 * intensity) : 0
        Rectangle {
            id: steamParticle
            width: 6 + Math.random() * 8
            height: width
            radius: width / 2
            color: root.particleColor
            opacity: 0

            property real initX: root.width * 0.2 + Math.random() * root.width * 0.6
            property real initDelay: Math.random() * 2000
            property real riseDuration: 2000 + Math.random() * 2000

            x: initX
            y: root.height

            SequentialAnimation on y {
                running: root.running
                loops: Animation.Infinite
                PauseAnimation { duration: steamParticle.initDelay }
                NumberAnimation {
                    from: root.height
                    to: -20
                    duration: steamParticle.riseDuration
                    easing.type: Easing.OutQuad
                }
            }

            SequentialAnimation on opacity {
                running: root.running
                loops: Animation.Infinite
                PauseAnimation { duration: steamParticle.initDelay }
                NumberAnimation { from: 0; to: 0.7 * root.intensity; duration: 500 }
                NumberAnimation { from: 0.7 * root.intensity; to: 0; duration: 2500 }
            }

            NumberAnimation on x {
                running: root.running
                loops: Animation.Infinite
                from: steamParticle.initX - 15
                to: steamParticle.initX + 15
                duration: 3000
                easing.type: Easing.InOutSine
            }
        }
    }

    // Fog effect (for Q2 Dalat)
    Repeater {
        model: effectType === "fog" && running ? Math.floor(8 * intensity) : 0
        Rectangle {
            id: fogParticle
            property real fogWidth: 80 + Math.random() * 160
            property real fogHeight: 30 + Math.random() * 40
            property real driftDuration: 8000 + Math.random() * 12000
            property real fadeDuration: 4000 + Math.random() * 3000

            width: fogWidth
            height: fogHeight
            radius: fogHeight / 2
            color: root.particleColor
            opacity: 0.15 * root.intensity
            x: -fogWidth + Math.random() * (root.width + fogWidth)
            y: root.height * 0.3 + Math.random() * root.height * 0.4

            NumberAnimation on x {
                running: root.running
                loops: Animation.Infinite
                from: -fogParticle.fogWidth - 50
                to: root.width + 50
                duration: fogParticle.driftDuration
            }

            NumberAnimation on opacity {
                running: root.running
                loops: Animation.Infinite
                from: 0.05
                to: 0.25 * root.intensity
                duration: fogParticle.fadeDuration
                easing.type: Easing.InOutSine
            }
        }
    }

    // Bubble effect (for Q1 boiling water)
    Repeater {
        model: effectType === "bubbles" && running ? Math.floor(15 * intensity) : 0
        Rectangle {
            id: bubble
            width: 4 + Math.random() * 12 * intensity
            height: width
            radius: width / 2
            color: "transparent"
            border.width: 1
            border.color: Qt.rgba(1, 1, 1, 0.6)
            opacity: 0
            x: root.width * 0.15 + Math.random() * root.width * 0.7
            y: root.height

            SequentialAnimation on y {
                running: root.running
                loops: Animation.Infinite
                PauseAnimation { duration: Math.random() * 1500 }
                NumberAnimation {
                    from: root.height
                    to: root.height * 0.1
                    duration: 1000 + Math.random() * 2000
                    easing.type: Easing.OutQuad
                }
            }

            SequentialAnimation on opacity {
                running: root.running
                loops: Animation.Infinite
                PauseAnimation { duration: Math.random() * 1500 }
                NumberAnimation { from: 0; to: 0.8; duration: 300 }
                NumberAnimation { from: 0.8; to: 0; duration: 1200 }
            }
        }
    }

    // Condensation droplets (for Q4 ice glass)
    Repeater {
        model: effectType === "condensation" && running ? Math.floor(12 * intensity) : 0
        Rectangle {
            id: droplet
            width: 3 + Math.random() * 5
            height: width * 1.3
            radius: width / 2
            color: Qt.rgba(0.7, 0.85, 1.0, 0.7)
            opacity: 0

            property real startX: root.width * 0.1 + Math.random() * root.width * 0.8
            property real startY: root.height * 0.1 + Math.random() * root.height * 0.5
            property real fallDist: 20 + Math.random() * 30
            x: startX
            y: startY

            SequentialAnimation {
                running: root.running
                loops: Animation.Infinite
                PropertyAction { target: droplet; property: "y"; value: droplet.startY }
                PropertyAction { target: droplet; property: "opacity"; value: 0 }
                PauseAnimation { duration: Math.random() * 3000 }
                NumberAnimation { target: droplet; property: "opacity"; from: 0; to: 0.8; duration: 1000 }
                PauseAnimation { duration: 1000 + Math.random() * 2000 }
                ParallelAnimation {
                    NumberAnimation { target: droplet; property: "y"; from: droplet.startY; to: droplet.startY + droplet.fallDist; duration: 2000; easing.type: Easing.InQuad }
                    NumberAnimation { target: droplet; property: "opacity"; to: 0; duration: 2000 }
                }
            }
        }
    }

    // Crystal growth (for Q5 salt)
    Repeater {
        model: effectType === "crystal" && running ? Math.floor(10 * intensity) : 0
        Rectangle {
            id: crystal
            width: 4
            height: 4
            rotation: 45
            color: "white"
            border.width: 1
            border.color: "#E0E0E0"
            opacity: 0
            x: root.width * 0.1 + Math.random() * root.width * 0.8
            y: root.height * 0.6 + Math.random() * root.height * 0.3

            SequentialAnimation {
                running: root.running
                loops: Animation.Infinite
                PauseAnimation { duration: Math.random() * 5000 }
                ParallelAnimation {
                    NumberAnimation { target: crystal; property: "opacity"; from: 0; to: 1; duration: 1500 }
                    NumberAnimation { target: crystal; property: "width"; from: 2; to: 6 + Math.random() * 6; duration: 3000 }
                    NumberAnimation { target: crystal; property: "height"; from: 2; to: 6 + Math.random() * 6; duration: 3000 }
                }
                PauseAnimation { duration: 2000 }
            }
        }
    }
}
