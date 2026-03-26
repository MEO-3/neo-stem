import QtQuick
import QtMultimedia

Item {
    id: root

    property real sfxVolume: 1.0
    property real voiceVolume: 1.0
    property bool muted: false

    MediaPlayer {
        id: sfxPlayer
        audioOutput: AudioOutput {
            volume: root.muted ? 0 : root.sfxVolume
        }
    }

    MediaPlayer {
        id: voicePlayer
        audioOutput: AudioOutput {
            volume: root.muted ? 0 : root.voiceVolume
        }
    }

    function playSfx(source) {
        sfxPlayer.source = source
        sfxPlayer.play()
    }

    function playVoice(source) {
        voicePlayer.source = source
        voicePlayer.play()
    }

    function playCorrect() {
        playSfx("qrc:/sounds/correct.wav")
    }

    function playWrong() {
        playSfx("qrc:/sounds/wrong.wav")
    }

    function playComplete() {
        playSfx("qrc:/sounds/complete.wav")
    }

    function playClick() {
        playSfx("qrc:/sounds/click.wav")
    }

    function stopAll() {
        sfxPlayer.stop()
        voicePlayer.stop()
    }
}
