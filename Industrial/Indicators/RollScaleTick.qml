import QtQuick 2.6
import Industrial.Controls 1.0 as Controls

Item {
    id: root

    property alias color: tick.color

    Rectangle {
        id: tick
        anchors.centerIn: parent
        anchors.verticalCenterOffset: (height - root.height + 1) / 2
        color: Theme.textColor
        width: tickWeight
        height: tickSize
        antialiasing: true
    }
}
