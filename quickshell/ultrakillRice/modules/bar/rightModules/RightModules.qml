import QtQuick
import QtQuick.Layouts
import Quickshell


Row {
    id: root
    anchors.fill: parent
    spacing: 20

    layoutDirection: Qt.RightToLeft
    
    Rectangle {
        width: clock.width
        height: parent.height
        color: "transparent"
        Clock {id: clock; anchors.fill: parent}
    }
}
