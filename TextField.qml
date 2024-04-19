import QtQuick

FocusScope {
    id: root
    property alias text: txt.text
    required property int characterLimit


    Rectangle {
        id: box
        color: "white"
        border.color: "black"
        border.width: 1
        anchors.fill: parent
        TextInput {
            id: txt
            x: 2
            width: parent.width - 5
            height: parent.height
            clip: true
            focus: true
            activeFocusOnTab: true
            color: focus ? "black" : "gray"
            wrapMode: TextInput.Wrap
            onTextChanged: if (length > characterLimit) remove (characterLimit, length)

        }
    }
}
