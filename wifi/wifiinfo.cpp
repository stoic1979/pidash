#include "wifiinfo.h"

WifiInfo::WifiInfo(QString name, int strength, QObject *parent):
    name(name),
    strength(strength),
    QObject(parent)
{

}
