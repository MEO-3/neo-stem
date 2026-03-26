import QtQuick
import "../../core"

ProblematizeChallenge {
    title: qsTr("Thách thức: LED tiết kiệm điện")

    scenario: qsTr("Gia đình bạn Hoa thay toàn bộ 20 bóng đèn sợi đốt 60W bằng đèn LED 9W. " +
                   "Sau một tháng, tiền điện giảm đáng kể. Bố Hoa nói: 'LED sáng tương đương mà tốn ít điện hơn nhiều!' " +
                   "Hoa thắc mắc: cả hai đều dùng điện, tại sao LED lại tiết kiệm hơn?")

    challengeQuestion: qsTr("Tại sao LED tiết kiệm điện hơn đèn sợi đốt?")

    choices: [
        {
            text: qsTr("LED chuyển 90% điện năng thành ánh sáng, đèn sợi đốt chỉ 10% (90% thành nhiệt lãng phí)"),
            correct: true,
            explanation: qsTr("Đúng! Đèn sợi đốt: dây tóc nóng 2500°C → 90% điện thành NHIỆT, chỉ 10% thành ánh sáng. Đèn LED: electron kích thích phát photon trực tiếp → 90% điện thành ÁNH SÁNG, rất ít nhiệt. Cùng độ sáng, LED cần ít điện hơn vì không lãng phí năng lượng vào nhiệt!")
        },
        {
            text: qsTr("Vì LED dùng loại điện khác, ít tốn năng lượng hơn"),
            correct: false,
            explanation: qsTr("Cả hai đều dùng cùng nguồn điện từ ổ cắm (220V AC). Sự khác biệt nằm ở cách CHUYỂN HÓA năng lượng: sợi đốt lãng phí thành nhiệt, LED chuyển trực tiếp thành ánh sáng.")
        },
        {
            text: qsTr("Vì LED nhỏ hơn nên cần ít điện hơn"),
            correct: false,
            explanation: qsTr("Kích thước không quyết định hiệu suất. Vấn đề là tỷ lệ chuyển hóa: đèn sợi đốt lãng phí 90% điện thành nhiệt, trong khi LED chuyển hầu hết điện thành ánh sáng.")
        },
        {
            text: qsTr("Vì LED phát sáng yếu hơn nên tốn ít điện"),
            correct: false,
            explanation: qsTr("LED 9W cho độ sáng TƯƠNG ĐƯƠNG đèn sợi đốt 60W! LED không sáng yếu hơn — nó hiệu quả hơn vì chuyển điện thành ánh sáng trực tiếp, không qua bước đốt nóng.")
        }
    ]

    extendedInfo: qsTr("So sánh hiệu suất các loại đèn:\n\n" +
                       "Đèn sợi đốt: ~10% ánh sáng, ~90% nhiệt (tuổi thọ ~1.000 giờ)\n" +
                       "Đèn huỳnh quang (compact): ~40% ánh sáng (tuổi thọ ~8.000 giờ)\n" +
                       "Đèn LED: ~90% ánh sáng (tuổi thọ ~25.000 giờ)\n\n" +
                       "Ứng dụng: Thay 1 bóng sợi đốt 60W bằng LED 9W tiết kiệm ~51W. " +
                       "Với 20 bóng, bật 8 giờ/ngày, tiết kiệm ~245 kWh/năm!")
}
