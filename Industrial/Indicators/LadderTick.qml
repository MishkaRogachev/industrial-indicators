import QtQuick 2.6
import Industrial.Controls 1.0 as Controls

Item {
    id: root

    property real value: 0
    property int digits: 0
    property bool mirrored: false
    property bool major: true

    property alias tickWidth: tick.width
    property alias tickSize: tick.height
    property alias tickColor: tick.color

    property alias fontSize: label.font.pixelSize
    property alias labelColor: label.color

    Rectangle {
        id: tick
        anchors.left: mirrored ? parent.left : undefined
        anchors.right: mirrored ? undefined : parent.right
        anchors.verticalCenter: parent.verticalCenter
        width: major ? fontSize * 0.8 : fontSize * 0.6
        height: major ? 2 : 1
        color: Theme.textColor
    }

    Text {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: mirrored ? parent.right : tick.left
        anchors.right: mirrored ? tick.right : parent.left
        visible: major
        horizontalAlignment: Text.AlignHCenter
        color: tickColor
        font.pixelSize: Theme.fontSize
        text: isNaN(value) ? "-" : (digits > 0 ? value.toFixed(digits) : Math.floor(value))
    }
}
