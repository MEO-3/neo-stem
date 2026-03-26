import QtQuick
import "../../core"

ModelBuilder {
    title: qsTr("Mô hình: Ngưng tụ trên ly đá")
    instructions: qsTr("Sắp xếp các bước giải thích tại sao bên ngoài ly đá có giọt nước.")

    correctSequence: [
        { id: "cold_glass", label: qsTr("Đá làm lạnh ly") },
        { id: "air_contact", label: qsTr("Không khí ẩm chạm ly") },
        { id: "below_dew", label: qsTr("Nhiệt < Điểm sương") },
        { id: "condense", label: qsTr("Hơi nước ngưng tụ") },
        { id: "droplets", label: qsTr("Giọt nước bám ngoài") }
    ]

    distractors: [
        { id: "leak", label: qsTr("Nước rò rỉ từ ly") },
        { id: "evaporate", label: qsTr("Nước bay hơi") },
        { id: "ice_melt", label: qsTr("Đá tan thấm qua ly") }
    ]

    dropZoneLabels: [
        qsTr("Bước 1"),
        qsTr("Bước 2"),
        qsTr("Điều kiện"),
        qsTr("Quá trình"),
        qsTr("Kết quả")
    ]
}
