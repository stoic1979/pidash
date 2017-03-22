import QtQuick 2.7
import QtQuick.Window 2.2


Rectangle {

    id: root
    visible: true
    width: 800
    height: 480

    property int barHeight: 60

    signal connectToWifi(string wifiName);

    // tell loader to change a page
    // eg. load/go-back to home page
    signal loadPage(string page)

    property string curWifiName


    function refreshWifiList() {
        console.log("-- refreshWifiList --");

        lstWifis.visible = false;
        rectLoading.visible = true;

        lstWifis.model = qmlBridge.getWifiNetworks();

        rectLoading.visible = false;
        lstWifis.visible = true;

        console.log("-- refreshWifiList done --");

    }

    function decideWifiImageSrc(strength) {
        console.log("-- decideWifiImageSrc: " + strength);

        if(strength <= -90) return "qrc:/imgs/images/wifi0.png";
        if(strength <= -80) return "qrc:/imgs/images/wifi1.png";
        if(strength <= -70) return "qrc:/imgs/images/wifi2.png";
        if(strength <= -67) return "qrc:/imgs/images/wifi3.png";
        if(strength <= -30) return "qrc:/imgs/images/wifi4.png";
    }

    onConnectToWifi: {
        console.log("onConnectToWifi() wifiName: " + wifiName);

        curWifiName = wifiName;
        t1.start();
    }

    Timer {
        id: t1
        interval: 2000
        repeat: false
        running: false
        triggeredOnStart: false
        onTriggered: {

            console.log("--- curWifiName:" + curWifiName)
            lblConnectedWifi.txt = "Connected To: " + curWifiName;
        }
    }


    //------------------------------------------------------------
    //                TOP BAR
    //------------------------------------------------------------
    Rectangle {
        id: topBar
        width: parent.width
        height: barHeight
        //color: "#dddddd"
        color: "#000000"
        z: 1000

        Component.onCompleted: {
            console.log("--- wifi config loaded ---");
            timer.running = true;
        }

        Timer {
            id: timer
            interval: 1000
            repeat: false
            running: false
            triggeredOnStart: false
            onTriggered: refreshWifiList();
        }

        Text {
            anchors.centerIn: parent
            text: qsTr("Wifi Settings")
            color: "#000000"
        }

        Button {
            id: homeButton
            width: 50
            height: 50
            imgSrc: "qrc:/imgs/images/home-small.png"
            x: 6
            y: 6
            color: parent.color
            onClicked: {
                root.loadPage("Home.qml");
            }
        }

        /*Button {
            id: refreshButton
            width: 50
            height: 50
            imgSrc: "qrc:/imgs/images/refresh.png"
            x: topBar.width - width - 6
            y: 6
            color: parent.color
            onClicked: {
                console.log("refreshing list of wifi nws");
                refreshWifiList();
            }
        }*/

    }//topBar

    //------------------------------------------------------------
    //                LIST VIEW
    //------------------------------------------------------------
    Rectangle {
        id: centerRect
        anchors.top: topBar.bottom
        height: parent.height - topBar.height - bottomBar.height
        width: parent.width - 2 * barHeight
        x: barHeight

        ListView{
            id: lstWifis
            x: 8
            visible: true
            spacing: 4

            anchors.fill: centerRect

            delegate: Rectangle{

                id: listItem
                radius: 4

                property int expanded: 0
                property int minHeight: 70
                property int maxHeight: 115
                property bool isExpanded: false

                property color btnColor: "#444444"

                height: minHeight
                width: centerRect.width - 8

                color: "#ffffff"

                onHeightChanged: {
                    if ( height == minHeight) {
                        connectRect.visible = false
                        isExpanded = false;
                    }
                }

                onIsExpandedChanged: {
                    if(isExpanded) {
                        listItem.height = maxHeight;
                        connectRect.visible = true;
                        titleBtn.collapseImgSrc = "qrc:/imgs/images/up-white.png";
                        listItem.border.color = "blue"
                        return;
                    }

                    if(!isExpanded) {
                        listItem.height = minHeight;
                        connectRect.visible = false;
                        titleBtn.collapseImgSrc = "qrc:/imgs/images/down-white.png";
                        listItem.border.color = "#000000"
                    }
                }

                WifiButton {
                    id: titleBtn
                    width: listItem.width -20
                    x: 10
                    height: 60
                    wifiTite: modelData.getName()
                    color: btnColor
                    textColor: "white"
                    y: 5

                    imgSrc: decideWifiImageSrc(modelData.getStrength());

                    onClicked: {

                        // if its already expanded, just collapse it
                        if(listItem.isExpanded) {

                            listItem.isExpanded = false;
                            return;
                        }

                        // collapse all, if any is expanded
                        for (var i = 0; i <   lstWifis.count; i ++) {
                            lstWifis.contentItem.children[i].height = minHeight;
                        }

                        // now expand this element

                        listItem.isExpanded = true;
                    }
                }
                //----------------------------------------------------------------------
                // Dynamic/collapsible connect rect with textfield for password
                // and connect button
                //----------------------------------------------------------------------
                Rectangle{
                    id: connectRect
                    width: listItem.width -20
                    height: 40
                    x:10
                    anchors.top: titleBtn.bottom
                    anchors.topMargin: 5
                    visible: false

                    Text {
                        id: lblPass
                        color: "#000000"
                        text: "Password: "
                        width: 70
                        y: rectPass.height/3
                    }

                    Rectangle {
                        id: rectPass

                        anchors.left: lblPass.right

                        border.color: "black"
                        radius: 4
                        width: 270
                        height: 40

                        TextInput {
                            x: 8
                            y: rectPass.height/3
                            id: txtPass
                            width: 240
                            height: 40
                            readOnly: false
                            color: "#000000"
                            echoMode: TextInput.Password
                            cursorVisible: true
                        }
                    }

                    Checkbox {
                        id: cbShowPass
                        width: 120
                        height: 24
                        anchors.left: rectPass.right
                        anchors.leftMargin: 10
                        text: "Show Password"

                        y: rectPass.height/3

                        onCheckedChanged: {
                            if(checked) {
                                txtPass.echoMode = TextInput.Normal
                            } else {
                                txtPass.echoMode = TextInput.Password
                            }
                        }

                    }

                    Button {
                        id: btnConnect
                        text: "Connect"
                        anchors.left: cbShowPass.right
                        anchors.leftMargin: 10
                        width: 90
                        height: 40

                        color: btnColor
                        textColor: "white"

                        onClicked: {
                            console.log("Connecting " + modelData);
                            listItem.isExpanded = false;
                            //---------------------------------------------------------------//
                            //qmlBridge.connectToWifi(modelData, txtPass.text)

                            connectToWifi(modelData.getName());
                        }
                    }//btnConnect

                    Button {
                        id: btnCancel
                        text: "Cancel"
                        anchors.left: btnConnect.right
                        anchors.leftMargin: 10
                        width: 70
                        height: 40

                        color: btnColor
                        textColor: "white"

                        onClicked: {
                            console.log("Cancelling " + modelData);
                            listItem.isExpanded = false;
                        }
                    }//btnConnect
                }

                border.color: "black"
            }

            //model: qmlBridge.getWifiNetworks()
        }//listview

        //----------------------------------------------------------------------
        // Network Loading Rectangle
        //----------------------------------------------------------------------
        Rectangle {
            id: rectLoading
            anchors.centerIn: centerRect
            width: centerRect.width - 20
            height: centerRect.height - 40
            border.color: "#000000"
            color: "blue"
            radius: 8
            z: 1000

            Text {
                anchors.centerIn: parent
                text: "Getting networks list, please wait..."
                color: "#ffffff"
                font.pixelSize: 15
            }

        }

    }//centerRect

    //------------------------------------------------------------
    //                BOTTOM BAR
    //------------------------------------------------------------
    Rectangle {
        id: bottomBar
        anchors.top: centerRect.bottom
        width: parent.width
        height: barHeight
        //color: "#1E323D"
        color: "#000000"

        Rectangle {

            id: lblConnectedWifi
            width: bottomBar.width/4
            height: bottomBar.height
            color: bottomBar.color
            property alias txt: wTxt.text

            Text {
                id: wTxt
                anchors.centerIn: parent
                text: qsTr("Connected To: " + qmlBridge.getConectedWifiName());
                color: "#ffffff"
            }
        }
    }//bottomBar

}//root

