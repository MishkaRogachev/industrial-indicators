import QtQuick 2.6
import QtQuick.Layouts 1.3
import Industrial.Indicators 1.0

Item {
    id: root

    property int percentage: -1
    property int positivePercentage: 50
    property int cautionPercentage: 15
    readonly property int percentageBordered: Math.max(0, Math.min(percentage, 100))

    property color color: {
        if (percentage > positivePercentage)
            return Theme.positiveColor;
        if (percentage > cautionPercentage)
            return Theme.cautionColor;
        if (percentage > 0)
            return Theme.dangerColor;

        return Theme.backgroundColor;
    }
}
