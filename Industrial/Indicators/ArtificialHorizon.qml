import QtQuick 2.6
import Industrial.Indicators 1.0

AttitudeIndicator {
    id: ah

    PlaneMark {
        id: mark
        anchors.centerIn: parent
        width: parent.width - Theme.margins
        effectiveHeight: ah.effectiveHeight
        pitch: pitchInverted ? 0 : -ah.pitch
        roll: rollInverted ? -ah.roll : 0
        markColor: armed ? Theme.backgroundColor : Theme.dangerColor
        markWidth: 1.5
    }
}
