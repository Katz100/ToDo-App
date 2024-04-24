import QtQuick
import QtQuick.Controls
Component {
    id: toDoDelegate



    Rectangle {
        id: toDoRect
        width: root.width / 2
        color: "lightblue"
        height: 100
        border.color: "black"
        border.width: 2

        Drawer {
            id: drawer
            width: parent.width / 2
            height: root.height
            edge: Qt.LeftEdge

            Column {
                spacing: 10
                anchors.centerIn: parent
                Text {
                    text: "Enter new title"

                }

                MyTextField {
                    id: editTitleBox
                    focus: true
                    characterLimit: 30
                    width: drawer.width
                    height: 30

                }

                Text {
                    text: "Enter new description"
                }

                MyTextField {
                    id: editDescBox
                    characterLimit: 150
                    width: drawer.width
                    height: 50
                }
            }
            Row {
                spacing: 20

                anchors {
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                }

                MyButton {
                    id: cancelButton
                    text: "Cancel"
                    textColor: "white"
                    color: "#F44336"
                    onClicked: drawer.close()
                }

                MyButton {
                    id: enterButton
                    text: "Enter"
                    textColor: "white"
                    color: "#4CAF50"
                    onClicked: {
                        model.title = editTitleBox.text
                        model.desc = editDescBox.text
                        drawer.close()
                    }
                }
            }

        }


        Image {
            id: editButton
            source: "trashimage/edit.png"
            width: 30
            height: 30
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.topMargin: 200

            MouseArea {
                id: editMouse
                anchors.fill: parent
                onClicked: drawer.open()
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
            readOnly: true

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
