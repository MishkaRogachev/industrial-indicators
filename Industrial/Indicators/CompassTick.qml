import QtQuick 2.6
import Industrial.Controls 1.0 as Controls

Item {
    id: root

    property real value: 0
    property bool major: false
    property bool texted: false

    rotation: value

    Text {
        id: label
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        height: textOffset
        rotation: heading - value
        visible: texted
        text: {
            if (value == 0) return qsTr("N");
            else if (value == 90) return qsTr("E");
            else if (value == 180) return qsTr("S");
            else if (value == 270) return qsTr("W");
            else return Math.floor(value / 10);
        }
        font.pixelSize: fontSize
        font.bold: value % 90 == 0
        color: headingColor
    }

    Rectangle {
        id: tick
        anchors.bottom: label.bottom
        anchors.bottomMargin: -tickTextedSize
        anchors.horizontalCenter: parent.horizontalCenter
        width: texted ? tickTextedWeight : major ? tickMajorWeight : tickMinorWeight
        height: texted ? tickTextedSize : major ? tickMajorSize : tickMinorSize
        color: headingColor
        antialiasing: true
    }
}
