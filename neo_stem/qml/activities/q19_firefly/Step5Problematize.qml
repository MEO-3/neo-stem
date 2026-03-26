import QtQuick
import "../../core"

ProblematizeChallenge {
    title: qsTr("Thách thức: Sinh vật biển sâu phát sáng")

    scenario: qsTr("Sau khi học về đom đóm, bạn Minh xem phim tài liệu về đại dương. " +
                   "Dưới đáy biển sâu, nơi ánh sáng mặt trời không thể chiếu tới, " +
                   "nhiều sinh vật vẫn phát sáng kỳ diệu: sứa biển phát sáng xanh, " +
                   "cá lồng đèn (anglerfish) có 'đèn câu cá' trên đầu, " +
                   "mực ống phát sáng đỏ để ngụy trang. Minh thắc mắc: " +
                   "tại sao sinh vật biển sâu cũng cần phát sáng như đom đóm?")

    challengeQuestion: qsTr("Sinh vật biển sâu phát sáng để làm gì?")

    choices: [
        {
            text: qsTr("Nhiều mục đích: dụ mồi (cá lồng đèn), giao tiếp (sứa biển), ngụy trang trong bóng tối (mực ống) — tùy loài mà khác nhau"),
            correct: true,
            explanation: qsTr("Đúng! Sinh vật biển sâu phát sáng vì nhiều lý do: " +
                             "1) DỤ MỒI: Cá lồng đèn dùng ánh sáng như mồi câu để dẫn dụ con mồi lại gần. " +
                             "2) GIAO TIẾP: Sứa biển và động vật phù du phát sáng để nhận ra nhau và giao tiếp. " +
                             "3) NGỤY TRANG (counter-illumination): Mực phát sáng bụng để hòa vào ánh sáng yếu từ trên, " +
                             "khiến kẻ săn không thấy bóng của chúng. " +
                             "4) TỰ VỆ: Một số loài phát sáng chói để làm choáng kẻ thù. " +
                             "Tất cả đều dùng phản ứng hóa học tương tự đom đóm!")
        },
        {
            text: qsTr("Sinh vật biển sâu phát sáng vì nước biển có chất phát quang"),
            correct: false,
            explanation: qsTr("Nước biển không có chất phát quang. Ánh sáng do chính cơ thể sinh vật tạo ra " +
                             "từ phản ứng hóa học bên trong (luciferin + luciferase hoặc protein tương tự). " +
                             "Đây là khả năng tự thân của sinh vật, không phải từ môi trường.")
        },
        {
            text: qsTr("Sinh vật biển sâu hấp thụ ánh sáng mặt trời ban ngày rồi phát ra ban đêm"),
            correct: false,
            explanation: qsTr("Sai! Ở độ sâu 200-1000m, ánh sáng mặt trời gần như không chiếu tới. " +
                             "Sinh vật biển sâu tạo ánh sáng từ phản ứng HÓA HỌC trong cơ thể (bioluminescence), " +
                             "không phải từ năng lượng mặt trời. Chúng phát sáng bất cứ lúc nào cần, không phụ thuộc ngày/đêm.")
        },
        {
            text: qsTr("Chỉ là tình cờ, ánh sáng không có tác dụng gì"),
            correct: false,
            explanation: qsTr("Phát sáng tốn năng lượng, nên tiến hóa chỉ giữ lại tính năng nào có lợi. " +
                             "Nghiên cứu cho thấy khoảng 76% sinh vật biển sâu có khả năng phát sáng — " +
                             "cho thấy đây là đặc điểm cực kỳ quan trọng cho sinh tồn, không phải tình cờ.")
        }
    ]

    extendedInfo: qsTr("Mở rộng — Phát quang sinh học dưới biển sâu:\n" +
                       "- Khoảng 76% sinh vật biển sâu (dưới 200m) có khả năng phát sáng\n" +
                       "- Protein phát sáng xanh GFP (Green Fluorescent Protein) từ sứa biển đã được dùng trong y học " +
                       "để đánh dấu tế bào — giải Nobel Hóa học 2008!\n" +
                       "- Cá lồng đèn (anglerfish) có vi khuẩn phát sáng sống cộng sinh trong 'đèn câu cá'\n" +
                       "- Mực khổng lồ phát sáng đỏ để giao tiếp và ngụy trang\n" +
                       "- Một số loài tôm biển sâu phun chất phát sáng để làm choáng kẻ thù — giống mực phun mực!\n\n" +
                       "Ứng dụng: Con người đang nghiên cứu bioluminescence để tạo cây phát sáng " +
                       "thay đèn đường, xét nghiệm y tế nhanh, và theo dõi ô nhiễm môi trường.")
}
