import QtQuick
import "../../core"

ModelBuilder {
    title: qsTr("Mô hình: Tách muối bằng bay hơi")
    instructions: qsTr("Sắp xếp các bước giải thích quá trình lấy muối từ nước biển.")

    correctSequence: [
        { id: "seawater", label: qsTr("Nước biển (hỗn hợp)") },
        { id: "sun_heat", label: qsTr("Nhiệt mặt trời") },
        { id: "evaporate", label: qsTr("Nước bay hơi") },
        { id: "saturate", label: qsTr("Dung dịch bão hòa") },
        { id: "crystal", label: qsTr("Muối kết tinh") }
    ]

    distractors: [
        { id: "filter", label: qsTr("Lọc qua giấy") },
        { id: "salt_evap", label: qsTr("Muối bay hơi") },
        { id: "cool_down", label: qsTr("Làm lạnh nước") }
    ]

    dropZoneLabels: [
        qsTr("Nguyên liệu"),
        qsTr("Năng lượng"),
        qsTr("Quá trình"),
        qsTr("Trung gian"),
        qsTr("Sản phẩm")
    ]
}
