import QtQuick 2.6
import Industrial.Indicators 1.0

OperationalItem {
    id: root

    property string prefix
    property int digits: 0
    property real value: NaN
    property bool active: false
    property color color: {
        if (!enabled) return Theme.disabledColor;
        if (!operational) return Theme.dangerColor;
        if (active) return Theme.activeColor;
        return Theme.textColor;
    }

    property alias prefixFont: prefixText.font
    property alias valueFont: valueText.font

    implicitWidth: Math.max(prefixText.implicitWidth, valueText.implicitWidth)
    implicitHeight: (prefix.length > 0 ? prefixText.implicitHeight * 0.6 : 0) + valueText.implicitHeight

    Text {
        id: prefixText
        anchors.top: parent.top
        width: root.width
        horizontalAlignment: Text.AlignHCenter
        color: root.color
        font.pixelSize: Theme.fontSize
        visible: prefix.length > 0
        text: prefix
    }

    Text {
        id: valueText
        anchors.bottom: parent.bottom
        width: root.width
        horizontalAlignment: Text.AlignHCenter
        color: root.color
        font.bold: true
        font.pixelSize: Theme.fontSize
        text: isNaN(value) ? "-" : (digits > 0 ? value.toFixed(digits) : Math.floor(value))
    }
}

