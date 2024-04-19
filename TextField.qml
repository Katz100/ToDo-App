import QtQuick

FocusScope {
    id: root
    property alias text: txt.text
    required property int characterLimit
    property alias borderColor: box.border.color

    Rectangle {
        id: box
        color: "white"
        border.width: 1
        anchors.fill: parent
        TextInput {
            id: txt
            x: 2
            width: parent.width - 5
            height: parent.height
            clip: true
            activeFocusOnTab: true
            color: activeFocus ? "black" : "gray"
            wrapMode: TextInput.Wrap
            onTextChanged: if (length > characterLimit) remove (characterLimit, length)

        }
    }
    Text {
        text: txt.length + "/" + characterLimit
        font.pointSize: 9
        color: "black"
        anchors {
            top: box.bottom
            right: parent.right
        }
    }
}
