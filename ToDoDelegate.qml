import QtQuick

Component {
    id: toDoDelegate

    Rectangle {
        id: toDoRect
        width: root.width / 2
        color: "lightblue"
        height: 100
        border.color: "black"
        border.width: 2
        Image {
            id: trashcan
            source: "trashimage/trashcan.jpg"
            fillMode: Image.Stretch
            width: 50
            height: 50
            anchors {
                right: parent.right
                top: parent.top
                topMargin: 20
                rightMargin: 2
            }

            Rectangle {
                anchors.fill: parent
                color: "red"
                opacity: imageMouse.containsPress ? 0.5 : 0.25
                radius: 20
                visible: imageMouse.containsMouse
            }

            MouseArea {
                id: imageMouse
                hoverEnabled: true
                anchors.fill: parent
                onClicked: {
                    listModel.remove(index)
                }
            }

        }

        Text {
            id: titleTxt
            x: 2
            width: parent.width - 20 - trashcan.width
            text: model.title
            font.pixelSize: 20
            clip: true
            wrapMode: Text.WordWrap
        }


        TextInput {
            id: descTxt
            x: 2
            width: parent.width - 20 - trashcan.width
            height: parent.height - titleTxt.height
            text: model.desc
            color: "gray"
            font.pixelSize: 12
            anchors.top: titleTxt.bottom
            clip: true
            wrapMode: TextInput.Wrap
            readOnly: true

        }


    }


}
