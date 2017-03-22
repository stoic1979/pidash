#include "wifimanager.h"

#include "wifi/wifi_scan.h"
#include "wifi/wifiinfo.h"

#include <stdio.h>

#include <QDebug>

#if 0
//convert bssid to printable hardware mac address
const char *bssid_to_string(const uint8_t bssid[BSSID_LENGTH], char bssid_string[BSSID_STRING_LENGTH]) {
    snprintf(bssid_string, BSSID_STRING_LENGTH, "%02x:%02x:%02x:%02x:%02x:%02x",
             bssid[0], bssid[1], bssid[2], bssid[3], bssid[4], bssid[5]);
    return bssid_string;
}

static const int BSS_INFOS=10; //the maximum amounts of APs (Access Points) we want to store



QList<QObject*> WifiManager::getWifiNetworks() {

    dataList.clear();

    struct wifi_scan *wifi=NULL;    //this stores all the library information
    struct bss_info bss[BSS_INFOS]; //this is where we are going to keep informatoin about APs (Access Points)
    char mac[BSSID_STRING_LENGTH];  //a placeholder where we convert BSSID to printable hardware mac address
    int status, i;

    printf("Scanning wifi networks...\n");

    // initialize the library with network interface argv[1] (e.g. wlan0)
    //wifi=wifi_scan_init("wlp3s0");

    wifi=wifi_scan_init("wlx00018edc151e");

    status=wifi_scan_all(wifi, bss, BSS_INFOS);

    //it may happen that device is unreachable (e.g. the device works in such way that it doesn't respond while scanning)
    //you may test for errno==EBUSY here and make a retry after a while, this is how my hardware works for example
    if(status<0) {
        perror("Unable to get scan data");
    }
    else {
        // wifi_scan_all returns the number of found stations,
        // it may be greater than BSS_INFOS that's why we test for both in the loop
        for(i=0;i<status && i<BSS_INFOS;++i) {                                                                              
            printf("%s %s signal %d dBm seen %d ms ago status %s\n", bssid_to_string(bss[i].bssid, mac), bss[i].ssid,  bss[i].signal_mbm/100, bss[i].seen_ms_ago, (bss[i].status==BSS_ASSOCIATED ? "associated" : ""));

            dataList.append(new WifiInfo(bss[i].ssid, bss[i].signal_mbm/100));

        }
    }
    printf("\n");

    //free the library resources
    wifi_scan_close(wifi);

    return dataList;
}
#endif

WifiManager::WifiManager(QObject *parent) : QObject(parent){}

QList<QObject*> WifiManager::getWifiNetworks() {

    dataList.clear();

    //QString str = "AIRTEL_E5172_B709:-53+Airtel-B310-0572:-40+JioFi2_9F03C0:-71+JioFi2_A885EA:-65";

    QString str = "AIRTEL_E5172_B709:-53+JioFi2_9F03C0:-71+Airtel-B310-0572:-40";

    QStringList cells = str.split("+");
    for(int i=0; i< cells.length(); i++) {
        QString cell = cells.at(i);

        QStringList items = cell.split(":");

        QString SSID = items.at(0);
        int Strength = items.at(1).toInt();

        qDebug () << "SSID: " << SSID;
        qDebug () << "Strength: " << Strength;

        dataList.append(new WifiInfo(SSID, Strength));
    }




    return dataList;
}

void WifiManager::connectToWifi(QString name, QString pass) {
    qDebug () << "[WifiManager] Connecting to " << name << " : " << pass;
}
