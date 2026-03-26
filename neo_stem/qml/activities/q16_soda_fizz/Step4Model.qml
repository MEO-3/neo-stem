import QtQuick
import "../../core"

ModelBuilder {
    title: qsTr("Mô hình: Nước ngọt có ga phun bọt")
    instructions: qsTr("Kéo các ô vào đúng thứ tự để giải thích tại sao mở chai nước ngọt có ga bọt phun ra.")

    correctSequence: [
        { id: "dissolve", label: qsTr("CO₂ hòa tan dưới áp suất cao") },
        { id: "open", label: qsTr("Mở nắp = giảm áp suất") },
        { id: "escape", label: qsTr("CO₂ thoát khỏi nước") },
        { id: "bubbles", label: qsTr("Tạo bọt khí") },
        { id: "fizz", label: qsTr("Bọt phun ra ngoài") }
    ]

    distractors: [
        { id: "self_bubble", label: qsTr("Nước tự tạo bọt") },
        { id: "hot_water", label: qsTr("Chai nóng = nhiều nước") },
        { id: "shake_co2", label: qsTr("Lắc tạo CO₂ mới") }
    ]

    dropZoneLabels: [
        qsTr("Trạng thái đầu"),
        qsTr("Tác động"),
        qsTr("Phản ứng"),
        qsTr("Hiện tượng"),
        qsTr("Kết quả")
    ]
}
