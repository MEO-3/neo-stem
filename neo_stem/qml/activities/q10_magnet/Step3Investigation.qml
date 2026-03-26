import QtQuick
import "../../core"
import QtQuick.Layouts

InvestigationBase {
    title: qsTr("Thí nghiệm: Nam châm và vật liệu")
    instructions: qsTr("Kéo nam châm lại gần 6 vật liệu. Quan sát hút/không hút. Thay đổi khoảng cách. Ghi lại dữ liệu.")
    requiredDataPoints: 6
    dataHeaders: [qsTr("Vật liệu"), qsTr("Hút/Không"), qsTr("Lực"), qsTr("Khoảng cách")]

    property int selectedMaterial: 0
    property real magnetDistance: 50  // percent distance (0=gần, 100=xa)

    readonly property var materials: [
        { name: qsTr("Sắt"), attracted: true, force: qsTr("Mạnh"), color: "#78909C" },
        { name: qsTr("Thép"), attracted: true, force: qsTr("Mạnh"), color: "#90A4AE" },
        { name: qsTr("Nhôm"), attracted: false, force: qsTr("Không"), color: "#CFD8DC" },
        { name: qsTr("Đồng"), attracted: false, force: qsTr("Không"), color: "#FF8A65" },
        { name: qsTr("Gỗ"), attracted: false, force: qsTr("Không"), color: "#A1887F" },
        { name: qsTr("Nhựa"), attracted: false, force: qsTr("Không"), color: "#81C784" }
    ]

    experimentArea: [
        Item {
            anchors.fill: parent

            // Magnet
            Rectangle {
                id: magnetExp
                property real effectiveX: parent.width * 0.15 + magnetDistance / 100 * parent.width * 0.3
                x: effectiveX; anchors.verticalCenter: parent.verticalCenter
                width: 60; height: 30; radius: 4; color: "#F44336"
                Text { anchors.centerIn: parent; text: "N   S"; font.pixelSize: 12; font.bold: true; color: "white" }

                Behavior on x { NumberAnimation { duration: 200 } }
            }

            // Target material
            Rectangle {
                id: targetItem
                property bool isAttracted: materials[selectedMaterial].attracted
                property real pullOffset: isAttracted && magnetDistance < 30 ? -(30 - magnetDistance) * 0.5 : 0
                x: parent.width * 0.65 + pullOffset
                anchors.verticalCenter: parent.verticalCenter
                width: 40; height: 40; radius: 6
                color: materials[selectedMaterial].color
                border.width: 2; border.color: isAttracted && magnetDistance < 20 ? "#F44336" : "#999"

                Behavior on x { NumberAnimation { duration: 300 } }
                Behavior on border.color { ColorAnimation { duration: 300 } }

                Text {
                    anchors.centerIn: parent
                    text: materials[selectedMaterial].name
                    font.pixelSize: 11; font.bold: true; color: "#333"
                }
            }

            // Force indicator
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top; anchors.topMargin: 10
                text: materials[selectedMaterial].attracted
                    ? (magnetDistance < 20 ? qsTr("Lực hút: MẠNH") : (magnetDistance < 50 ? qsTr("Lực hút: Vừa") : qsTr("Lực hút: Yếu")))
                    : qsTr("KHÔNG bị hút")
                font.pixelSize: NeoConstants.fontCaption; font.bold: true
                color: materials[selectedMaterial].attracted ? "#F44336" : "#78909C"
            }

            // Material selector
            Row {
                anchors.bottom: parent.bottom; anchors.bottomMargin: 8
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 6
                Repeater {
                    model: materials
                    Rectangle {
                        width: 50; height: 30; radius: 6
                        color: selectedMaterial === index ? modelData.color : "#E0E0E0"
                        border.width: selectedMaterial === index ? 2 : 1
                        border.color: selectedMaterial === index ? "#333" : "#999"
                        Text { anchors.centerIn: parent; text: modelData.name; font.pixelSize: 10; color: "#333" }
                        MouseArea { anchors.fill: parent; onClicked: selectedMaterial = index }
                    }
                }
            }
        }
    ]

    controlsArea: [
        SliderControl {
            anchors.fill: parent; anchors.margins: 8
            label: qsTr("📏 Khoảng cách nam châm")
            value: magnetDistance; from: 0; to: 100; stepSize: 1
            accentColor: "#F44336"
            labels: [qsTr("Gần"), qsTr("Trung bình"), qsTr("Xa")]
            onValueChanged: magnetDistance = value
        }
    ]

    function recordCurrentData() {
        var m = materials[selectedMaterial]
        var distLabel = magnetDistance < 30 ? qsTr("Gần") : (magnetDistance < 70 ? qsTr("Trung bình") : qsTr("Xa"))
        addDataPoint([m.name, m.attracted ? qsTr("Hút") : qsTr("Không"), m.force, distLabel])
    }

    function getConclusion() {
        if (dataPoints.length >= requiredDataPoints) {
            return qsTr("Kết luận: Nam châm chỉ hút các vật liệu có tính SẮT TỪ — chủ yếu là sắt, thép, niken, coban. " +
                        "Các vật liệu khác (nhôm, đồng, gỗ, nhựa) KHÔNG bị hút vì electron của chúng không sắp xếp theo từ trường. " +
                        "Lực hút mạnh hơn khi khoảng cách gần hơn. " +
                        "Không phải TẤT CẢ kim loại đều bị nam châm hút!")
        }
        return qsTr("Cần thêm dữ liệu để kết luận.")
    }
}
