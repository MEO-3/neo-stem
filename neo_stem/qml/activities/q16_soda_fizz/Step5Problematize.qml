import QtQuick
import "../../core"

ProblematizeChallenge {
    title: qsTr("Thách thức: Nước ngọt ấm vs lạnh")

    scenario: qsTr("Bạn Minh mua hai chai nước ngọt giống hệt nhau. Một chai để trong tủ lạnh, " +
                   "một chai để ngoài nắng cả buổi chiều. Khi mở cùng lúc, chai để ngoài nắng " +
                   "phun bọt mạnh hơn rất nhiều, còn chai lạnh chỉ xì nhẹ. " +
                   "Minh thắc mắc: cùng một loại nước ngọt, tại sao lại khác nhau?")

    challengeQuestion: qsTr("Tại sao nước ngọt ấm phun mạnh hơn nước ngọt lạnh?")

    choices: [
        {
            text: qsTr("CO₂ tan ít hơn trong nước ấm nên thoát ra nhanh hơn khi mở nắp"),
            correct: true,
            explanation: qsTr("Đúng! Theo Định luật Henry, độ tan của khí trong chất lỏng GIẢM khi nhiệt độ TĂNG. " +
                             "Nước ấm giữ ít CO₂ hơn → khi mở nắp, lượng CO₂ dư thừa lớn hơn → thoát ra nhanh và mạnh. " +
                             "Nước lạnh giữ CO₂ tốt hơn → ít bọt hơn khi mở.")
        },
        {
            text: qsTr("Nhiệt độ cao làm chai nở ra, tạo thêm áp suất"),
            correct: false,
            explanation: qsTr("Chai nhựa/thủy tinh nở rất ít khi nóng. Áp suất tăng chủ yếu do CO₂ thoát ra khỏi nước (vì độ tan giảm), không phải do chai nở.")
        },
        {
            text: qsTr("Nước nóng tạo thêm CO₂ mới bên trong chai"),
            correct: false,
            explanation: qsTr("Nhiệt không tạo thêm CO₂. Lượng CO₂ trong chai không đổi. Nhiệt chỉ làm CO₂ khó hòa tan trong nước hơn → CO₂ chuyển từ dạng hòa tan sang dạng khí.")
        },
        {
            text: qsTr("Nước lạnh nặng hơn nên giữ bọt không cho nổi lên"),
            correct: false,
            explanation: qsTr("Nước lạnh có mật độ cao hơn một chút, nhưng đó không phải lý do chính. Nguyên nhân là độ tan: nước lạnh HÒA TAN nhiều CO₂ hơn, nên ít CO₂ ở dạng khí → ít bọt.")
        }
    ]

    extendedInfo: qsTr("Mở rộng — Định luật Henry:\n" +
                       "Độ tan của khí trong chất lỏng tỉ lệ thuận với áp suất và tỉ lệ nghịch với nhiệt độ.\n\n" +
                       "Ứng dụng thực tế — Bệnh giảm áp (The Bends):\n" +
                       "Thợ lặn biển sâu hít không khí ở áp suất cao → N₂ hòa tan nhiều trong máu. " +
                       "Nếu nổi lên quá nhanh, áp suất giảm đột ngột → N₂ tạo bọt khí trong mạch máu " +
                       "(giống mở chai nước ngọt!) → gây đau khớp, tê liệt, nguy hiểm tính mạng. " +
                       "Vì vậy thợ lặn phải nổi lên CHẬM để N₂ thoát ra từ từ qua phổi.")
}
