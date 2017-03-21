#include <QProcess>
#include "qmlbridge.h"
#include "wifimanager.h"
#include "utils.h"


QmlBridge::QmlBridge(QObject *parent) : QObject(parent), wifiCount(0)
{}


void QmlBridge::test() {
    qDebug() << "[QmlBridge] :: test";
}

bool QmlBridge::postMessage(const QString &msg) {
        qDebug() << "[QmlBridge] :: Called the C++ method with" << msg;
        return true;
}

QList<QObject*> QmlBridge::getWifiNetworks() {
        qDebug() << "[QmlBridge] :: getWifiNetworks";

        WifiManager wm;
        return wm.getWifiNetworks();
}

int QmlBridge::getWifisCount() {
    return wifiCount;
}

QString QmlBridge::getConectedWifiName() {
    Utils utils;
    return utils.getCmdResult("iwgetid -r");
}

void QmlBridge::connectToWifi(QString name, QString pass) {
    WifiManager wm;
    wm.connectToWifi(name, pass);
}
