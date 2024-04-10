import QtQuick

Item {
    id: root
    property alias text: txt.text
    property color color: "gray"
    property alias textColor: txt.color
    signal clicked()
    implicitHeight: txt.implicitHeight
    implicitWidth: txt.implicitWidth + 10

    Rectangle {

        id: button
        radius: 30
        anchors.fill: parent
        color: if (mouseArea.containsPress)
               {
                   return Qt.lighter(root.color)
               }
        else if (mouseArea.containsMouse)
               {
                   return Qt.darker(root.color)
               }
               else{
                   return root.color
               }
    }
    Text {
        id: txt
        anchors.centerIn: parent
        font.pointSize: 18
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            root.clicked()
        }
    }
}
