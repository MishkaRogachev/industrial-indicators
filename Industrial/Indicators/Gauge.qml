import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Indicators 1.0
import Industrial.Controls 1.0 as Controls

Item {
    id: root

    property real value: 0.0
    property real _persent: 0
    property int rounding: 3
    property int spacing: 1
    property color color: Theme.textColor

    property alias model: repeater.model

    implicitWidth: industrial.baseSize * 4
    implicitHeight: industrial.baseSize * 0.5

    onModelChanged: recalculate()
    onValueChanged: recalculate()

    function recalculate() {
        if (!model || model.length < 1) return;
        _persent = 0;

        for (var i = 0; i < model.length; ++i) {
            if (i < model.length - 1 && value > model[i + 1].value) color = model[i].color;

            if (value > model[i].value) {
                _persent += model[i].percentage;
            }
            else {
                color = model[i].color;
                _persent += (value - model[i - 1].value); // FIXME: recalc values to percents
                break;
            }
        }
    }

    Row {
        anchors.fill: parent
        spacing: root.spacing

        Repeater {
            id: repeater
            model: [
                { percentage: 10, value: 10, color: Theme.dangerColor },
                { percentage: 20, value: 30, color: Theme.cautionColor },
                { percentage: 40, value: 70, color: Theme.positiveColor },
                { percentage: 20, value: 90, color: Theme.cautionColor },
                { percentage: 10, value: 100, color: Theme.dangerColor }
            ]

            Item {
                anchors.bottom: parent.bottom
                width: root.width * modelData.percentage / 100
                height: parent.height / 4
                clip: true

                Rectangle {
                    anchors.fill: parent
                    anchors.leftMargin: index == 0 ? 0 : -radius
                    anchors.rightMargin: index == repeater.count - 1 ? 0 : -radius
                    radius: root.rounding
                    color: modelData.color
                }
            }
        }
    }

    Controls.ColoredIcon {
        id: tick
        x: _persent / 100 * root.width - width / 2
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height
        width: height
        source: "qrc:/icons/ind_gauge_arrow.svg"
        color: Theme.backgroundColor

        Controls.ColoredIcon {
            anchors.fill: parent
            anchors.margins: 2
            source: parent.source
            color: root.color
        }
    }
}
