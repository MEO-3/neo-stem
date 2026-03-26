import QtQuick
import "../../core"

ModelBuilder {
    title: qsTr("Mô hình: Chai nước và tần số âm thanh")
    instructions: qsTr("Kéo các ô vào đúng thứ tự để giải thích tại sao gõ chai nước khác mực nghe khác nhau.")

    correctSequence: [
        { id: "tap", label: qsTr("Gõ chai") },
        { id: "air_vibrate", label: qsTr("Cột không khí rung") },
        { id: "less_air", label: qsTr("Ít không khí = rung nhanh") },
        { id: "high_freq", label: qsTr("Tần số cao") },
        { id: "high_pitch", label: qsTr("Nghe tiếng cao") }
    ]

    distractors: [
        { id: "water_sound", label: qsTr("Nước tạo âm") },
        { id: "big_bottle", label: qsTr("Chai to = tiếng to") },
        { id: "hard_tap", label: qsTr("Gõ mạnh = tiếng cao") }
    ]

    dropZoneLabels: [
        qsTr("Hành động"),
        qsTr("Rung động"),
        qsTr("Nguyên lý"),
        qsTr("Kết quả vật lý"),
        qsTr("Kết quả nghe")
    ]
}
