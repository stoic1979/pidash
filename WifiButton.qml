import QtQuick 2.0

Rectangle {
    id: wifiButton
    signal clicked

    radius: 4
    border.color: "#cccccc"


    property alias wifiTite: txt.text
    property alias textColor: txt.color
    textColor: "white"

    property alias collapseImgSrc: collapseImg.source

    property alias imgSrc: img.source

    y: 5

    //---------------------------------------------------------------
    // put it before all other controls below
    // so that they appear on top of it with higher z index
    //---------------------------------------------------------------
    Button {
        color: parent.color
        anchors.centerIn: wifiButton
        anchors.fill: wifiButton
        onClicked: wifiButton.clicked()
    }


    Image {
        id: img
        source: "qrc:/imgs/images/wifi4.png"
        x: 6
        y: 6
        width: 48
        height: 48
    }

    Text {
        id: txt
        anchors.centerIn: wifiButton
    }

    Image {
        id: collapseImg
        source: "qrc:/imgs/images/down-white.png"
        x: wifiButton.width - width - 14
        y: 16
        width: 40
        height: 24
    }


}//wifiButton
