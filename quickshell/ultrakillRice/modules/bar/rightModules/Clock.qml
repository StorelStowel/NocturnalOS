import QtQuick
import QtQuick.Effects
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Qt5Compat.GraphicalEffects



Rectangle {
    implicitWidth: 163
    color: "transparent"
    SystemClock {
        id: clockSystem
        precision: SystemClock.Seconds
    }
    Text {
        anchors.fill: parent
        font {
            family: fontFamily
            pixelSize: fontSize
        }
        verticalAlignment: Text.AlignVCenter
        text: Qt.formatDateTime(clockSystem.date, "hh:mm:ss")
        color: "white"
    }
}
