import QtQuick
import "../../core"

ModelBuilder {
    title: qsTr("Mô hình: Thẩm thấu ở cây ngập mặn")
    instructions: qsTr("Sắp xếp các bước giải thích cách cây đước sống trong nước mặn.")

    correctSequence: [
        { id: "salt_water", label: qsTr("Nước mặn quanh rễ") },
        { id: "filter", label: qsTr("Rễ lọc muối 90%") },
        { id: "water_in", label: qsTr("Nước vào tế bào") },
        { id: "salt_excrete", label: qsTr("Lá tiết muối thừa") },
        { id: "survive", label: qsTr("Cây sống khỏe") }
    ]

    distractors: [
        { id: "absorb_salt", label: qsTr("Hấp thụ toàn bộ muối") },
        { id: "no_water", label: qsTr("Không cần nước") },
        { id: "osmosis_out", label: qsTr("Nước rút ra ngoài") }
    ]

    dropZoneLabels: [
        qsTr("Môi trường"),
        qsTr("Rễ"),
        qsTr("Tế bào"),
        qsTr("Lá"),
        qsTr("Kết quả")
    ]
}
