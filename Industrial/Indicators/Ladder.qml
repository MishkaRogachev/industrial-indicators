import QtQuick 2.6
import Industrial.Controls 1.0 as Controls

OperationalItem {
    id: root

    property real value: 50
    property real error: 0
    property bool errorVisible: false
    property real warningValue: minValue
    property real minValue: 0
    property real maxValue: 100
    property real valueStep: 10

    property bool mirrored: false

    property real scaleFontSize: Theme.fontSize
    property real labelFontSize: scaleFontSize * 1.5
    property real tickMinorSize: scaleFontSize * 0.4
    property real tickMajorSize: scaleFontSize * 0.6
    property real textOffset: scaleFontSize * 0.8
    property real tickMajorWeight: 2
    property real tickMinorWeight: 1

    property string prefix
    property string suffix

    property color scaleColor: operational ? Theme.textColor : Theme.dangerColor
    property color labelColor: operational ? Theme.textColor : Theme.dangerColor
    property color hatchColor: Theme.dangerColor

    function mapToRange(val) {
        return Controls.Helper.mapToRange(val, minValue, maxValue, height);
    }

    function mapFromRange(pos) {
        return Controls.Helper.mapFromRange(pos, minValue, maxValue, height);
    }

    implicitWidth: label.implicitWidth + tickMajorSize * 2
    clip: true

    Controls.Hatch {
        id: hatch
        anchors.left: parent.left
        anchors.leftMargin: mirrored ? 10 : 0
        anchors.right: parent.right
        anchors.rightMargin: mirrored ? 0 : 10
        anchors.bottom: parent.bottom
        height: mapToRange(warningValue)
        color: hatchColor
        z: -1
    }

    Rectangle {
        id: line
        anchors.left: mirrored ? parent.left : undefined
        anchors.right: mirrored ? undefined : parent.right
        width: tickMinorWeight
        height: parent.height
        gradient:  Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 0.5; color: scaleColor }
            GradientStop { position: 1.0; color: "transparent" }
        }
    }

    Repeater {
        id: repeater
        model: {
            var vals = [];
            for (var val = minValue - (minValue % valueStep); val <= maxValue;
                 val += (valueStep / 2)) {
                vals.push(val);
            }
            return vals;
        }

        LadderTick {
            anchors.left: mirrored ? line.right : parent.left
            anchors.right: mirrored ? parent.right : line.left
            y: root.height - mapToRange(value)
            visible: y < label.y || y > label.y + label.height
            value: modelData
            major: index % 2 == 0
            mirrored: root.mirrored
            opacity: Math.sin(y / root.height * Math.PI)
        }
    }

    LadderTick {
        width: root.width
        y: root.height - mapToRange(value)
        visible: errorVisible
        value: root.value + error
        major: y < label.y || y > label.y + label.height
        mirrored: root.mirrored
        color: Theme.activeColor
    }

    Controls.ColoredIcon {
        anchors.right: mirrored ? undefined : root.right
        anchors.left: mirrored ? root.left : undefined
        y: label.y
        width: tickMajorSize
        height: label.height
        mirror: root.mirrored
        source: "qrc:/icons/ind_ladder_arrow.svg"
        color: labelColor
    }

    ValueLabel {
        id: label
        y: root.height - mapToRange(value) - height / 2
        anchors.left: mirrored ? parent.left : undefined
        anchors.right: mirrored ? undefined : parent.right
        anchors.margins: tickMajorSize
        width: parent.width - tickMajorSize
        value: root.value
        operational: root.operational
        prefix: root.prefix
        valueFont.pixelSize: labelFontSize
        prefixFont.pixelSize: scaleFontSize
        color: labelColor
    }
}
