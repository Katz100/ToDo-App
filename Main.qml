import QtQuick
import QtQuick.Controls // for s

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

        Rectangle {
            width: parent.width
            color: parent.color
            height: 100
            Text {
                id: titleTxt
                width: parent.width - 20
                text: model.title
                font.pixelSize: 20
                clip: true
                wrapMode: WordWrap
            }

            TextInput {
                id: descTxt
                width: parent.width - 20
                height: parent.height - titleTxt.height
                text: model.desc
                color: "gray"
                font.pixelSize: 14
                anchors.top: titleTxt.bottom
                clip: true
                wrapMode: Text.WordWrap
                readOnly: true

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
            anchors.centerIn: parent
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
                border.color: "black"
                border.width: 1
                anchors {
                    left: parent.left
                    top: parent. top

                }

                width: parent.width - 20

                TextInput {
                    property int __limit: 30
                    id: toDoTitle
                    x: 2
                    text: "Title"
                    width: parent.width - 20
                    height: parent.height
                    clip: true
                    focus: true
                    activeFocusOnTab: true
                    color: focus ? "black" : "gray"
                    wrapMode: TextInput.WordWrap
                    onTextChanged: if (length > __limit) remove(__limit, length)
                }
            }
            Rectangle {
                id: todoDescBox
                color: "white"
                height: 50
                border.color: "black"
                border.width: 1
                anchors {
                    left: parent.left
                    top: todoTitleBox.bottom
                    topMargin: 20

                }

                width: parent.width - 20

                TextInput {
                    property int __limit: 150
                    id: toDoDesc
                    x: 2
                    width: parent.width - 5
                    height: parent.height
                    text: "Description"
                    clip: true
                    activeFocusOnTab: true
                    color: focus ? "black" : "gray"
                    wrapMode: TextInput.Wrap
                    maximumLength: 291

                    onTextChanged: if (length > __limit) remove(__limit, length)
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
