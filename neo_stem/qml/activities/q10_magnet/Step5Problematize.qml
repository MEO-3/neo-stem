import QtQuick
import "../../core"

ProblematizeChallenge {
    title: qsTr("Thách thức: La bàn và Trái Đất")

    scenario: qsTr("Bạn Mai đi cắm trại ở rừng và mang theo la bàn. Kim la bàn luôn chỉ về hướng Bắc, " +
                   "dù Mai xoay la bàn theo hướng nào. Mai thắc mắc: tại sao kim la bàn luôn biết đâu là hướng Bắc? " +
                   "Không ai dạy kim la bàn cả!")

    challengeQuestion: qsTr("Tại sao kim la bàn luôn chỉ hướng Bắc?")

    choices: [
        {
            text: qsTr("Vì Trái Đất là một nam châm khổng lồ — lõi sắt nóng chảy tạo từ trường, kim la bàn sắp xếp theo"),
            correct: true,
            explanation: qsTr("Đúng! Lõi Trái Đất chứa sắt và niken nóng chảy, chuyển động tạo ra từ trường bao quanh hành tinh. Kim la bàn (nam châm nhỏ) tự sắp xếp theo từ trường Trái Đất, luôn chỉ về cực từ Bắc.")
        },
        {
            text: qsTr("Vì ngôi sao Bắc Cực phát ra từ trường hút kim la bàn"),
            correct: false,
            explanation: qsTr("Sao Bắc Cực quá xa (430 năm ánh sáng) để ảnh hưởng từ trường. La bàn hoạt động nhờ từ trường Trái Đất, không phải ngôi sao nào.")
        },
        {
            text: qsTr("Vì kim la bàn được lập trình chỉ Bắc từ khi sản xuất"),
            correct: false,
            explanation: qsTr("Kim la bàn không được 'lập trình'. Nó đơn giản là một nam châm nhỏ tự do xoay, tự nhiên sắp xếp theo từ trường Trái Đất.")
        },
        {
            text: qsTr("Vì gió luôn thổi từ Bắc xuống Nam đẩy kim la bàn"),
            correct: false,
            explanation: qsTr("Gió không ảnh hưởng kim la bàn (kim được bảo vệ trong hộp). La bàn hoạt động nhờ từ trường, không phải gió hay lực cơ học.")
        }
    ]

    extendedInfo: qsTr("🧭 Mở rộng: Cực từ Bắc của Trái Đất thực ra không trùng với cực địa lý Bắc — " +
                       "chênh nhau khoảng 11°. Và cực từ luôn DI CHUYỂN!\n\n" +
                       "Thú vị: Một số động vật (chim di cư, rùa biển, ong) cũng có 'la bàn sinh học' — " +
                       "tinh thể magnetite trong cơ thể giúp chúng cảm nhận từ trường Trái Đất để định hướng.\n\n" +
                       "Cách đây 780.000 năm, cực từ Trái Đất đã ĐẢO NGƯỢC — Bắc thành Nam!")
}
