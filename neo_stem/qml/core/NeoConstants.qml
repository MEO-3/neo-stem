pragma Singleton
import QtQuick

QtObject {
    // Colors - Primary
    readonly property color forestGreen: "#2E7D32"
    readonly property color oceanBlue: "#1565C0"

    // Colors - Accent
    readonly property color warmOrange: "#FF8F00"
    readonly property color sunshine: "#FFD600"

    // Colors - Background
    readonly property color ricePaper: "#FFF8E1"
    readonly property color cardBg: "#FFFFFF"

    // Colors - 5 Step Colors
    readonly property color stepCoral: "#FF7043"
    readonly property color stepAmber: "#FFB300"
    readonly property color stepTeal: "#26A69A"
    readonly property color stepIndigo: "#5C6BC0"
    readonly property color stepPurple: "#AB47BC"

    // Colors - Feedback
    readonly property color successGreen: "#43A047"
    readonly property color errorRed: "#E53935"
    readonly property color hintBlue: "#29B6F6"

    // Step colors array
    readonly property var stepColors: [stepCoral, stepAmber, stepTeal, stepIndigo, stepPurple]

    // Step names
    readonly property var stepNames: [
        qsTr("Hiện tượng Neo"),
        qsTr("Bảng câu hỏi"),
        qsTr("Thí nghiệm"),
        qsTr("Xây dựng mô hình"),
        qsTr("Thách thức")
    ]

    // Difficulty levels
    readonly property string levelBasic: "basic"       // Lớp 3-5 (Tiểu học)
    readonly property string levelIntermediate: "intermediate" // Lớp 5-6 (Tiểu học cao - THCS đầu)
    readonly property string levelAdvanced: "advanced"  // Lớp 6-9 (THCS)

    readonly property var levelLabels: ({
        "basic": qsTr("Cơ bản"),
        "intermediate": qsTr("Nâng cao"),
        "advanced": qsTr("THCS")
    })

    readonly property var levelColors: ({
        "basic": "#4CAF50",
        "intermediate": "#FF9800",
        "advanced": "#E91E63"
    })

    // Question data
    readonly property var questions: [
        {
            id: 1,
            title: qsTr("Nồi cơm điện"),
            question: qsTr("Tại sao nắp nồi cơm điện rung và có hơi nước?"),
            topic: qsTr("Chuyển thể, bay hơi"),
            icon: "🍚",
            level: levelBasic, gradeRange: "4-5",
            mapX: 0.5, mapY: 0.6
        },
        {
            id: 2,
            title: qsTr("Sương mù Đà Lạt"),
            question: qsTr("Tại sao Đà Lạt sáng sớm có sương mù, trưa tan hết?"),
            topic: qsTr("Chu trình nước, ngưng tụ"),
            icon: "🌫",
            level: levelBasic, gradeRange: "4-5",
            mapX: 0.6, mapY: 0.45
        },
        {
            id: 3,
            title: qsTr("Rừng ngập mặn"),
            question: qsTr("Tại sao cây bần/đước sống được trong nước mặn?"),
            topic: qsTr("Tế bào, thẩm thấu"),
            icon: "🌳",
            level: levelAdvanced, gradeRange: "8-9",
            mapX: 0.55, mapY: 0.7
        },
        {
            id: 4,
            title: qsTr("Giọt nước trên ly đá"),
            question: qsTr("Tại sao bên ngoài ly đá có giọt nước bám?"),
            topic: qsTr("Ngưng tụ, điểm sương"),
            icon: "🧊",
            level: levelBasic, gradeRange: "3-4",
            mapX: 0.4, mapY: 0.55
        },
        {
            id: 5,
            title: qsTr("Muối biển"),
            question: qsTr("Tại sao muối biển lấy được bằng cách phơi nắng?"),
            topic: qsTr("Bay hơi, tách hỗn hợp"),
            icon: "🧂",
            level: levelBasic, gradeRange: "4-5",
            mapX: 0.65, mapY: 0.58
        },
        {
            id: 6,
            title: qsTr("Cầu vồng"),
            question: qsTr("Tại sao cầu vồng xuất hiện sau cơn mưa?"),
            topic: qsTr("Khúc xạ ánh sáng, quang phổ"),
            icon: "🌈",
            level: levelAdvanced, gradeRange: "6-7",
            mapX: 0.35, mapY: 0.4
        },
        {
            id: 7,
            title: qsTr("Pha mặt trăng"),
            question: qsTr("Tại sao mặt trăng thay đổi hình dạng mỗi đêm?"),
            topic: qsTr("Pha mặt trăng, phản xạ"),
            icon: "🌙",
            level: levelBasic, gradeRange: "4-5",
            mapX: 0.7, mapY: 0.35
        },
        {
            id: 8,
            title: qsTr("Tiếng trống"),
            question: qsTr("Tại sao đập trống phát ra tiếng vang?"),
            topic: qsTr("Sóng âm, rung động"),
            icon: "🥁",
            level: levelBasic, gradeRange: "4-5",
            mapX: 0.45, mapY: 0.75
        },
        {
            id: 9,
            title: qsTr("Quạt điện"),
            question: qsTr("Tại sao quạt điện quay khi cắm điện?"),
            topic: qsTr("Mạch điện, chuyển hóa năng lượng"),
            icon: "🔌",
            level: levelBasic, gradeRange: "4-5",
            mapX: 0.3, mapY: 0.55
        },
        {
            id: 10,
            title: qsTr("Nam châm"),
            question: qsTr("Tại sao nam châm hút đinh sắt nhưng không hút nhôm?"),
            topic: qsTr("Từ tính, vật liệu sắt từ"),
            icon: "🧲",
            level: levelIntermediate, gradeRange: "5-6",
            mapX: 0.75, mapY: 0.5
        },
        {
            id: 11,
            title: qsTr("Xe đạp xuống dốc"),
            question: qsTr("Tại sao xe đạp đi nhanh hơn khi xuống dốc?"),
            topic: qsTr("Trọng lực, thế năng/động năng"),
            icon: "🚲",
            level: levelAdvanced, gradeRange: "7",
            mapX: 0.2, mapY: 0.65
        },
        {
            id: 12,
            title: qsTr("Lá cây xanh"),
            question: qsTr("Tại sao lá cây xanh nhưng hoa có nhiều màu?"),
            topic: qsTr("Quang hợp, sắc tố"),
            icon: "🌿",
            level: levelIntermediate, gradeRange: "5-6",
            mapX: 0.6, mapY: 0.3
        },
        {
            id: 13,
            title: qsTr("Bóng đèn"),
            question: qsTr("Tại sao bóng đèn phát sáng khi bật công tắc?"),
            topic: qsTr("Mạch điện, năng lượng điện→quang"),
            icon: "💡",
            level: levelBasic, gradeRange: "4-5",
            mapX: 0.8, mapY: 0.65
        },
        {
            id: 14,
            title: qsTr("Rỉ sét"),
            question: qsTr("Tại sao sắt để ngoài mưa bị rỉ sét?"),
            topic: qsTr("Oxy hóa, biến đổi hóa học"),
            icon: "🔩",
            level: levelAdvanced, gradeRange: "7-8",
            mapX: 0.25, mapY: 0.45
        },
        {
            id: 15,
            title: qsTr("Cá thở dưới nước"),
            question: qsTr("Tại sao cá sống được dưới nước?"),
            topic: qsTr("Hô hấp, mang cá, oxy hòa tan"),
            icon: "🐟",
            level: levelBasic, gradeRange: "4-5",
            mapX: 0.5, mapY: 0.8
        },
        {
            id: 16,
            title: qsTr("Nước ngọt có ga"),
            question: qsTr("Tại sao mở chai nước ngọt có ga bọt phun ra?"),
            topic: qsTr("Độ tan khí, áp suất"),
            icon: "🥤",
            level: levelIntermediate, gradeRange: "5-6",
            mapX: 0.4, mapY: 0.35
        },
        {
            id: 17,
            title: qsTr("Kem tan chảy"),
            question: qsTr("Tại sao kem tan nhanh ngoài nắng?"),
            topic: qsTr("Nóng chảy, truyền nhiệt"),
            icon: "🍦",
            level: levelBasic, gradeRange: "3-4",
            mapX: 0.55, mapY: 0.5
        },
        {
            id: 18,
            title: qsTr("Bóng bay heli"),
            question: qsTr("Tại sao bóng bay heli bay lên trời?"),
            topic: qsTr("Mật độ, lực đẩy Archimedes"),
            icon: "🎈",
            level: levelAdvanced, gradeRange: "6-8",
            mapX: 0.7, mapY: 0.75
        },
        {
            id: 19,
            title: qsTr("Đom đóm"),
            question: qsTr("Tại sao đom đóm phát sáng trong đêm?"),
            topic: qsTr("Phát quang sinh học, hóa năng→quang"),
            icon: "✨",
            level: levelIntermediate, gradeRange: "5-6",
            mapX: 0.35, mapY: 0.7
        },
        {
            id: 20,
            title: qsTr("Chai nước xylophone"),
            question: qsTr("Tại sao gõ chai nước khác mực nghe khác nhau?"),
            topic: qsTr("Tần số âm, cột không khí"),
            icon: "🎵",
            level: levelBasic, gradeRange: "4-5",
            mapX: 0.8, mapY: 0.4
        }
    ]

    // Typography
    readonly property int fontTitle: 28
    readonly property int fontBody: 18
    readonly property int fontButton: 20
    readonly property int fontCaption: 14

    // Touch targets
    readonly property int touchMin: 48
    readonly property int dragItemSize: 64
    readonly property int buttonHeight: 56

    // Animation durations
    readonly property int animFast: 200
    readonly property int animNormal: 400
    readonly property int animSlow: 800

    // Max stars
    readonly property int maxStarsPerStep: 3
    readonly property int maxStarsPerQuestion: 15
    readonly property int maxStarsTotal: 300

    // Badge IDs
    readonly property var badgeIds: [
        "first_step", "explorer", "question_master", "young_scientist",
        "architect", "challenger",
        "master_q1", "master_q2", "master_q3", "master_q4", "master_q5",
        "master_q6", "master_q7", "master_q8", "master_q9", "master_q10",
        "master_q11", "master_q12", "master_q13", "master_q14", "master_q15",
        "master_q16", "master_q17", "master_q18", "master_q19", "master_q20",
        "perfect", "speed_demon", "self_reliant", "adventurer"
    ]

    readonly property var badgeNames: ({
        "first_step": qsTr("Bước đầu tiên"),
        "explorer": qsTr("Nhà thám hiểm"),
        "question_master": qsTr("Bậc thầy câu hỏi"),
        "young_scientist": qsTr("Nhà khoa học nhí"),
        "architect": qsTr("Kiến trúc sư"),
        "challenger": qsTr("Người thách thức"),
        "master_q1": qsTr("Bậc thầy Nồi cơm"),
        "master_q2": qsTr("Bậc thầy Sương mù"),
        "master_q3": qsTr("Bậc thầy Ngập mặn"),
        "master_q4": qsTr("Bậc thầy Ly đá"),
        "master_q5": qsTr("Bậc thầy Muối biển"),
        "master_q6": qsTr("Bậc thầy Cầu vồng"),
        "master_q7": qsTr("Bậc thầy Mặt trăng"),
        "master_q8": qsTr("Bậc thầy Tiếng trống"),
        "master_q9": qsTr("Bậc thầy Quạt điện"),
        "master_q10": qsTr("Bậc thầy Nam châm"),
        "master_q11": qsTr("Bậc thầy Xe đạp"),
        "master_q12": qsTr("Bậc thầy Lá cây"),
        "master_q13": qsTr("Bậc thầy Bóng đèn"),
        "master_q14": qsTr("Bậc thầy Rỉ sét"),
        "master_q15": qsTr("Bậc thầy Cá thở"),
        "master_q16": qsTr("Bậc thầy Nước ngọt"),
        "master_q17": qsTr("Bậc thầy Kem tan"),
        "master_q18": qsTr("Bậc thầy Bóng bay"),
        "master_q19": qsTr("Bậc thầy Đom đóm"),
        "master_q20": qsTr("Bậc thầy Chai nước"),
        "perfect": qsTr("Hoàn hảo"),
        "speed_demon": qsTr("Nhanh như gió"),
        "self_reliant": qsTr("Tự lực cánh sinh"),
        "adventurer": qsTr("Trí tuệ thám dò")
    })

    // Question groups by knowledge domain
    readonly property var questionGroups: [
        { name: qsTr("Nước & Nhiệt"), icon: "💧", color: "#1E88E5", age: "6-10", questionIds: [1,2,4,5,17] },
        { name: qsTr("Ánh sáng & Âm thanh"), icon: "🔆", color: "#FF8F00", age: "8-13", questionIds: [6,7,8,13,20] },
        { name: qsTr("Lực & Điện từ"), icon: "⚡", color: "#E53935", age: "8-15", questionIds: [9,10,11,18] },
        { name: qsTr("Sự sống & Hóa học"), icon: "🌱", color: "#43A047", age: "8-15", questionIds: [3,12,14,15,16,19] }
    ]

    function getQuestionById(id) {
        for (var i = 0; i < questions.length; i++) {
            if (questions[i].id === id) return questions[i]
        }
        return null
    }

    function stepColor(stepIndex) {
        return stepColors[Math.max(0, Math.min(stepIndex, 4))]
    }
}
