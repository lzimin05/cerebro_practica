import QtQuick 2.0

Rectangle {
    id: inputBox
    height: 40
    width: parent.width
    color: "white"
    border.color: "#3498DB"
    border.width: 2
    radius: 10

    signal textEntered(string text)

    TextInput {
        id: inputField
        color: "#2C3E50"
        anchors.fill: parent
        anchors.leftMargin: 10
        verticalAlignment: TextInput.AlignVCenter
        font.pixelSize: 16

        onAccepted: {
            if (text.length > 0) {
                inputBox.textEntered(text)
                text = ""
            }
        }
    }

    Text {
        anchors.fill: parent
        anchors.leftMargin: 10
        verticalAlignment: TextInput.AlignVCenter
        font.pixelSize: 16
        text: "Enter new value..."
        color: "#BDC3C7"
        visible: inputField.text.length === 0 && !inputField.focus
    }
}
