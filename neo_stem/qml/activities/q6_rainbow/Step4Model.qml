import QtQuick
import "../../core"

ModelBuilder {
    title: qsTr("Mô hình: Cầu vồng hình thành")
    instructions: qsTr("Kéo các ô vào đúng thứ tự để giải thích tại sao cầu vồng xuất hiện sau cơn mưa.")

    correctSequence: [
        { id: "white_light", label: qsTr("Ánh sáng trắng") },
        { id: "enter_drop", label: qsTr("Vào giọt nước") },
        { id: "refract", label: qsTr("Khúc xạ tách màu") },
        { id: "reflect", label: qsTr("Phản xạ bên trong") },
        { id: "rainbow", label: qsTr("7 màu = Cầu vồng") }
    ]

    distractors: [
        { id: "dye", label: qsTr("Giọt nước nhuộm màu") },
        { id: "sun_change", label: qsTr("Mặt trời đổi màu") },
        { id: "illusion", label: qsTr("Mắt tạo ảo giác") }
    ]

    dropZoneLabels: [
        qsTr("Nguồn sáng"),
        qsTr("Bước 1"),
        qsTr("Bước 2"),
        qsTr("Bước 3"),
        qsTr("Kết quả")
    ]
}
