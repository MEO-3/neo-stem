import QtQuick
import "../../core"

ProblematizeChallenge {
    title: qsTr("Thách thức: Chưng cất mặt trời")

    scenario: qsTr("Trên một hòn đảo xa, không có nước ngọt. Bạn có nước biển, chai nhựa, và ánh nắng mặt trời. " +
                   "Bạn cần tạo nước ngọt uống được. " +
                   "Nhớ lại: ở Q5, nước bay hơi để lại muối. Ở Q4, hơi nước gặp lạnh ngưng tụ thành giọt nước. " +
                   "Có thể kết hợp 2 nguyên lý này không?")

    challengeQuestion: qsTr("Làm thế nào để lấy nước ngọt từ nước biển bằng chưng cất mặt trời?")

    choices: [
        {
            text: qsTr("Cho nước biển bay hơi bằng nắng, rồi hứng hơi nước ngưng tụ trên bề mặt lạnh → nước ngọt"),
            correct: true,
            explanation: qsTr("Đúng! Chưng cất mặt trời = Bay hơi (Q5) + Ngưng tụ (Q4). Nước biển bay hơi → hơi nước (sạch, không muối) → ngưng tụ trên mặt lạnh → nước ngọt chảy xuống. Muối ở lại bên dưới.")
        },
        {
            text: qsTr("Lọc nước biển qua cát sạch để tách muối"),
            correct: false,
            explanation: qsTr("Lọc qua cát chỉ tách được cặn bẩn, không tách được muối hòa tan. Muối ở mức phân tử, nhỏ hơn hạt cát rất nhiều.")
        },
        {
            text: qsTr("Để nước biển dưới nắng cho muối lắng xuống đáy rồi gạn nước"),
            correct: false,
            explanation: qsTr("Muối hòa tan hoàn toàn trong nước, không tự lắng xuống. Chỉ khi nước bay hơi gần hết, muối mới kết tinh ra.")
        }
    ]

    extendedInfo: qsTr("🔗 Kết nối Q4 + Q5:\n" +
                       "• Bay hơi (Q5): Nước biển → Nhiệt → Hơi nước (bỏ lại muối)\n" +
                       "• Ngưng tụ (Q4): Hơi nước → Gặp lạnh → Nước ngọt\n\n" +
                       "🏝 Thiết bị chưng cất mặt trời (Solar Still):\n" +
                       "1. Đào hố, đặt chai hứng ở giữa\n" +
                       "2. Phủ nylon trong suốt trên hố\n" +
                       "3. Đặt hòn đá nhỏ trên nylon ngay trên chai\n" +
                       "4. Nắng làm nước bay hơi → ngưng tụ dưới nylon → chảy xuống chai\n\n" +
                       "Đây chính là nguyên lý của nhà máy khử muối nước biển hiện đại!")
}
