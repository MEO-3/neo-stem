import QtQuick
import "../../core"

DrivingQuestionBoard {
    drivingQuestion: qsTr("Tại sao xe đạp đi nhanh hơn khi xuống dốc?")

    subQuestions: [
        { text: qsTr("Lực nào kéo xe xuống?"), answered: false },
        { text: qsTr("Tại sao lên dốc phải đạp mạnh?"), answered: false },
        { text: qsTr("Năng lượng từ đâu khi xuống dốc?"), answered: false },
        { text: qsTr("Phanh hoạt động thế nào?"), answered: false },
        { text: qsTr("Dốc cao hơn có nhanh hơn không?"), answered: false }
    ]
}
