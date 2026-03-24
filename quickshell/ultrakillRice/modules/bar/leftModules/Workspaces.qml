import QtQuick
import QtQuick.Effects
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Qt5Compat.GraphicalEffects

//workspaces
Rectangle {
    id: wsContainer
    width: wsGroup.width
    color: "transparent"
    RowLayout{
        spacing: 5
        id: wsGroup
        anchors.centerIn: parent
        Repeater {
            model: 9
            Rectangle {
                id: wsRectangle
                property bool isFocused: Hyprland.focusedWorkspace?.id === (index + 1)
                property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                property bool hoveredSelected: false
                width: 44
                height: 44
                color: "transparent"
                states: [
                    State {
                        name: "HOVEREDSELECTED"
                        when: wsHoverHandler.hovered && wsButton.pressed
                        PropertyChanges{target: wsButtonHolder; color: colFocused; width: 52; height: 52}
                        PropertyChanges{target: wsBorderColor; color: colFocused}
                        PropertyChanges{target: wsText; color: colBg}
                    },
                    State {
                        name: "HOVERED"
                        when: wsHoverHandler.hovered
                        PropertyChanges{target: wsBorderColor; color: colDefault}
                        PropertyChanges{target: wsButtonHolder; color: colDefault; width: 52; height: 52}
                        PropertyChanges{target: wsText; color: colBg; scale: 1.19}
                    },
                    State {
                        name: "FOCUSED"
                        when: isFocused
                        PropertyChanges{target: wsButtonHolder; color: colDefault}
                        PropertyChanges{target: wsBorderColor; color: colDefault}
                        PropertyChanges{target: wsText; color: colBg}
                    },
                    State {
                        name: "ACTIVE"
                        when: ws && !isFocused
                        PropertyChanges{target: wsButtonHolder; color: colBg}
                        PropertyChanges{target: wsBorderColor; color: colDefault}
                        PropertyChanges{target: wsText; color: colFont}
                    },
                    State {
                        name: "EMPITY"
                        when: !isFocused && !ws
                        PropertyChanges{target: wsButtonHolder; color: colBg}
                        PropertyChanges{target: wsBorderColor; color: colBg}
                        PropertyChanges{target: wsText; color: colFont}
                    }
                ]
                transitions: [
                    Transition {
                        NumberAnimation {
                            properties: "scale,width,height"
                            easing.type: Easing.InOutQuad
                            duration: 150
                        }
                        ColorAnimation {
                            easing.type: Easing.InOutQuad 
                            duration: 150
                        }
                    }
                ] 
                Button {
                    anchors.centerIn: parent
                    id: wsButton
                    anchors.fill: parent
                    flat: true
                    background: Rectangle {
                        id: wsButtonHolder 
                        anchors.centerIn: parent 
                        width: 44 
                        height: 44 
                        radius: 20
                        BorderImage {
                            id: wsBorder
                            anchors.fill:parent
                            border { left: 14; top: 14; right: 14; bottom: 14}
                            horizontalTileMode: BorderImage.Repeat
                            verticalTileMode: BorderImage.Repeat
                            source: "../assets/border-bar-small.png"
                            smooth: false
                            ColorOverlay {
                                id: wsBorderColor
                                anchors.fill: wsBorder
                                source: wsBorder
                            }
                        }
                    }
                    Text {
                        id: wsText
                        anchors.fill: parent
                        font {
                            family: fontFamily
                            pixelSize: fontSize
                        }
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: index + 1
                    }
                    HoverHandler {
                        id: wsHoverHandler
                        cursorShape: Qt.PointingHandCursor
                    }
                    onClicked: Hyprland.dispatch("workspace " + (index + 1))
                }
                
            }
        }
    }
}