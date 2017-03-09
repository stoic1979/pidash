#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtWebView/QtWebView>
#include <QQuickView>
#include <QQmlContext>
#include <QStringListModel>

#include "qmlbridge.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtWebView::initialize();

    QmlBridge qmlBridge;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("qmlBridge", &qmlBridge);
    engine.load(QUrl(QStringLiteral("qrc:/PageManager.qml")));

    return app.exec();
}
