import QtQuick
import "../../core"

ProblematizeChallenge {
    title: qsTr("Thách thức: Lá đổi màu mùa thu")

    scenario: qsTr("Bạn Linh đi dạo trong công viên vào mùa thu. Suốt mùa hè, cây xanh mướt tươi tốt. " +
                   "Nhưng giờ đây, lá cây chuyển từ XANH sang VÀNG, CAM, thậm chí ĐỎ rực rỡ rồi rụng xuống. " +
                   "Linh thắc mắc: nếu lá xanh vì diệp lục, thì vào mùa thu màu vàng đỏ từ đâu ra?")

    challengeQuestion: qsTr("Tại sao lá cây đổi vàng/đỏ vào mùa thu?")

    choices: [
        {
            text: qsTr("Diệp lục phân hủy, để lộ sắc tố vàng (carotenoid) và đỏ (anthocyanin) vốn bị che khuất"),
            correct: true,
            explanation: qsTr("Đúng! Lá luôn chứa nhiều sắc tố: diệp lục (xanh), carotenoid (vàng/cam), anthocyanin (đỏ/tím). Mùa hè, diệp lục rất nhiều nên che hết các màu khác. Mùa thu, ngày ngắn + lạnh → cây ngừng tạo diệp lục → diệp lục phân hủy → lộ ra carotenoid (vàng/cam). Một số cây còn tạo thêm anthocyanin → lá đỏ rực!")
        },
        {
            text: qsTr("Cây nhuộm lá bằng chất màu mới vào mùa thu"),
            correct: false,
            explanation: qsTr("Cây không 'nhuộm' lá. Sắc tố vàng (carotenoid) đã có sẵn trong lá suốt mùa hè, chỉ bị diệp lục xanh che khuất. Khi diệp lục phân hủy, các sắc tố này mới hiện ra.")
        },
        {
            text: qsTr("Lá chết nên chuyển nâu giống gỗ khô"),
            correct: false,
            explanation: qsTr("Lá đổi màu TRƯỚC khi chết. Màu vàng/đỏ là do sắc tố carotenoid và anthocyanin — không phải do lá khô. Lá nâu chỉ xuất hiện ở giai đoạn cuối khi tất cả sắc tố đã phân hủy.")
        },
        {
            text: qsTr("Thời tiết lạnh đông cứng diệp lục thành màu vàng"),
            correct: false,
            explanation: qsTr("Lạnh không 'đông cứng' diệp lục thành vàng. Thực tế, ngày ngắn hơn (ít ánh sáng) là tín hiệu chính khiến cây ngừng sản xuất diệp lục. Diệp lục phân hủy tự nhiên, để lộ carotenoid vàng/cam có sẵn.")
        }
    ]

    extendedInfo: qsTr("🍂 Mở rộng: Lá cây chứa nhiều loại sắc tố:\n" +
                       "• Diệp lục (Chlorophyll): xanh — hấp thụ ánh sáng đỏ + xanh dương\n" +
                       "• Carotenoid: vàng/cam — luôn có sẵn, bị diệp lục che\n" +
                       "• Anthocyanin: đỏ/tím — một số cây tạo thêm vào mùa thu\n\n" +
                       "Cây thường xanh (thông, tràm) giữ lá quanh năm vì lá có lớp sáp bảo vệ, " +
                       "diệp lục được thay thế liên tục nên lá luôn xanh. " +
                       "Cây rụng lá thu hồi chất dinh dưỡng từ lá trước khi rụng — đó là sự chuẩn bị cho mùa đông!")
}
