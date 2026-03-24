import QtQuick
import QtQuick.Layouts
import Quickshell


Row {
    id: root
    anchors.fill: parent
    spacing: 20
    
    Rectangle {
        width: clock.width
        height: parent.height
        color: "transparent"
        Workspaces {id: clock; anchors.fill: parent}
    }
}
