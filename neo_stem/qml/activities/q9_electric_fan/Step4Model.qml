import QtQuick
import "../../core"

ModelBuilder {
    title: qsTr("Mô hình: Quạt điện hoạt động")
    instructions: qsTr("Kéo các ô vào đúng thứ tự để giải thích tại sao quạt điện quay khi cắm điện.")

    correctSequence: [
        { id: "source", label: qsTr("Nguồn điện (pin/ổ cắm)") },
        { id: "switch", label: qsTr("Công tắc đóng") },
        { id: "current", label: qsTr("Dòng điện chạy qua dây") },
        { id: "motor", label: qsTr("Motor chuyển điện→quay") },
        { id: "fan", label: qsTr("Cánh quạt tạo gió") }
    ]

    distractors: [
        { id: "natural_wind", label: qsTr("Gió tự nhiên") },
        { id: "gasoline", label: qsTr("Quạt dùng xăng") },
        { id: "light_elec", label: qsTr("Điện = ánh sáng") }
    ]

    dropZoneLabels: [
        qsTr("Năng lượng"),
        qsTr("Điều khiển"),
        qsTr("Truyền dẫn"),
        qsTr("Chuyển hóa"),
        qsTr("Kết quả")
    ]
}
