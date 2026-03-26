import QtQuick
import "../../core"

ModelBuilder {
    title: qsTr("Mô hình: Cá thở bằng mang")
    instructions: qsTr("Kéo các ô vào đúng thứ tự để giải thích cách cá lấy oxy từ nước.")

    correctSequence: [
        { id: "water_in", label: qsTr("Nước vào miệng cá") },
        { id: "flow_gill", label: qsTr("Nước chảy qua mang") },
        { id: "absorb_o2", label: qsTr("Mao mạch hấp thụ O₂") },
        { id: "release_co2", label: qsTr("CO₂ thải ra nước") },
        { id: "blood_o2", label: qsTr("Máu mang O₂ đi nuôi cơ thể") }
    ]

    distractors: [
        { id: "drink_o2", label: qsTr("Cá uống oxy") },
        { id: "hold_breath", label: qsTr("Cá nín thở lâu") },
        { id: "gill_create", label: qsTr("Mang tạo ra oxy") }
    ]

    dropZoneLabels: [
        qsTr("Đầu vào"),
        qsTr("Cơ quan"),
        qsTr("Hấp thụ"),
        qsTr("Thải"),
        qsTr("Kết quả")
    ]
}
