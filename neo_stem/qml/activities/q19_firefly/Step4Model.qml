import QtQuick
import "../../core"

ModelBuilder {
    title: qsTr("Mô hình: Quá trình phát quang sinh học")
    instructions: qsTr("Kéo các ô vào đúng thứ tự để giải thích quá trình đom đóm phát sáng.")

    correctSequence: [
        { id: "luciferin", label: qsTr("Luciferin trong bụng") },
        { id: "reaction", label: qsTr("Gặp oxy + enzyme luciferase") },
        { id: "chemical", label: qsTr("Phản ứng hóa học") },
        { id: "energy", label: qsTr("Năng lượng → Ánh sáng (không nhiệt)") },
        { id: "glow", label: qsTr("Bụng phát sáng") }
    ]

    distractors: [
        { id: "battery", label: qsTr("Đom đóm có pin") },
        { id: "eat_glow", label: qsTr("Ăn chất phát sáng") },
        { id: "reflect", label: qsTr("Phản xạ ánh trăng") }
    ]

    dropZoneLabels: [
        qsTr("Chất"),
        qsTr("Điều kiện"),
        qsTr("Phản ứng"),
        qsTr("Chuyển hóa"),
        qsTr("Kết quả")
    ]
}
