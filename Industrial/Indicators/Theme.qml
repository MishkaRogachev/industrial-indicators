pragma Singleton
import QtQuick 2.6

QtObject {
    id: root

    property int fontSize: 14
    property int margins: 8
    property int padding: 4

    property color textColor: "#ffffff"
    property color backgroundColor: "#383838"
    property color disabledColor: "#102027"
    property color activeColor: "#fd00fd"

    property color dangerColor: "#e53535"
    property color cautionColor: "#ff9800"
    property color positiveColor: "#86c34a"

    property color skyColor: "#00d4ff"
    property color groundColor: "#7b4837"
    property color trackColor: "#64adf6"
    property color missionColor: "#1ce9a5"
}
