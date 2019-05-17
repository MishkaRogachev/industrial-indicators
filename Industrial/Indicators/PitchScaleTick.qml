import QtQuick 2.6
import Industrial.Controls 1.0 as Controls

Item {
    id: root

    property real value: 0
    property int digits: 0
    property bool major: true
    property color color: Theme.textColor

    Rectangle {
        id: tick
        anchors.centerIn: parent
        color: root.color
        width: major ? tickMajorSize : tickMinorSize
        height: major ? tickMajorWeight : tickMinorWeight
        antialiasing: true
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: tick.right
        anchors.margins: textOffset
        visible: major
        text: digits > 0 ? value.toFixed(digits) : Math.floor(value)
        font.pixelSize: fontSize
        color: root.color
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: tick.left
        anchors.margins: textOffset
        visible: major
        text: digits > 0 ? value.toFixed(digits) : Math.floor(value)
        font.pixelSize: fontSize
        color: root.color
    }
}
