import QtQuick
import "../../core"

ModelBuilder {
    title: qsTr("Mô hình: Bóng đèn phát sáng")
    instructions: qsTr("Kéo các ô vào đúng thứ tự để giải thích tại sao bóng đèn phát sáng khi bật công tắc.")

    correctSequence: [
        { id: "current", label: qsTr("Dòng điện chạy qua mạch kín") },
        { id: "filament", label: qsTr("Qua dây tóc tungsten") },
        { id: "heat", label: qsTr("Dây tóc nóng đến 2500°C") },
        { id: "convert", label: qsTr("Phát ra ánh sáng + nhiệt") },
        { id: "bright", label: qsTr("Phòng được chiếu sáng") }
    ]

    distractors: [
        { id: "create_elec", label: qsTr("Đèn tạo ra điện") },
        { id: "light_heat", label: qsTr("Ánh sáng = nhiệt") },
        { id: "burn", label: qsTr("Dây tóc bị cháy") }
    ]

    dropZoneLabels: [
        qsTr("Nguồn"),
        qsTr("Vật dẫn"),
        qsTr("Nhiệt độ"),
        qsTr("Chuyển hóa"),
        qsTr("Kết quả")
    ]
}
