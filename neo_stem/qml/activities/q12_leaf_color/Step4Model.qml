import QtQuick
import "../../core"

ModelBuilder {
    title: qsTr("Mô hình: Quang hợp trong lá cây")
    instructions: qsTr("Kéo các ô vào đúng thứ tự để giải thích quá trình quang hợp làm lá xanh.")

    correctSequence: [
        { id: "inputs", label: qsTr("Ánh sáng + CO₂ + H₂O") },
        { id: "absorb", label: qsTr("Lục lạp hấp thụ ánh sáng") },
        { id: "process", label: qsTr("Quang hợp xảy ra") },
        { id: "products", label: qsTr("Glucose + O₂ tạo ra") },
        { id: "growth", label: qsTr("Cây phát triển") }
    ]

    distractors: [
        { id: "soil", label: qsTr("Cây ăn đất") },
        { id: "root_light", label: qsTr("Rễ hấp thụ ánh sáng") },
        { id: "blue_water", label: qsTr("Lá xanh vì nước xanh") }
    ]

    dropZoneLabels: [
        qsTr("Nguyên liệu"),
        qsTr("Nơi xảy ra"),
        qsTr("Quá trình"),
        qsTr("Sản phẩm"),
        qsTr("Kết quả")
    ]
}
