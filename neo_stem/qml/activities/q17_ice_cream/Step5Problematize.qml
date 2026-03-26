import QtQuick
import "../../core"

ProblematizeChallenge {
    title: qsTr("Thách thức: Thùng xốp giữ kem")

    scenario: qsTr("Bạn Minh mua kem mang về nhà cho cả gia đình. Nếu để kem trên xe máy dưới nắng, " +
                   "kem sẽ tan chảy trong vài phút. Nhưng khi Minh bỏ kem vào THÙNG XỐP (styrofoam), " +
                   "đi xe 30 phút về nhà, kem vẫn còn cứng gần như nguyên! " +
                   "Thùng xốp không hề lạnh, vậy tại sao nó giữ được kem?")

    challengeQuestion: qsTr("Tại sao thùng xốp giữ kem lâu tan?")

    choices: [
        {
            text: qsTr("Thùng xốp là chất cách nhiệt — ngăn nhiệt từ bên ngoài truyền vào kem"),
            correct: true,
            explanation: qsTr("Đúng! Xốp styrofoam chứa hàng triệu bọt khí nhỏ. Không khí đứng yên là chất cách nhiệt rất tốt — nó ngăn nhiệt từ môi trường nóng truyền vào kem lạnh. Kem không nhận được nhiệt nên giữ được trạng thái rắn lâu hơn.")
        },
        {
            text: qsTr("Thùng xốp tạo ra hơi lạnh giữ cho kem không tan"),
            correct: false,
            explanation: qsTr("Thùng xốp không tạo ra hơi lạnh. Nó không phải tủ đông. Xốp chỉ NGĂN nhiệt truyền qua — đó là cách nhiệt, không phải làm lạnh.")
        },
        {
            text: qsTr("Thùng xốp hấp thụ hết nhiệt nên kem không bị nóng"),
            correct: false,
            explanation: qsTr("Xốp không hấp thụ nhiệt nhiều. Nguyên lý hoạt động là CÁC BỌT KHÍ trong xốp ngăn cản sự truyền nhiệt (dẫn nhiệt rất kém), không phải hấp thụ nhiệt.")
        },
        {
            text: qsTr("Thùng xốp phản xạ ánh nắng nên kem không bị nóng"),
            correct: false,
            explanation: qsTr("Dù xốp trắng có phản xạ một phần ánh sáng, đó không phải lý do chính. Ngay cả trong bóng râm, thùng xốp vẫn giữ kem tốt vì nó CÁCH NHIỆT — ngăn nhiệt dẫn và đối lưu từ không khí nóng.")
        }
    ]

    extendedInfo: qsTr("Mở rộng: Nguyên lý cách nhiệt có ở khắp nơi!\n\n" +
                       "- Bình giữ nhiệt (thermos): 2 lớp thành với chân không ở giữa — chân không không truyền nhiệt bằng dẫn nhiệt và đối lưu.\n" +
                       "- Lều tuyết igloo: Tuyết chứa nhiều bọt khí, cách nhiệt tốt — bên trong igloo ấm hơn bên ngoài dù làm từ tuyết!\n" +
                       "- Áo lông vũ: Lông vũ giữ lớp không khí dày, ngăn nhiệt cơ thể thoát ra ngoài.\n\n" +
                       "Quy tắc chung: Vật liệu có nhiều bọt khí/khoảng trống khí = cách nhiệt tốt!")
}
