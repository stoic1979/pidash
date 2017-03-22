#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtWebView/QtWebView>
#include <QQuickView>
#include <QQmlContext>
#include <QStringListModel>
#include <QCursor>

#include "qmlbridge.h"

#include "utils.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtWebView::initialize();

    QmlBridge qmlBridge;


    Utils utils;
    qDebug() << "Result: " << utils.getCmdResult("ls");


    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("qmlBridge", &qmlBridge);
    engine.load(QUrl(QStringLiteral("qrc:/PageManager.qml")));

    return app.exec();
}
