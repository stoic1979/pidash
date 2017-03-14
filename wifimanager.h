#ifndef WIFIMANAGER_H
#define WIFIMANAGER_H

#include <QObject>

class WifiManager : public QObject
{
    Q_OBJECT
public:
    explicit WifiManager(QObject *parent = 0);

    QList<QObject*> getWifiNetworks();
    void connectToWifi(QString name, QString pass);

signals:

public slots:



private:
    QList<QObject*> dataList;
};

#endif // WIFIMANAGER_H
