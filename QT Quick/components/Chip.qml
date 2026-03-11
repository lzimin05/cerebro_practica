import QtQuick 2.0

Rectangle {
    id: chip

    property string text: ""
    signal deleteChip()

    implicitWidth: contentRow.width + 15
    implicitHeight: 32

    width: implicitWidth
    height: implicitHeight

    color: "#B7D4FF"
    radius: 8
    border.color: "#3498DB"
    border.width: 2

    Row {
        id: contentRow
        anchors.centerIn: parent
        spacing: 5

        Text {
            text: chip.text
            font.pixelSize: 14
            color: "#2C3E50"
        }

        Rectangle {
            id: deleteBox
            width: 20
            height: 20
            radius: 10
            color: "#E74C3C"

            Text {
                anchors.centerIn: parent
                text: "×"
                font.bold: true
                font.pixelSize: 16
                color: "white"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: chip.deleteChip()
                onPressed: deleteBox.opacity = 0.7
                onReleased: deleteBox.opacity = 1
            }
        }
    }
}
