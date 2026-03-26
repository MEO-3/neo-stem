import QtQuick
import "../../core"

ModelBuilder {
    title: qsTr("Mô hình: Xe đạp xuống dốc")
    instructions: qsTr("Kéo các ô vào đúng thứ tự để giải thích tại sao xe đạp nhanh hơn khi xuống dốc.")

    correctSequence: [
        { id: "high", label: qsTr("Xe ở trên cao") },
        { id: "pe", label: qsTr("Có thế năng hấp dẫn") },
        { id: "gravity", label: qsTr("Trọng lực kéo xuống") },
        { id: "convert", label: qsTr("Thế năng → Động năng") },
        { id: "faster", label: qsTr("Xe tăng tốc") }
    ]

    distractors: [
        { id: "wind", label: qsTr("Gió đẩy xe") },
        { id: "self_spin", label: qsTr("Bánh xe tự quay") },
        { id: "smooth", label: qsTr("Đường trơn hơn") }
    ]

    dropZoneLabels: [
        qsTr("Vị trí"),
        qsTr("Năng lượng"),
        qsTr("Lực"),
        qsTr("Chuyển hóa"),
        qsTr("Kết quả")
    ]
}
