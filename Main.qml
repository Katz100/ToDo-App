import QtQuick
import QtQuick.LocalStorage

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("ToDo")
    color: "lightgray"

    property var db: LocalStorage.openDatabaseSync("toDoDatabase", "1.0", "Hold todo items", 10000)
    property bool titlePresent: true


    ListModel {
        id: listModel
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
                delegate: ToDoDelegate {}
                spacing: 2

            }
        }
        Rectangle {
            id: addItems
            width: parent.width / 2
            height: parent.height - 20
            color: "lightblue"

            TextField {
                id: toDoTitle
                text: "Title"
                borderColor: titlePresent ? "black" : "red"
                focus: true
                characterLimit: 30
                width: parent.width - 20
                height: 30
                anchors {
                    left: parent.left
                    top: parent.top
                }

            }

            TextField {
                id: toDoDesc
                text: "Description"
                height: 50
                width: parent.width - 20
                characterLimit: 150
                anchors {
                    left: parent.left
                    top: toDoTitle.bottom
                    topMargin: 20
                }


            }


            Column {
                spacing: 20
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: parent.bottom
                    bottomMargin: 10
                }
                MyButton {
                    text: "Add item"
                    textColor: "white"
                    color: "#4CAF50"


                    onClicked: {
                        if (toDoTitle.text === ""){
                            titlePresent = false
                        } else {

                            listModel.append({"title": toDoTitle.text, "desc": toDoDesc.text})
                            toDoTitle.text = ""
                            toDoDesc.text = ""
                            titlePresent = true
                        }
                    }
                }

                MyButton {
                    text: "Delete All"
                    textColor: "white"
                    color: "#F44336"
                    onClicked: listModel.clear()

                }

            }
        }

    }

    Component.onCompleted: {

        db.transaction(
                    function(tx)
                    {
                        tx.executeSql('CREATE TABLE IF NOT EXISTS Todo (
                                        todo_index INTEGER PRIMARY KEY,
                                        title TEXT,
                                        description TEXT)');

                        var rs = tx.executeSql('SELECT title, description FROM Todo');
                        for (var i = 0; i < rs.rows.length; i++)
                        {
                            listModel.append({"title": rs.rows.item(i).title, "desc": rs.rows.item(i).description})
                        }

                    }

                    )
    }


    Component.onDestruction: {
        db.transaction(
                    function(tx)
                    {
                        tx.executeSql('DELETE FROM Todo');

                        for (var i = 0; i < listModel.count; i++)
                        {
                            var item = listModel.get(i);
                            tx.executeSql('INSERT INTO Todo (todo_index, title, description)
                                           VALUES (?, ?, ?)', [i, item.title, item.desc]);
                        }
                    }

                    )
    }





}
