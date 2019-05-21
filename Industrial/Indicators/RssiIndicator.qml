import QtQuick 2.6
import Industrial.Indicators 1.0

import "../Controls/helper.js" as Helper

Item {
    id: root

    property bool mirrored: false
    property int columns: 5
    property real columnToSpaceFactor: 20
    property real rssi: minRssiValue
    property real minRssiValue: -120

    implicitWidth: industrial.baseSize * 3
    implicitHeight: industrial.baseSize

    Row {
        id: row
        spacing: root.width / columnToSpaceFactor
        layoutDirection: mirrored ? Qt.LeftToRight : Qt.RightToLeft
        anchors.fill: parent

        Repeater {
            id: repeater
            model: columns

            Rectangle {
                anchors.bottom: parent.bottom
                width: (root.width / columns) - (root.width / columnToSpaceFactor)
                height: (repeater.count - index) * root.height / (repeater.count + 1)
                radius: 2
                color: rssi != 0 && rssi >= Helper.mapToRange(index, 0, columns, minRssiValue) ?
                           Theme.positiveColor : Theme.backgroundColor
            }
        }
    }
}

