import QtQuick
import "../../core"

PhenomenonViewer {
    title: qsTr("Hiện tượng: Mặt trăng thay đổi hình dạng")
    description: qsTr("Quan sát bầu trời đêm Việt Nam qua nhiều đêm. Mặt trăng trông khác nhau — bạn thấy gì?")

    hotspots: [
        { x: 0.5, y: 0.3, label: qsTr("Mặt trăng"), detail: qsTr("Mặt trăng không tự phát sáng — nó phản chiếu ánh sáng mặt trời. Phần sáng là nơi mặt trời chiếu đến, phần tối là nơi không có ánh sáng.") },
        { x: 0.35, y: 0.35, label: qsTr("Bóng tối"), detail: qsTr("Phần tối trên mặt trăng không phải do bóng Trái Đất. Đó đơn giản là phần mặt trăng quay lưng về phía mặt trời, không nhận ánh sáng.") },
        { x: 0.7, y: 0.15, label: qsTr("Ánh sáng mặt trời"), detail: qsTr("Mặt trời luôn chiếu sáng đúng nửa mặt trăng. Nhưng từ Trái Đất, ta nhìn thấy phần sáng đó ở các góc khác nhau khi mặt trăng quay quanh chúng ta.") }
    ]

    sceneComponent: Component {
        Rectangle {
            anchors.fill: parent
            radius: 12
            color: "#0D1B2A"

            // Stars
            Repeater {
                model: 30
                Rectangle {
                    property real sx: Math.random()
                    property real sy: Math.random()
                    property real sDur: 1000 + Math.random() * 2000
                    x: parent.width * sx; y: parent.height * sy
                    width: 3; height: 3; radius: 1.5; color: "white"
                    SequentialAnimation on opacity {
                        running: true; loops: Animation.Infinite
                        NumberAnimation { from: 0.3; to: 1.0; duration: sDur }
                        NumberAnimation { from: 1.0; to: 0.3; duration: sDur }
                    }
                }
            }

            // Moon
            Rectangle {
                id: moonFull
                anchors.centerIn: parent
                width: Math.min(parent.width, parent.height) * 0.35
                height: width; radius: width / 2
                color: "#F5F5DC"

                // Moon shadow - animated to show phases
                Rectangle {
                    id: moonShadow
                    anchors.verticalCenter: parent.verticalCenter
                    height: parent.height
                    width: parent.width
                    radius: parent.radius
                    color: "#0D1B2A"
                    clip: true

                    SequentialAnimation on x {
                        running: true; loops: Animation.Infinite
                        NumberAnimation { from: -moonFull.width; to: moonFull.width; duration: 8000; easing.type: Easing.InOutSine }
                        NumberAnimation { from: moonFull.width; to: -moonFull.width; duration: 8000; easing.type: Easing.InOutSine }
                    }
                }

                // Moon craters
                Repeater {
                    model: [
                        { cx: 0.3, cy: 0.4, r: 0.08 },
                        { cx: 0.6, cy: 0.3, r: 0.06 },
                        { cx: 0.5, cy: 0.65, r: 0.1 },
                        { cx: 0.7, cy: 0.6, r: 0.05 }
                    ]
                    Rectangle {
                        x: moonFull.width * modelData.cx - width / 2
                        y: moonFull.height * modelData.cy - height / 2
                        width: moonFull.width * modelData.r
                        height: width; radius: width / 2
                        color: "#D4C89A"
                        opacity: 0.5
                    }
                }
            }

            // Phase label
            Text {
                anchors.bottom: parent.bottom; anchors.bottomMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Mặt trăng thay đổi pha liên tục...")
                font.pixelSize: NeoConstants.fontCaption
                color: "#B0BEC5"
            }

            // Ground silhouette
            Rectangle {
                anchors.bottom: parent.bottom; width: parent.width
                height: parent.height * 0.1; color: "#1B2838"
            }
        }
    }
}
