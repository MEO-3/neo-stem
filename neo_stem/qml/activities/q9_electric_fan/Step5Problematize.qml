import QtQuick
import "../../core"

ProblematizeChallenge {
    title: qsTr("Thách thức: Cúp điện vs Đèn pin")

    scenario: qsTr("Đêm hè nóng bức, bất ngờ CÚP ĐIỆN! Quạt trần dừng quay, tivi tắt, tủ lạnh im lặng. " +
                   "Nhưng bạn An lấy đèn pin ra bật — đèn pin vẫn sáng bình thường! " +
                   "An thắc mắc: tại sao quạt dừng nhưng đèn pin vẫn hoạt động?")

    challengeQuestion: qsTr("Tại sao khi cúp điện quạt dừng nhưng đèn pin vẫn sáng?")

    choices: [
        {
            text: qsTr("Vì quạt dùng điện lưới, đèn pin dùng pin — hai nguồn điện khác nhau và độc lập"),
            correct: true,
            explanation: qsTr("Đúng! Quạt nối với lưới điện quốc gia — cúp điện = mất nguồn. Đèn pin dùng pin (nguồn điện hóa học) riêng biệt, không phụ thuộc lưới điện. Cả hai đều cần nguồn điện, nhưng nguồn khác nhau!")
        },
        {
            text: qsTr("Vì đèn pin tiết kiệm điện nên vẫn còn điện"),
            correct: false,
            explanation: qsTr("Vấn đề không phải tiết kiệm điện. Đèn pin dùng nguồn năng lượng riêng (pin), hoàn toàn độc lập với lưới điện nhà.")
        },
        {
            text: qsTr("Vì đèn pin dùng ánh sáng tự nhiên, không cần điện"),
            correct: false,
            explanation: qsTr("Đèn pin cần điện từ pin để phát sáng. Nó dùng năng lượng hóa học trong pin chuyển thành điện → ánh sáng, không phải ánh sáng tự nhiên.")
        },
        {
            text: qsTr("Vì cúp điện chỉ ảnh hưởng thiết bị lớn, thiết bị nhỏ vẫn chạy"),
            correct: false,
            explanation: qsTr("Kích thước thiết bị không quan trọng. Máy tính xách tay (lớn) có pin vẫn chạy khi cúp điện. Vấn đề là NGUỒN ĐIỆN, không phải kích thước.")
        }
    ]

    extendedInfo: qsTr("⚡ Mở rộng: Có nhiều nguồn điện khác nhau:\n" +
                       "• Lưới điện: Nhà máy phát điện → đường dây → ổ cắm\n" +
                       "• Pin: Phản ứng hóa học tạo dòng điện\n" +
                       "• Pin mặt trời: Ánh sáng → điện (quang điện)\n" +
                       "• Máy phát điện: Chuyển động quay → điện\n\n" +
                       "UPS (bộ lưu điện) là thiết bị có pin dự phòng, giúp máy tính vẫn chạy vài phút khi cúp điện!")
}
