import QtQuick
import "../../core"

ProblematizeChallenge {
    title: qsTr("Thách thức: Xe dừng trên đường phẳng")

    scenario: qsTr("Bạn Khoa đạp xe xuống một con dốc dài, xe tăng tốc rất nhanh. Nhưng khi đến đường phẳng ở chân dốc, " +
                   "dù Khoa không phanh, xe từ từ CHẬM DẦN và cuối cùng DỪNG HẲN. " +
                   "Khoa thắc mắc: nếu không có lực nào cản thì xe phải chạy mãi, vậy lực gì đã dừng xe?")

    challengeQuestion: qsTr("Tại sao xe dừng lại trên đường phẳng sau khi xuống dốc?")

    choices: [
        {
            text: qsTr("Ma sát giữa bánh xe với đường và sức cản không khí chuyển động năng thành nhiệt"),
            correct: true,
            explanation: qsTr("Đúng! Hai lực cản chính: (1) Ma sát giữa bánh xe, ổ trục, đường → tạo nhiệt. (2) Sức cản không khí đẩy ngược xe. Động năng dần chuyển thành nhiệt năng → xe chậm lại → dừng. Sờ lốp xe sau khi phanh sẽ thấy nóng!")
        },
        {
            text: qsTr("Vì trọng lực kéo xe ngược lại trên đường phẳng"),
            correct: false,
            explanation: qsTr("Trên đường phẳng, trọng lực kéo thẳng xuống, không kéo ngược. Trọng lực chỉ ảnh hưởng khi có dốc. Lực cản chính là ma sát và sức cản không khí.")
        },
        {
            text: qsTr("Vì động năng tự biến mất khi xe chạy trên đường phẳng"),
            correct: false,
            explanation: qsTr("Năng lượng không tự biến mất (Định luật bảo toàn năng lượng). Động năng bị chuyển thành nhiệt qua ma sát. Năng lượng chuyển dạng, không mất đi.")
        },
        {
            text: qsTr("Vì xe hết đà — đà là lực tạm thời từ dốc"),
            correct: false,
            explanation: qsTr("'Đà' thực ra là quán tính — xu hướng giữ nguyên trạng thái chuyển động. Xe dừng không phải vì hết đà mà vì ma sát và sức cản chuyển động năng thành nhiệt.")
        }
    ]

    extendedInfo: qsTr("🛝 Mở rộng: Nếu không có ma sát và sức cản không khí (như trong vũ trụ), " +
                       "vật thể sẽ chuyển động mãi mãi! Đó là Định luật 1 Newton (Quán tính).\n\n" +
                       "Ứng dụng: Xe hơi hybrid thu hồi năng lượng phanh — khi phanh, motor chạy ngược " +
                       "chuyển động năng → điện nạp pin, thay vì lãng phí thành nhiệt!")
}
