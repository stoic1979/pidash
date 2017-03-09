import QtQuick 2.7
import QtQuick.Window 2.2


//-------------------------------------------------------------
//
// Container page with loader to load qml pages dynamically
//
//-------------------------------------------------------------
Window {
    id: pageManager
    visible: true
    width: 800
    height: 480

    Loader {
        id: pageLoader
        anchors.fill: parent
    }

    Connections {
        target: pageLoader.item

        //------------------------------------------------+
        // slot for loading given page                    |
        // to be trigered via signals from various pages  |
        // to change to some other page                   |
        //------------------------------------------------+
        onLoadPage: {
            console.log("Loading page: " + page);
            pageLoader.source = page;
        }
    }

    Component.onCompleted: {
        // set default page to home page
        pageLoader.source = "Home.qml";
    }

}//pageManager
