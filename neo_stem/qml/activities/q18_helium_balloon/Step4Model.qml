import QtQuick
import "../../core"

ModelBuilder {
    title: qsTr("Mô hình: Tại sao bóng heli bay lên?")
    instructions: qsTr("Kéo các ô vào đúng thứ tự để giải thích tại sao bóng bay heli bay lên trời.")

    correctSequence: [
        { id: "property", label: qsTr("Heli nhẹ hơn không khí") },
        { id: "compare", label: qsTr("Mật độ heli < Mật độ không khí") },
        { id: "force", label: qsTr("Lực đẩy Archimedes > Trọng lượng") },
        { id: "effect", label: qsTr("Bóng bị đẩy lên") },
        { id: "result", label: qsTr("Bay lên trời") }
    ]

    distractors: [
        { id: "hot", label: qsTr("Heli nóng hơn") },
        { id: "motor", label: qsTr("Bóng có motor") },
        { id: "wind", label: qsTr("Gió thổi lên") }
    ]

    dropZoneLabels: [
        qsTr("Tính chất"),
        qsTr("So sánh"),
        qsTr("Lực"),
        qsTr("Tác dụng"),
        qsTr("Kết quả")
    ]
}
