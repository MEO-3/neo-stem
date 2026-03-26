import QtQuick
import "../../core"

ModelBuilder {
    title: qsTr("Mô hình: Âm thanh từ trống")
    instructions: qsTr("Kéo các ô vào đúng thứ tự để giải thích tại sao đập trống phát ra tiếng vang.")

    correctSequence: [
        { id: "hit", label: qsTr("Đập trống") },
        { id: "vibrate", label: qsTr("Mặt trống rung") },
        { id: "push_air", label: qsTr("Đẩy không khí") },
        { id: "sound_wave", label: qsTr("Sóng âm lan tỏa") },
        { id: "ear_hear", label: qsTr("Tai nhận sóng = Nghe") }
    ]

    distractors: [
        { id: "wind", label: qsTr("Trống tạo gió") },
        { id: "light_sound", label: qsTr("Âm thanh là ánh sáng") },
        { id: "close_only", label: qsTr("Chỉ nghe khi gần") }
    ]

    dropZoneLabels: [
        qsTr("Hành động"),
        qsTr("Rung động"),
        qsTr("Môi trường"),
        qsTr("Truyền sóng"),
        qsTr("Kết quả")
    ]
}
