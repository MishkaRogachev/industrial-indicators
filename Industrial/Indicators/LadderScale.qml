import QtQuick 2.6
import Industrial.Controls 1.0 as Controls

Item {
    id: root

    property bool mirrored: false

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
}
