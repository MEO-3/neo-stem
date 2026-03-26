import QtQuick
import "../../core"

ProblematizeChallenge {
    title: qsTr("Thách thức: Sáo trúc Việt Nam")

    scenario: qsTr("Bạn Minh xem nghệ sĩ thổi sáo trúc (sáo Việt Nam truyền thống). " +
                   "Nghệ sĩ chỉ dùng một ống tre có lỗ, nhưng bịt mở các lỗ khác nhau " +
                   "thì tạo ra các nốt nhạc Đồ, Rê, Mi, Fa, Sol, La, Si rõ ràng. " +
                   "Minh nhớ lại thí nghiệm chai nước xylophone — nguyên lý có giống nhau không?")

    challengeQuestion: qsTr("Tại sao bịt lỗ sáo khác nhau tạo nốt nhạc khác nhau?")

    choices: [
        {
            text: qsTr("Bịt lỗ thay đổi chiều dài cột không khí rung trong ống, thay đổi tần số rung = nốt nhạc khác nhau"),
            correct: true,
            explanation: qsTr("Đúng! Khi bịt các lỗ trên sáo, không khí bị giữ lại trong ống dài hơn → cột không khí dài → rung chậm → tần số thấp → tiếng trầm. " +
                             "Khi mở lỗ, không khí thoát ra sớm → cột không khí ngắn → rung nhanh → tần số cao → tiếng cao. " +
                             "Nguyên lý hoàn toàn giống chai nước xylophone: chiều dài cột không khí quyết định cao độ âm thanh!")
        },
        {
            text: qsTr("Các lỗ sáo tạo ra gió mạnh yếu khác nhau"),
            correct: false,
            explanation: qsTr("Không phải. Lỗ sáo không tạo gió — chúng thay đổi chiều dài cột không khí rung bên trong ống sáo. " +
                             "Chính chiều dài cột không khí quyết định tần số, không phải luồng gió.")
        },
        {
            text: qsTr("Mỗi lỗ sáo có kích thước khác nhau nên âm thanh khác nhau"),
            correct: false,
            explanation: qsTr("Kích thước lỗ có ảnh hưởng nhỏ, nhưng yếu tố chính là VỊ TRÍ lỗ trên ống sáo. " +
                             "Vị trí lỗ quyết định chiều dài cột không khí rung — đó mới là nguyên nhân thay đổi cao độ.")
        },
        {
            text: qsTr("Tre là vật liệu đặc biệt tự tạo ra nhiều nốt nhạc"),
            correct: false,
            explanation: qsTr("Vật liệu tre ảnh hưởng đến âm sắc (màu sắc âm thanh) nhưng không quyết định cao độ. " +
                             "Sáo bằng kim loại, nhựa, hay gỗ đều hoạt động theo cùng nguyên lý cột không khí. " +
                             "Bất kỳ ống nào có lỗ đều có thể tạo nốt nhạc khác nhau.")
        }
    ]

    extendedInfo: qsTr("Mở rộng: Nhiều nhạc cụ hơi hoạt động cùng nguyên lý cột không khí!\n\n" +
                       "Sáo recorder (sáo dọc): Bịt lỗ thay đổi cột không khí — giống sáo trúc.\n\n" +
                       "Đàn organ nhà thờ: Mỗi ống có chiều dài khác nhau — ống dài = tiếng trầm, ống ngắn = tiếng cao. " +
                       "Ống lớn nhất dài tới 10 mét!\n\n" +
                       "Kèn trumpet: Bấm van thay đổi chiều dài ống dẫn khí bên trong.\n\n" +
                       "Nguyên lý chung: SÓNG DỪNG (standing waves) hình thành trong ống. " +
                       "Chiều dài ống = bội số bước sóng → chỉ những tần số nhất định được khuếch đại (cộng hưởng). " +
                       "Đó là lý do mỗi vị trí lỗ tạo ra đúng một nốt nhạc chính xác!")
}
