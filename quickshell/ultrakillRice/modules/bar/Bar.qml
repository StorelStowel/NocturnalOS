import QtQuick
import QtQuick.Effects
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Qt5Compat.GraphicalEffects
import "./rightModules/"
import "./leftModules/"
import "./middleModules/"


PanelWindow {
    id: root
    property int fontSize: 35
    property string fontFamily: vcr.name
    property color colBg: "#040404"
    property color colFont: "#ffffff"
    property color colFocused: "#fe0100"
    property color colActive: '#fe9000'
    property color colDefault: "#ffffff"

    anchors.left: true
    anchors.right: true
    anchors.bottom: true
    implicitHeight: 80

    color: "transparent"

    Rectangle {
        anchors.fill:parent
        color: colBg
        radius: 30
    }

    margins {
        left: 24
        right: 24
        bottom: 24
        top: -1 * root.implicitHeight
    }



    /*borders*/
    BorderImage {
        anchors.fill:parent
        border { left: 18; top: 18; right: 18; bottom: 18}
        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Repeat
        source: "./assets/border-bar.png"
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        GridLayout {
            anchors.centerIn: parent
            width: parent.width - 40
            height: parent.height
            columns: 3
            rows: 1
            columnSpacing: 0

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                LeftModules {}
            }
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true
                MiddleModules {}
            }
            Item {
                id: right
                Layout.fillWidth: true
                Layout.fillHeight: true
                RightModules {}
            }
        }    
    }
}

