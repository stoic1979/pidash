#include <QProcess>
#include "qmlbridge.h"
#include "wifimanager.h"


QmlBridge::QmlBridge(QObject *parent) : QObject(parent), wifiCount(0)
{}


void QmlBridge::test() {
    qDebug() << "[QmlBridge] :: test";
}

bool QmlBridge::postMessage(const QString &msg) {
        qDebug() << "[QmlBridge] :: Called the C++ method with" << msg;
        return true;
}

QStringList QmlBridge::getWifiNetworks() {
        qDebug() << "[QmlBridge] :: getWifiNetworks";

        /*list.clear();

        list << "Wifi 1" << "Wifi 2" << "Wifi 3" << "Wifi 4" << "Wifi 5" ;





        QProcess p;
        //p.start("iwlist wlan0 scan | grep ESSID");
        p.start("sudo iwlist wlx00018edc151e scan");
        p.waitForFinished(-1);

        QString p_stdout = p.readAllStandardOutput();
        QString p_stderr = p.readAllStandardError();

       // qDebug() << "stdout" << p_stdout;

QStringList sl = p_stdout.split("\n");
for (int i = 0; i < sl.size(); ++i) {
        QString itm = sl.at(i).toLocal8Bit().constData();

        if(itm.contains("ESSID")) {
            qDebug() << itm ;
        }
}
        qDebug() << "p_stderr" << p_stderr;
        */

        WifiManager wm;

        return wm.getWifiNetworks();
}


int QmlBridge::getWifisCount() {
    return wifiCount;
}

QString QmlBridge::getConectedWifiName() {
    return "WIFI-99";
}

void QmlBridge::connectToWifi(QString name, QString pass) {
    WifiManager wm;
    wm.connectToWifi(name, pass);
}


//iwlist wlan0 scan | grep ESSID
