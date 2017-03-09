import QtQuick 2.7
import QtQuick.Window 2.2
import QtWebView 1.1

Rectangle {

    id: root
    visible: true
    width: 800
    height: 480

    signal loadPage(string page)

    property int barHeight: 60

    Rectangle {
        id: topBar
        width: parent.width
        height: barHeight
        color: "#000000"

        Text {
            anchors.centerIn: parent
            text: qsTr("Dashboard")
            color: "#ffffff"
        }

        Button {
            id: homeButton
            width: 50
            height: 50
            imgSrc: "qrc:/imgs/images/home-small.png"
            //anchors.verticalCenter: parent
            x: 6
            y: 6
            color: parent.color
            onClicked: {
                root.loadPage("Home.qml");
            }
        }

    }//topBar

    WebView {
        id: webView
        anchors.top: topBar.bottom
        height: parent.height - topBar.height - bottomBar.height
        width: parent.width
        url: "https://freeboard.io/board/G6qZxn"
    }

    //------------------------------------------------------------
    //                BOTTOM BAR
    //------------------------------------------------------------
    Rectangle {
        id: bottomBar
        anchors.top: webView.bottom
        width: parent.width
        height: barHeight
        color: "#000000"
    }//bottomBar

}
