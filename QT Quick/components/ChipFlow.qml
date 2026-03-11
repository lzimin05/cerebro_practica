import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    id: chipFlow

    property alias model: repeater.model
    property int spacing: 8

    Flickable {
        id: flickable
        anchors.fill: parent
        contentWidth: flow.width
        contentHeight: flow.height
        clip: true

        ScrollBar.vertical: ScrollBar {
            policy: ScrollBar.AlwaysOn
            visible: flickable.contentHeight > flickable.height
            width: 8
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }

        Flow {
            id: flow
            width: chipFlow.width
            spacing: chipFlow.spacing
            flow: Flow.LeftToRight
            layoutDirection: Qt.LeftToRight

            Repeater {
                id: repeater
                model: chipFlow.model

                Chip {
                    text: model.text
                    onDeleteChip: repeater.model.removeChip(index)
                }
            }
        }
    }
}
