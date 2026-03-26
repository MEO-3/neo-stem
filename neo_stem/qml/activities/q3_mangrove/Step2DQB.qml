import QtQuick
import "../../core"

DrivingQuestionBoard {
    drivingQuestion: qsTr("Tại sao cây bần/đước sống được trong nước mặn?")

    subQuestions: [
        { text: qsTr("Muối ảnh hưởng tế bào thực vật thế nào?"), answered: false },
        { text: qsTr("Thẩm thấu là gì?"), answered: false },
        { text: qsTr("Rễ cây đước khác rễ cây thường ra sao?"), answered: false },
        { text: qsTr("Cây đước lọc muối bằng cách nào?"), answered: false },
        { text: qsTr("Nước di chuyển vào/ra tế bào theo quy luật gì?"), answered: false }
    ]
}
