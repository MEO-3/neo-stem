import QtQuick
import "../../core"

ProblematizeChallenge {
    title: qsTr("Thách thức: Khinh khí cầu")

    scenario: qsTr("Gia đình bạn Minh đi du lịch và được trải nghiệm bay khinh khí cầu. " +
                   "Bạn Minh thấy người lái đốt lửa để đốt nóng không khí bên trong bóng khí cầu khổng lồ. " +
                   "Không cần heli, khinh khí cầu vẫn bay lên được! Minh thắc mắc: không khí thường " +
                   "thì nặng, tại sao đốt nóng lại bay được?")

    challengeQuestion: qsTr("Tại sao khinh khí cầu bay được bằng không khí nóng?")

    choices: [
        {
            text: qsTr("Không khí nóng nở ra, mật độ giảm, nhẹ hơn không khí mát xung quanh, lực đẩy Archimedes nâng khí cầu lên"),
            correct: true,
            explanation: qsTr("Đúng! Khi đốt nóng không khí bên trong khí cầu, các phân tử khí chuyển động nhanh hơn và giãn nở ra. " +
                            "Cùng thể tích nhưng ít phân tử hơn → mật độ giảm. Không khí nóng (khoảng 100°C) có mật độ ~0.95 kg/m³, " +
                            "nhẹ hơn không khí mát (1.225 kg/m³). Lực đẩy Archimedes lớn hơn trọng lượng → bay lên! " +
                            "Nguyên lý giống hệt bóng heli: mật độ bên trong < mật độ bên ngoài.")
        },
        {
            text: qsTr("Lửa tạo ra khí heli bên trong khí cầu"),
            correct: false,
            explanation: qsTr("Lửa không tạo ra heli. Lửa chỉ đốt nóng không khí sẵn có bên trong khí cầu. " +
                            "Khi nóng lên, không khí nở ra và mật độ giảm — đó mới là lý do khí cầu bay lên.")
        },
        {
            text: qsTr("Khói từ lửa đẩy khí cầu lên giống như tên lửa"),
            correct: false,
            explanation: qsTr("Khinh khí cầu không hoạt động như tên lửa. Không có lực phản lực nào ở đây. " +
                            "Khí cầu bay lên nhờ lực đẩy Archimedes — vì không khí nóng bên trong nhẹ hơn không khí mát bên ngoài.")
        },
        {
            text: qsTr("Nhiệt từ lửa làm vải khí cầu nhẹ hơn"),
            correct: false,
            explanation: qsTr("Nhiệt không làm thay đổi khối lượng vải khí cầu. Nhiệt làm nóng KHÔNG KHÍ bên trong, " +
                            "khiến không khí nở ra và mật độ giảm. Chính sự chênh lệch mật độ tạo ra lực đẩy Archimedes.")
        }
    ]

    extendedInfo: qsTr("Lịch sử và khoa học khinh khí cầu:\n\n" +
                       "Anh em Montgolfier (Pháp, 1783) là người đầu tiên chế tạo khinh khí cầu bay thành công " +
                       "bằng không khí nóng. Họ nhận thấy khói nóng bay lên và nghĩ cách thu khói vào túi vải lớn.\n\n" +
                       "Điều khiển độ cao: Đốt lửa mạnh → nóng hơn → bay cao hơn. Tắt lửa → nguội dần → hạ xuống. " +
                       "Mở van trên đỉnh → xả khí nóng → hạ nhanh.\n\n" +
                       "Hydro (H₂) nhẹ nhất nhưng rất dễ cháy nổ (thảm họa Hindenburg 1937). " +
                       "Heli (He) nhẹ thứ hai và không cháy → an toàn hơn nhiều, được dùng phổ biến cho bóng bay.\n\n" +
                       "Nguyên lý chung: Bất kỳ khí nào có mật độ nhỏ hơn không khí xung quanh " +
                       "đều tạo ra lực nổi (đẩy Archimedes), giống như gỗ nổi trên nước vì nhẹ hơn nước!")
}
