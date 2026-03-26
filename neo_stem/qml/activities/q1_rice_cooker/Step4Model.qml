import QtQuick
import "../../core"

ModelBuilder {
    title: qsTr("Mô hình: Nước sôi trong nồi")
    instructions: qsTr("Kéo các ô vào đúng thứ tự để giải thích tại sao nắp nồi cơm điện rung và có hơi nước.")

    correctSequence: [
        { id: "liquid", label: qsTr("Nước lỏng") },
        { id: "heat", label: qsTr("Nhiệt tăng") },
        { id: "fast_mol", label: qsTr("Phân tử nhanh") },
        { id: "boil", label: qsTr("Bay hơi / Sôi") },
        { id: "steam", label: qsTr("Hơi nước") }
    ]

    distractors: [
        { id: "freeze", label: qsTr("Đóng băng") },
        { id: "disappear", label: qsTr("Nước mất đi") },
        { id: "pressure_down", label: qsTr("Áp suất giảm") }
    ]

    dropZoneLabels: [
        qsTr("Ban đầu"),
        qsTr("Nguyên nhân"),
        qsTr("Vi mô"),
        qsTr("Hiện tượng"),
        qsTr("Kết quả")
    ]
}
