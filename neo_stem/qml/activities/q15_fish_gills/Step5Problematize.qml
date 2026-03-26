import QtQuick
import "../../core"

ProblematizeChallenge {
    title: qsTr("Thách thức: Cá voi và hơi thở")

    scenario: qsTr("Cá voi sống dưới biển nhưng phải ngoi lên mặt nước để thở mỗi vài phút. " +
                   "Không giống cá, cá voi không thể ở dưới nước mãi mà không lên thở. " +
                   "Cá mập thì ngược lại — nó ở dưới nước suốt đời mà không bao giờ cần lên mặt nước!")

    challengeQuestion: qsTr("Tại sao cá voi phải ngoi lên mặt nước để thở, còn cá mập thì không?")

    choices: [
        {
            text: qsTr("Vì cá voi là động vật có vú, thở bằng phổi — cần hít không khí. Cá mập có mang, lấy O₂ từ nước"),
            correct: true,
            explanation: qsTr("Đúng! Cá voi là động vật có vú (thú biển), có PHỔI giống người. Phổi chỉ lấy được oxy từ không khí, không thể lấy oxy hòa tan trong nước. Vì vậy cá voi phải ngoi lên thở. Cá mập là cá thật sự, có MANG để lấy O₂ từ nước.")
        },
        {
            text: qsTr("Vì cá voi quá to nên cần nhiều oxy hơn nước cung cấp"),
            correct: false,
            explanation: qsTr("Kích thước không phải lý do chính. Vấn đề là CƠ QUAN HÔ HẤP: cá voi có phổi (không thể lấy O₂ từ nước), còn cá mập có mang (lấy O₂ từ nước).")
        },
        {
            text: qsTr("Vì cá voi cần uống nước ngọt ở trên mặt biển"),
            correct: false,
            explanation: qsTr("Cá voi không ngoi lên để uống nước. Chúng lấy nước từ thức ăn. Chúng ngoi lên vì CẦN HÍT KHÔNG KHÍ bằng phổi qua lỗ thở trên đỉnh đầu.")
        },
        {
            text: qsTr("Vì cá voi thích tắm nắng, còn cá mập sợ ánh sáng"),
            correct: false,
            explanation: qsTr("Đây không phải lý do khoa học. Cá voi PHẢI ngoi lên vì có phổi cần không khí. Nếu không, cá voi sẽ chết đuối — giống như người bị kẹt dưới nước quá lâu.")
        }
    ]

    extendedInfo: qsTr("Mở rộng: Cá voi, cá heo, hải cẩu đều là THÚ BIỂN — có phổi, máu nóng, đẻ con và nuôi con bằng sữa.\n\n" +
                       "Cá voi nhà táng (sperm whale) có thể nín thở tới 90 phút và lặn sâu 2.000 mét!\n\n" +
                       "Cá voi có lỗ thở (blowhole) trên đỉnh đầu — khi ngoi lên, chúng phun nước và hít không khí rất nhanh.\n\n" +
                       "Cá voi xưa kia là động vật trên cạn — tổ tiên chúng sống trên đất liền cách đây 50 triệu năm, " +
                       "rồi dần dần tiến hóa quay về biển nhưng vẫn giữ phổi!")
}
