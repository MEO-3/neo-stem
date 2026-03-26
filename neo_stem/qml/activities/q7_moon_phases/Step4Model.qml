import QtQuick
import "../../core"

ModelBuilder {
    title: qsTr("Mô hình: Pha mặt trăng")
    instructions: qsTr("Kéo các ô vào đúng thứ tự để giải thích tại sao mặt trăng thay đổi hình dạng.")

    correctSequence: [
        { id: "sun_light", label: qsTr("Mặt trời chiếu sáng") },
        { id: "moon_orbit", label: qsTr("Mặt trăng quay quanh Trái Đất") },
        { id: "angle_change", label: qsTr("Góc nhìn thay đổi") },
        { id: "bright_dark", label: qsTr("Phần sáng/tối đổi") },
        { id: "phases", label: qsTr("Các pha mặt trăng") }
    ]

    distractors: [
        { id: "self_change", label: qsTr("Mặt trăng tự đổi hình") },
        { id: "cloud_cover", label: qsTr("Mây che mặt trăng") },
        { id: "earth_shadow", label: qsTr("Trái Đất che bóng") }
    ]

    dropZoneLabels: [
        qsTr("Nguồn sáng"),
        qsTr("Chuyển động"),
        qsTr("Quan sát"),
        qsTr("Hiện tượng"),
        qsTr("Kết quả")
    ]
}
