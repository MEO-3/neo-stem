import QtQuick
import "../../core"

ProblematizeChallenge {
    title: qsTr("Thách thức: Cầu vồng đôi")

    scenario: qsTr("Bạn Lan đang ngắm cầu vồng sau cơn mưa chiều. Bất ngờ, Lan thấy có HAI cầu vồng! " +
                   "Cầu vồng thứ hai mờ hơn và nằm phía trên cầu vồng chính. Lan nhận ra thứ tự màu " +
                   "của cầu vồng thứ hai bị ngược lại — tím ở ngoài, đỏ ở trong.")

    challengeQuestion: qsTr("Tại sao đôi khi thấy 2 cầu vồng với thứ tự màu ngược nhau?")

    choices: [
        {
            text: qsTr("Vì ánh sáng phản xạ 2 lần bên trong giọt nước, tạo cầu vồng phụ ngược thứ tự màu"),
            correct: true,
            explanation: qsTr("Đúng! Cầu vồng chính do ánh sáng phản xạ 1 lần trong giọt nước. Cầu vồng phụ do phản xạ 2 lần — mỗi lần phản xạ đảo ngược thứ tự màu, nên cầu vồng phụ có màu ngược lại và mờ hơn (mất năng lượng).")
        },
        {
            text: qsTr("Vì có 2 lớp giọt mưa ở 2 độ cao khác nhau"),
            correct: false,
            explanation: qsTr("Số lớp giọt mưa không tạo ra cầu vồng đôi. Cầu vồng phụ sinh ra từ phản xạ bên trong giọt nước, không phải từ lớp mưa khác nhau.")
        },
        {
            text: qsTr("Vì mắt nhìn thấy ảnh phản chiếu của cầu vồng trên mây"),
            correct: false,
            explanation: qsTr("Cầu vồng không phải vật thể thật để có ảnh phản chiếu. Nó là hiện tượng quang học xảy ra ở góc nhìn cụ thể giữa mắt, giọt nước và mặt trời.")
        },
        {
            text: qsTr("Vì mặt trời phát ra 2 chùm ánh sáng khác nhau"),
            correct: false,
            explanation: qsTr("Mặt trời chỉ phát một loại ánh sáng trắng. Cầu vồng đôi do cách ánh sáng tương tác với giọt nước, không phải do nguồn sáng khác nhau.")
        }
    ]

    extendedInfo: qsTr("🌈 Mở rộng: Vùng tối giữa 2 cầu vồng gọi là 'Vùng tối Alexander' (Alexander's dark band). " +
                       "Vùng này tối hơn vì không có ánh sáng phản xạ đến mắt ở góc đó. " +
                       "Lý thuyết còn cho phép cầu vồng 3, 4, 5... nhưng quá mờ để nhìn thấy!\n\n" +
                       "Thí nghiệm tại nhà: Dùng vòi phun sương quay lưng về phía mặt trời → bạn sẽ thấy cầu vồng!")
}
