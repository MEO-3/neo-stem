import QtQuick
import "../../core"

ModelBuilder {
    title: qsTr("Mô hình: Nam châm hút sắt")
    instructions: qsTr("Kéo các ô vào đúng thứ tự để giải thích tại sao nam châm hút đinh sắt.")

    correctSequence: [
        { id: "field", label: qsTr("Nam châm tạo từ trường") },
        { id: "ferro", label: qsTr("Vật chứa sắt/thép/niken") },
        { id: "align", label: qsTr("Electron sắp xếp theo từ trường") },
        { id: "force", label: qsTr("Lực hút sinh ra") },
        { id: "stick", label: qsTr("Vật dính vào nam châm") }
    ]

    distractors: [
        { id: "all_metal", label: qsTr("Nam châm dính mọi kim loại") },
        { id: "field_elec", label: qsTr("Từ trường = điện") },
        { id: "alu_weak", label: qsTr("Nhôm bị hút yếu") }
    ]

    dropZoneLabels: [
        qsTr("Nguồn"),
        qsTr("Vật liệu"),
        qsTr("Vi mô"),
        qsTr("Lực"),
        qsTr("Kết quả")
    ]
}
