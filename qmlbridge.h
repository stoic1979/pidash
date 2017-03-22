#ifndef QMLBRIDGE_H
#define QMLBRIDGE_H

#include <QQuickItem>
#include <QDebug>

#include <QStringListModel>


class QmlBridge : public QObject
{
    Q_OBJECT
public:
    explicit QmlBridge(QObject *parent = 0);

    Q_INVOKABLE void test();

    Q_INVOKABLE bool postMessage(const QString &msg);

    Q_INVOKABLE QList<QObject*> getWifiNetworks();
    Q_INVOKABLE int getWifisCount();

    Q_INVOKABLE QString getConectedWifiName();

    Q_INVOKABLE void connectToWifi(QString name, QString pass);

    Q_INVOKABLE QString getDeivceName();

signals:

public slots:
    void cppSlot(const QVariant &v) {
        qDebug() << "Called the C++ slot with value:" << v;

        QQuickItem *item =
                qobject_cast<QQuickItem*>(v.value<QObject*>());
        qDebug() << "Item dimensions:" << item->width()
                 << item->height();
    }

private:
    int wifiCount;
    QStringListModel model;
    QStringList list;

};

#endif // QMLBRIDGE_H
