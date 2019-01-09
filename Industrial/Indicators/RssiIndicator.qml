import QtQuick 2.6

import Industrial.Controls 1.0 as Controls
import "../Controls/helper.js" as Helper

Item {
    id: root

    property real rssi: minRssiValue
    property real minRssiValue: -120

    implicitWidth: industrial.baseSize
    implicitHeight: width

    Row {
        id: row
        spacing: root.width / 20
        layoutDirection: Qt.RightToLeft
        anchors.centerIn: parent

        Repeater {
            id: repeater
            model: 5

            Rectangle {
                anchors.bottom: parent.bottom
                width: root.width / repeater.count - row.spacing
                height: (repeater.count - index) * root.height / (repeater.count + 1)
                radius: 2
                color: rssi != 0 && rssi >= Helper.mapToRange(index, 0, 5, minRssiValue) ?
                           industrial.colors.highlight : industrial.colors.background
            }
        }
    }
}

