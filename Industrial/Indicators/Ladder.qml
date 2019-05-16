import QtQuick 2.6
import Industrial.Controls 1.0 as Controls

import "../Controls/helper.js" as Helper

OperationalItem {
    id: root

    property real value: 0
    property real error: 0
    property bool errorVisible: false
    property real warningValue: minValue
    property real minValue: 0
    property real maxValue: 100
    property real valueStep: 20

    property alias fontScaleSize: label.prefixFont.pixelSize
    property real minorTickSize: fontScaleSize * 0.4
    property real majorTickSize: fontScaleSize * 0.6
    property real textOrigin: fontScaleSize * 0.8
    property bool mirrored: false

    property string prefix
    property string suffix
    property color color: operational ? Theme.textColor : Theme.dangerColor
    property alias warningColor: hatch.color

    function mapToRange(val) {
        return Helper.mapToRange(val, minValue, maxValue, height);
    }

    function mapFromRange(pos) {
        return Helper.mapFromRange(pos, minValue, maxValue, height);
    }

    implicitWidth: label.implicitWidth + majorTickSize * 2

    onColorChanged: arrowCanvas.requestPaint()
    onValueChanged: if (errorVisible) errorCanvas.requestPaint()
    onErrorChanged: if (errorVisible) errorCanvas.requestPaint()

    Controls.Hatch {
        id: hatch
        anchors.left: parent.left
        anchors.leftMargin: mirrored ? 10 : 0
        anchors.right: parent.right
        anchors.rightMargin: mirrored ? 0 : 10
        anchors.bottom: parent.bottom
        height: mapToRange(warningValue)
        xFactor: yFactor * height / width
        yFactor: 35
        z: -1
    }

    Rectangle {
        id: line
        anchors.left: mirrored ? parent.left : undefined
        anchors.right: mirrored ? undefined : parent.right
        width: 1
        height: parent.height
        color: Theme.textColor
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
            width: root.width
            y: mapToRange(value)
            mirrored: root.mirrored
            value: modelData
            major: index % 2
            //TODO opacity:
        }
    }

    Canvas { // Error mark
        id: errorCanvas
        anchors.fill: parent
        visible: errorVisible
        onPaint: {
            var ctx = getContext('2d');

            ctx.clearRect(0, 0, width, height);

            ctx.save();
            ctx.translate(mirrored ? ctx.lineWidth : width - ctx.lineWidth, 0);

            var errorPos = height - mapToRange(value + error);

            ctx.beginPath();
            if (errorPos > height) {
                ctx.fillStyle = Theme.activeColor;
                ctx.moveTo((mirrored ? majorTickSize : -majorTickSize) / 2, height);
                ctx.lineTo(0, height - majorTickSize);
                ctx.lineTo(mirrored ? majorTickSize : -majorTickSize, height - majorTickSize);
                ctx.fill();
            }
            else if (errorPos < 0) {
                ctx.fillStyle = Theme.activeColor;
                ctx.moveTo((mirrored ? majorTickSize : -majorTickSize) / 2, 0);
                ctx.lineTo(0, majorTickSize);
                ctx.lineTo(mirrored ? majorTickSize : -majorTickSize, majorTickSize);
                ctx.fill();
            }
            else {
                ctx.lineWidth = 4;
                ctx.strokeStyle = Theme.activeColor;
                ctx.moveTo(0, errorPos);
                ctx.lineTo(mirrored ? majorTickSize : -majorTickSize, errorPos);
                ctx.stroke();
            }

            ctx.restore();
        }
    }

    Canvas { // Arrow for current value
        id: arrowCanvas
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: mirrored ? label.left : undefined
        anchors.left: mirrored ? undefined : label.right
        anchors.margins: -2
        width: majorTickSize
        height: label.height
        onPaint: {
            var ctx = getContext('2d');

            ctx.clearRect(0, 0, width, height);
            ctx.lineWidth = 2;

            ctx.strokeStyle = color;
            ctx.beginPath();
            ctx.moveTo(mirrored ? width : 0, 0);
            ctx.lineTo(mirrored ? 1 : width - 1, height / 2);
            ctx.lineTo(mirrored ? width : 0, height);
            ctx.stroke();
        }
    }

    ValueLabel {
        id: label
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: mirrored ? majorTickSize * 0.5 : -majorTickSize * 0.5
        width: parent.width - majorTickSize
        value: root.value
        prefix: root.prefix
        operational: root.operational
    }
}
