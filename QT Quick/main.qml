import QtQuick 2.0
import "components"
Window {
    width: 800
    height: 500
    visible: true
    title: qsTr("List")
    color: "#B7D4FF"

    Rectangle {
        width: parent.width
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#B7D4FF" }
            GradientStop { position: 1.0; color: "#7EB3FF" }
        }

        Item {
            anchors.fill: parent
            anchors.margins: 40

            Column {
                width: parent.width - 300
                height: parent.height - 100
                spacing: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                InputField {
                    onTextEntered: function(text) {
                       chipModel.addChip(text)
                   }
                }
                Rectangle {
                    width: parent.width
                    height: parent.height - 60
                    color: "#F0F8FF"
                    radius: 10
                    border.color: "#3498DB"
                    border.width: 2
                    ChipFlow {
                        anchors.fill: parent
                        anchors.margins: 10
                        model: chipModel
                    }
                }
            }
        }
    }
}
