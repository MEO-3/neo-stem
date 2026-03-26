import QtQuick
import "../../core"

ModelBuilder {
    title: qsTr("Mô hình: Kem tan chảy")
    instructions: qsTr("Kéo các ô vào đúng thứ tự để giải thích tại sao kem tan ngoài nắng.")

    correctSequence: [
        { id: "heat_source", label: qsTr("Nguồn nhiệt (nắng/không khí)") },
        { id: "heat_transfer", label: qsTr("Nhiệt truyền vào kem") },
        { id: "vibrate", label: qsTr("Phân tử rung nhanh hơn") },
        { id: "break_bond", label: qsTr("Liên kết tinh thể phá vỡ") },
        { id: "melt", label: qsTr("Rắn → Lỏng (tan chảy)") }
    ]

    distractors: [
        { id: "absorb_light", label: qsTr("Kem hấp thụ ánh sáng") },
        { id: "wind_melt", label: qsTr("Gió làm tan") },
        { id: "decompose", label: qsTr("Kem tự phân hủy") }
    ]

    dropZoneLabels: [
        qsTr("Nguồn"),
        qsTr("Truyền nhiệt"),
        qsTr("Vi mô"),
        qsTr("Thay đổi"),
        qsTr("Kết quả")
    ]
}
