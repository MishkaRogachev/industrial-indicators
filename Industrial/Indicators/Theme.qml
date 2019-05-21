pragma Singleton
import QtQuick 2.6

QtObject {
    id: root

    property int fontSize: 14
    property int margins: 8
    property int padding: 4

    property color textColor: "#ffffff"
    property color backgroundColor: "#1a2226"
    property color disabledColor: "#102027"
    property color activeColor: "#fd00fd"

    property color dangerColor: "#e53535"
    property color cautionColor: "#ff9800"
    property color positiveColor: "#86c34a"

    property color skyHighColor: "#0d1bd9"
    property color skyLowColor: "#00d4ff"
    property color groundHighColor: "#95833b"
    property color groundLowColor: "#68342b"

    property color skyOffHighColor: "#364354"
    property color skyOffLowColor: "#e0f1f8"
    property color groundOffHighColor: "#9ea79b"
    property color groundOffLowColor: "#30342e"

    property color trackColor: "#64adf6"
    property color missionColor: "#1ce9a5"
}
