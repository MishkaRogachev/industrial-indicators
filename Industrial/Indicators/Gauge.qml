import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Indicators 1.0
import Industrial.Controls 1.0 as Controls

Item {
    id: root

    property real value: 0.0
    property int rounding: 3
    property int spacing: 1
    property color color: Theme.positiveColor

    property alias model: repeater.model

    implicitWidth: industrial.baseSize * 4
    implicitHeight: industrial.baseSize * 0.5

    Row {
        anchors.fill: parent
        spacing: root.spacing

        Repeater {
            id: repeater
            model: [
                { percentage: 10, color: Theme.dangerColor },
                { percentage: 20, color: Theme.cautionColor },
                { percentage: 40, color: Theme.positiveColor },
                { percentage: 20, color: Theme.cautionColor },
                { percentage: 10, color: Theme.dangerColor }
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
        anchors.verticalCenter: parent.verticalCenter
        x: value / 100 * root.width - width / 2
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
