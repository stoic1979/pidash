#include "wifiinfo.h"

WifiInfo::WifiInfo(QString name, int strength, QObject *parent):
    name(name),
    strength(strength),
    QObject(parent)
{}


QString WifiInfo::getName() {
    return name;
}

int WifiInfo::getStrength() {
    return strength;
}

void WifiInfo::setName(QString n) {
    name = n;
}

void WifiInfo::setStrength(int s) {
    strength = s;
}
