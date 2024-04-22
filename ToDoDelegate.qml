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
        property bool __edit: true



            Image {
                id: editButton
                source:  __edit ? "trashimage/edit.png" : "trashimage/cancel.png"
                width: 30
                height: 30
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.topMargin: 200

                MouseArea {
                    id: editMouse
                    anchors.fill: parent
                    onClicked: __edit = !__edit
                }

            }

            Image {
                id: trashcan
                source: "trashimage/trashcan.jpg"
                fillMode: Image.Stretch
                width: 50
                height: 50

                anchors {
                    right: parent.right
                    bottom: parent.bottom
                    rightMargin: 2
                    bottomMargin: 2
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


        TextInput {
            id: titleTxt
            x: 2
            width: parent.width - 20 - trashcan.width
            text: model.title
            font.pixelSize: 18
            clip: true
            readOnly: __edit

            onTextEdited: model.title = text
            onTextChanged: if (length > toDoTitle.characterLimit) remove (toDoTitle.characterLimit, length)

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
            readOnly: __edit

            onTextEdited: model.desc = text
            onTextChanged: if (length > toDoDesc.characterLimit) remove (toDoDesc.characterLimit, length)

        }


    }


}