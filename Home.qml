import QtQuick 2.7
import QtQuick.Window 2.2

Rectangle {

    id: root
    visible: true
    width: 800
    height: 480

    signal loadPage(string page)

    property int barHeight: 60

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

            width: topBar.width/5
            height: topBar.height
            color: topBar.color
            Text {
                anchors.centerIn: parent
                text: qsTr("My Device Name")
                color: "#ffffff"
                x: 10
                y: topBar.height/2
            }
        }

        Text {
            anchors.centerIn: parent
            text: qsTr("Home")
            color: "#ffffff"
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
            width: 80
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
        }

        Button {
            width: centerGrid.width/4
            height: centerGrid.height/2 -2
            imgSrc: "qrc:/imgs/images/users.png"
        }

        Button {
            width: centerGrid.width/4
            height: centerGrid.height/2 - 6
            imgSrc: "qrc:/imgs/images/calendar.png"
        }

        Button {
            width: centerGrid.width/4
            height: centerGrid.height/2 - 6
            imgSrc: "qrc:/imgs/images/photo-camera.png"
        }

        Button {
            width: centerGrid.width/4
            height: centerGrid.height/2 - 6
            imgSrc: "qrc:/imgs/images/stopwatch.png"
        }

        Button {
            width: centerGrid.width/4
            height: centerGrid.height/2 - 6
            imgSrc: "qrc:/imgs/images/file.png"
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

            width: bottomBar.width/4
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

