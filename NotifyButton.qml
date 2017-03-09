import QtQuick 2.0

Rectangle {
    id: button

    signal clicked
    property alias imgSrc: img.source

    property int count

    color: "white"
    radius: 4

    border.color: "#999999"

    Rectangle {
        id: rectLeft
        width: button.width/2 - 4
        height: button.height - 4
        x: 2
        y: 2

        Image {
            id: img
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: rectRight
        width: button.width/2 - 4
        height: button.height - 4
        anchors.left: rectLeft.right
        y:2

        Text {
            id: txt
            text: "" + count
            anchors.centerIn: parent
        }
    }


    MouseArea {
        id: mouseArea
        enabled: button.enabled
        anchors.fill: button
        hoverEnabled: true

        onClicked: button.clicked()

        onPressed: {
            button.opacity = 0.5
        }

        onReleased: {
            button.opacity = 1.0
        }

    }

}//Rectangle
