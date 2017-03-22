import QtQuick 2.7
import QtQuick.Window 2.2

Rectangle {

    id: root
    visible: true
    width: 800
    height: 480

    signal loadPage(string page)

    property int barHeight: 60

    function showPlaceholderPopup() {
        rectPlacehoder.visible = true;
        timerPlaceholder.start();

    }

    //------------------------------------------------------------
    //                TOP BAR
    //------------------------------------------------------------
    Rectangle {
        id: topBar
        width: parent.width
        height: barHeight
        //color: "#1E323D"
        color: "#000000"

        Rectangle {

            width: topBar.width/2
            height: topBar.height
            color: topBar.color
            x: 20
            Text {
                anchors.centerIn: parent
                text: qsTr("My Device Name: " + qmlBridge.getDeivceName());
                color: "#ffffff"
                x: 60
                y: topBar.height + 20
            }
        }


        NotifyButton {
            id: btnNotify
            imgSrc: "qrc:/imgs/images/bell-gray.png"
            height: topBar.height - 8
            y: 4
            width: 100
            x: root.width * 6/10
            count: 90

        }

        Rectangle {

            id: wifiRect
            height: topBar.height
            width: 60
            anchors.left: btnNotify.right
            color: topBar.color
            Image {
                id: wifiIcon
                source: "qrc:/imgs/images/wifi4.png"
                anchors.centerIn: parent

            }
        }

        TimeRect {
            textColor: "#ffffff"
            height: topBar.height
            width: 100
            anchors.left: wifiRect.right
            color: topBar.color
        }


    }//topBar

    //------------------------------------------------------------
    //                LEFT BUTTON
    //------------------------------------------------------------
    Button {
        id: leftButton
        width: barHeight - 4
        height: parent.height - topBar.height - bottomBar.height
        anchors.top: topBar.bottom
        imgSrc: "qrc:/imgs/images/left-arrow-gray.png"
        color: "#ffffff"
        imgWidth: 48
        imgHeight: 48

        onClicked: {
            console.log("Left button clicked");
            qmlBridge.test();
            qmlBridge.postMessage("hello from qml")

            console.log("wifis: " + qmlBridge.getWifiNetworks());
            var wifis = qmlBridge.getWifiNetworks();
            console.log(qmlBridge.getWifisCount());

            for(var i=0; i<qmlBridge.getWifisCount(); i++) {
                console.log("wifi: " + wifis[i]);
            }

        }
    }//leftButton

    Grid {
        id: centerGrid

        anchors.top: topBar.bottom
        anchors.topMargin: 4

        columns: 4
        spacing: 4
        height: parent.height - topBar.height - bottomBar.height
        width: parent.width - 2 * barHeight
        x: barHeight - 4

        Button {
            width: centerGrid.width/4
            height: centerGrid.height/2 -2
            imgSrc: "qrc:/imgs/images/web.png"

            onClicked: {
                root.loadPage("WebDashboard.qml");
            }
        }

        Button {
            width: centerGrid.width/4
            height: centerGrid.height/2 -2
            imgSrc: "qrc:/imgs/images/settings.png"

            onClicked: {
                root.loadPage("WifiConfig.qml");
            }
        }

        Button {
            width: centerGrid.width/4
            height: centerGrid.height/2 -2
            imgSrc: "qrc:/imgs/images/placeholder.png"
            onClicked: showPlaceholderPopup();
        }

        Button {
            width: centerGrid.width/4
            height: centerGrid.height/2 -2
            imgSrc: "qrc:/imgs/images/users.png"
            onClicked: showPlaceholderPopup();
        }

        Button {
            width: centerGrid.width/4
            height: centerGrid.height/2 - 6
            imgSrc: "qrc:/imgs/images/calendar.png"
            onClicked: showPlaceholderPopup();
        }

        Button {
            width: centerGrid.width/4
            height: centerGrid.height/2 - 6
            imgSrc: "qrc:/imgs/images/photo-camera.png"
            onClicked: showPlaceholderPopup();
        }

        Button {
            width: centerGrid.width/4
            height: centerGrid.height/2 - 6
            imgSrc: "qrc:/imgs/images/stopwatch.png"
            onClicked: showPlaceholderPopup();
        }

        Button {
            width: centerGrid.width/4
            height: centerGrid.height/2 - 6
            imgSrc: "qrc:/imgs/images/file.png"
            onClicked: showPlaceholderPopup();
        }

    }//centerGrid

    //------------------------------------------------------------
    //                RIGHT BUTTON
    //------------------------------------------------------------

    Button {
        id: rightButton

        width: barHeight - 8
        height: parent.height - topBar.height - bottomBar.height

        anchors.top: topBar.bottom
        anchors.left: centerGrid.right
        anchors.leftMargin: 8

        imgWidth: 48
        imgHeight: 48

        imgSrc: "qrc:/imgs/images/right-arrow-gray.png"
        color: "#ffffff"

        onClicked: {
            console.log("Right button clicked");
        }
    }//right

    Timer {
        id: timerPlaceholder
        interval: 2000
        repeat: false
        running: false
        triggeredOnStart: false
        onTriggered: {
           rectPlacehoder.visible = false;
        }
    }

    //----------------------------------------------------------------------
    // Network Loading Rectangle
    //----------------------------------------------------------------------
    Rectangle {
        id: rectPlacehoder
        anchors.centerIn: centerGrid
        width: centerGrid.width/2 + 80
        height: centerGrid.height/2 + 40
        border.color: "#000000"
        color: "blue"
        radius: 8
        z: 1000
        visible: false

        Text {
            anchors.centerIn: parent
            text: "Place holder, to be done..."
            color: "#ffffff"
            font.pixelSize: 15
        }

    }

    //------------------------------------------------------------
    //                BOTTOM BAR
    //------------------------------------------------------------
    Rectangle {
        id: bottomBar
        anchors.top: centerGrid.bottom
        width: parent.width
        height: barHeight
        //color: "#1E323D"
        color: "#000000"

        Rectangle {

            width: bottomBar.width/2
            height: bottomBar.height
            color: bottomBar.color
            Text {
                anchors.centerIn: parent
                text: qsTr("Connected To: " + qmlBridge.getConectedWifiName());
                color: "#ffffff"
            }
        }
    }//bottomBar

}//root

