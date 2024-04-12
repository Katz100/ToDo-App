import QtQuick
import QtQuick.Controls // for s

Window {
    id: root
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
                font.pixelSize: 14
                anchors.top: titleTxt.bottom
                clip: true
                wrapMode: TextInput.Wrap
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


            ListView {
                id: lv
                anchors.fill: parent
                clip: true
                model: listModel
                delegate: toDoDelegate
                spacing: 2

            }
        }
        Rectangle {
            id: addItems
            width: parent.width / 2
            height: parent.height - 20
            color: "lightblue"


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
