import QtQuick 2.6
import Industrial.Indicators 1.0

import "../Controls/helper.js" as Helper

Item {
    id: root

    property real roll: 0.0
    property real minPitch: -25.0
    property real maxPitch: 25.0
    property real pitchStep: 10

    property real fontSize: Math.max(height * 0.075, 8)
    property real tickMinorSize: width * 0.1
    property real tickMajorSize: width * 0.3
    property real textOffset: width * 0.05

    property real tickMajorWeight: 2
    property real tickMinorWeight: 1

    property color color: Theme.textColor

    function mapToRange(pitch) {
        return Helper.mapToRange(pitch, minPitch, maxPitch, height);
    }

    rotation: -roll

    Repeater {
        id: repeater
        model: {
            var pitchs = [];
            for (var pitch = minPitch - (minPitch % (pitchStep * 2)); pitch <= maxPitch;
                 pitch += pitchStep) {
                pitchs.push(pitch);
            }
            return pitchs;
        }

        PitchScaleTick {
            width: root.width
            y: root.height - mapToRange(value)
            value: modelData
            major: index % 2 == 0
            color: root.color
            visible: value != 0
            opacity: Math.sin(y / root.height * Math.PI)
        }
    }
}
