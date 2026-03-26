import QtQuick
import "../../core"

ModelBuilder {
    title: qsTr("Mô hình: Chu trình sương mù Đà Lạt")
    instructions: qsTr("Sắp xếp các bước giải thích tại sao Đà Lạt có sương mù sáng sớm và tan khi trưa.")

    correctSequence: [
        { id: "night_cool", label: qsTr("Đêm: không khí lạnh") },
        { id: "condense", label: qsTr("Hơi nước ngưng tụ") },
        { id: "fog_form", label: qsTr("Sương mù hình thành") },
        { id: "sun_heat", label: qsTr("Mặt trời đốt nóng") },
        { id: "evaporate", label: qsTr("Sương bay hơi, tan") }
    ]

    distractors: [
        { id: "rain", label: qsTr("Mưa rơi xuống") },
        { id: "wind", label: qsTr("Gió thổi mạnh") },
        { id: "freeze", label: qsTr("Nước đóng băng") }
    ]

    dropZoneLabels: [
        qsTr("Đêm"),
        qsTr("Sáng sớm"),
        qsTr("5-7h"),
        qsTr("8-10h"),
        qsTr("Trưa")
    ]
}
