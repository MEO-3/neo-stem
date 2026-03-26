import QtQuick
import "../../core"

ModelBuilder {
    title: qsTr("Mô hình: Quá trình gỉ sét")
    instructions: qsTr("Kéo các ô vào đúng thứ tự để giải thích quá trình sắt bị gỉ sét.")

    correctSequence: [
        { id: "fe", label: qsTr("Sắt (Fe)") },
        { id: "condition", label: qsTr("Gặp nước + oxy") },
        { id: "reaction", label: qsTr("Phản ứng oxy hóa") },
        { id: "product", label: qsTr("Tạo oxit sắt (Fe₂O₃)") },
        { id: "result", label: qsTr("Bề mặt gỉ nâu đỏ") }
    ]

    distractors: [
        { id: "dissolve", label: qsTr("Sắt bị nước hòa tan") },
        { id: "bacteria", label: qsTr("Vi khuẩn ăn sắt") },
        { id: "color_change", label: qsTr("Sắt tự đổi màu") }
    ]

    dropZoneLabels: [
        qsTr("Chất ban đầu"),
        qsTr("Điều kiện"),
        qsTr("Phản ứng"),
        qsTr("Sản phẩm"),
        qsTr("Kết quả")
    ]
}
