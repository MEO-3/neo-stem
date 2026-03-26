import QtQuick
import QtQuick.Controls

Item {
    id: root

    // Activity identity
    property int questionId: 0
    property string questionTitle: ""
    property string drivingQuestion: ""

    // 5-step state machine
    property int currentStep: 0  // 0-4
    property int totalSteps: 5
    property var stepComponents: []  // URLs of step QML files
    property var stepStars: [0, 0, 0, 0, 0]

    // Navigation signals
    signal backToMenu()
    signal stepCompleted(int step, int stars)

    // State
    property bool isActive: true
    property Loader _stepLoader: stepLoader

    anchors.fill: parent

    Rectangle {
        anchors.fill: parent
        color: NeoConstants.ricePaper
    }

    // Top navigation bar
    NeoBar {
        id: neoBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        questionTitle: root.questionTitle
        currentStep: root.currentStep
        totalSteps: root.totalSteps
        stepStars: root.stepStars

        onHomeClicked: root.backToMenu()
        onBackClicked: {
            if (root.currentStep > 0) {
                root.goToStep(root.currentStep - 1)
            } else {
                root.backToMenu()
            }
        }
        onHelpClicked: {
            if (stepLoader.item && stepLoader.item.showHelp)
                stepLoader.item.showHelp()
        }
    }

    // Step content area
    Loader {
        id: stepLoader
        anchors.top: neoBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 8

        onLoaded: {
            if (item) {
                item.questionId = root.questionId
                item.stepIndex = root.currentStep
                if (item.stepCompleted)
                    item.stepCompleted.connect(root.onStepDone)
            }
        }
    }

    function goToStep(step) {
        if (step >= 0 && step < totalSteps && step < stepComponents.length) {
            currentStep = step
            stepLoader.source = stepComponents[step]
        }
    }

    function onStepDone(stars) {
        stepStars[currentStep] = Math.max(stepStars[currentStep], stars)
        stepStarsChanged()
        stepCompleted(currentStep, stars)

        try {
            ProgressTracker.saveStepProgress(questionId, currentStep, stars)
        } catch (e) {
            console.warn("ProgressTracker error:", e)
        }

        try {
            BadgeSystem.checkBadges(questionId, currentStep, stars)
        } catch (e) {
            console.warn("BadgeSystem error:", e)
        }

        // Auto advance or show bonus
        if (currentStep < totalSteps - 1) {
            bonusPopup.stars = stars
            bonusPopup.open()
        } else {
            finalBonus.stars = stars
            finalBonus.isQuestionComplete = true
            finalBonus.open()
        }
    }

    NeoBonus {
        id: bonusPopup
        onDismissed: {
            root.goToStep(root.currentStep + 1)
        }
    }

    NeoBonus {
        id: finalBonus
        onDismissed: {
            root.backToMenu()
        }
    }

    function start() {
        // Load saved progress
        try {
            for (var i = 0; i < totalSteps; i++) {
                var saved = ProgressTracker.getStepProgress(questionId, i)
                if (saved) stepStars[i] = saved.stars || 0
            }
            stepStarsChanged()
        } catch (e) {
            console.warn("Failed to load progress:", e)
        }
        goToStep(0)
    }

    Component.onCompleted: {
        if (stepComponents.length > 0)
            start()
    }
}
