import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    color: "lightgray"

    ListModel {
        id: listModel
    }

    Component {
        id: toDoDelegate

        Column {
        spacing: 10
        width: parent.width
        Text {
            text: model.title
            font.pixelSize: 20
        }

        Text {
           text: model.desc
           font.pixelSize: 20
        }

        }
    }

    Rectangle {
        id: header
        color: "lightblue"
        height: 50
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        Text {
            text: "<b>Todo</b>"
            font.pointSize: 24
        }
    }

    Row {
        id: mainRow
        spacing: 20
        anchors {
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            topMargin: 20
        }

        Rectangle {
            id: toDoItems
            width: parent.width / 2
            height: parent.height - 20
            color: "lightblue"
            radius: 20

            ListView {
                id: lv
                anchors.fill: parent
                clip: true
                model: listModel
                delegate: toDoDelegate

            }
        }
        Rectangle {
            id: addItems
            width: parent.width / 2
            height: parent.height - 20
            color: "lightblue"
            radius: 20

            Rectangle {
                id: todoTitleBox
                color: "white"
                height: 30
                anchors {
                    left: parent.left
                    top: parent. top
                    right: parent.right
                }

            TextInput {
                id: toDoTitle
                text: "Title"
                anchors.fill: parent
                focus: true
                activeFocusOnTab: true
                color: focus ? "black" : "gray"

            }
        }
            Rectangle {
                id: todoDescBox
                color: "white"
                height: 30
                anchors {
                    left: parent.left
                    top: todoTitleBox.bottom
                    topMargin: 20
                    right: parent.right
                }

            TextInput {
                anchors.fill: parent
                text: "Description"
                id: toDoDesc
                activeFocusOnTab: true
                color: focus ? "black" : "gray"

            }
         }
            MyButton {
                text: "Add item"
                textColor: "white"
                color: "red"
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                    bottomMargin: 10
                }

                onClicked: {
                    listModel.append({"title": toDoTitle.text, "desc": toDoDesc.text})
                    toDoTitle.text = ""
                    toDoDesc.text = ""
                }
            }
        }

    }
}
