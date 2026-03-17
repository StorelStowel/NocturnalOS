import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Qt5Compat.GraphicalEffects
import "../bar/Bar.qml"

PanelWindow {
    id: root
    implicitWidth: Screen.desktopAvailableWidth 
    implicitHeight: Screen.desktopAvailableHeight
    mask: Region {item: border; intersection: Intersection.Xor;}

    color: "transparent"

    //mask to color the outside
    Rectangle {
        id: outerFill
        anchors.fill: parent
        color: "#040404"
        visible: false
    }

    //mask to show the inside
    Item {
        id: innerMask
        width: root.width
        height: root.height
            Rectangle {
                property int sizeH: 20
                property int sizeV: 20
                id: border
                anchors.centerIn: parent
                width: root.width - sizeH
                height: root.height - sizeV
                radius: 50
                color: "white"
                
            }
        visible: false
    }

    OpacityMask {
        anchors.fill: outerFill
        source: outerFill
        maskSource: innerMask
        invert: true
    }

    //rectangle to change the shape of the border
    Rectangle {
        property bool selected: false
        property int sizeH: 20
        property int sizeV: 20
        id: innerBorder
        anchors.centerIn: parent
        state: "NORMAL"
        width: root.width - sizeH
        height: root.height - sizeV
        radius: 60
        color: "transparent"

        BorderImage {
            anchors.fill:parent
            border { left: 26; top: 26; right: 26; bottom: 26}
            horizontalTileMode: BorderImage.Repeat
            verticalTileMode: BorderImage.Repeat
            source: "./assets/screen-border.png"
        }

        states: [
            State {
                name: "NORMAL"
                when: !innerBorder.selected
                PropertyChanges{target:border; sizeH: 16; sizeV: 16}
                PropertyChanges{target:innerBorder; sizeH: 16; sizeV: 16}
            },

            State {
                name: "CLOSING"
                when: innerBorder.selected
                PropertyChanges{target: border; sizeH: 2000; sizeV: -200}
                PropertyChanges{target: innerBorder; sizeH: 2000; sizeV: -200; innerBorder.selected: true}
            }
        ]
    }
}