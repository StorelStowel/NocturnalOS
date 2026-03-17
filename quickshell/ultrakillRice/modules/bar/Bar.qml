import QtQuick
import QtQuick.Effects
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Qt5Compat.GraphicalEffects

PanelWindow {
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
        bottom: 25
        top: -80
    }

    SystemClock {
        id: clockSystem
        precision: SystemClock.Seconds
    }

    /*borders*/
    BorderImage {
        anchors.fill:parent
        border { left: 18; top: 18; right: 18; bottom: 18}
        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Repeat
        source: "./assets/border-bar.png"
    }


    RowLayout {
        id: barLayout
        anchors.fill: parent
        anchors.leftMargin: 20
        anchors.rightMargin: 20

        //workspaces
        Rectangle {
            id: wsContainer
            anchors.left: parent.left
            height: 58
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
                        width: 43
                        height: 43
                        radius: 20

                        signal wsSelected(selected: bool)

                        states: [
                            State {
                                name: "HOVEREDSELECTED"
                                when: wsHoverHandler.hovered && wsButton.pressed
                                PropertyChanges{target: wsRectangle; color: colFocused; scale: 1.17}
                                PropertyChanges{target: wsBorderColor; color: colFocused}
                                PropertyChanges{target: wsBorder; scale: 1.01;}
                                PropertyChanges{target: wsText; color: colBg}
                            },

                            State {
                                name: "HOVERED"
                                when: wsHoverHandler.hovered
                                PropertyChanges{target: wsRectangle; color: colDefault; scale: 1.17}
                                PropertyChanges{target: wsBorderColor; color: colDefault}
                                PropertyChanges{target: wsBorder; scale: 1.01;}
                                PropertyChanges{target: wsText; color: colBg}
                            },

                            State {
                                name: "FOCUSED"
                                when: isFocused
                                PropertyChanges{target: wsRectangle; color: colDefault}
                                PropertyChanges{target: wsBorderColor; color: colDefault}
                                PropertyChanges{target: wsBorder; scale: 1.01;}
                                PropertyChanges{target: wsText; color: colBg}
                            },

                            State {
                                name: "ACTIVE"
                                when: ws && !isFocused
                                PropertyChanges{target: wsRectangle; color: colBg}
                                PropertyChanges{target: wsBorderColor; color: colDefault}
                                PropertyChanges{target: wsText; color: colFont}
                            },

                            State {
                                name: "EMPITY"
                                when: !isFocused && !ws
                                PropertyChanges{target: wsRectangle; color: colBg}
                                PropertyChanges{target: wsBorderColor; color: colBg}
                                PropertyChanges{target: wsText; color: colFont}
                            }
                        ]

                        transitions: [

                            Transition {
                                NumberAnimation {
                                    property: "scale"
                                    easing.type: Easing.InOutQuad
                                    duration: 150
                                }
                                ColorAnimation {
                                    easing.type: Easing.InOutQuad 
                                    duration: 150
                                }
                            }
                        ]

                        BorderImage {
                            id: wsBorder
                            anchors.fill:parent
                            border { left: 14; top: 14; right: 14; bottom: 14}
                            horizontalTileMode: BorderImage.Repeat
                            verticalTileMode: BorderImage.Repeat
                            source: "./assets/border-bar-small.png"
                            smooth: false
                            ColorOverlay {
                                id: wsBorderColor
                                anchors.fill: wsBorder
                                source: wsBorder
                            }
                        }

                        Button {
                            id: wsButton
                            anchors.fill: parent
                            flat: true
                            background: Rectangle {color: "transparent"}
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
                            onClicked: {Hyprland.dispatch("workspace " + (index + 1)); wsRectangle.wsSelected(true)} 
                        }
                    }
                }
            }
        }

        /*clock display*/
        Rectangle {
            anchors.right: parent.right
            Text {
                anchors.fill: parent
                font {
                    family: fontFamily
                    pixelSize: fontSize
                }
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                text: Qt.formatDateTime(clockSystem.date, "hh:mm:ss")
                color: colFont
            }
        }

        //power
        Rectangle {
            id: powerContainer
            property bool powerSelected: false
            anchors.centerIn: parent
            width: 52
            height: 52
            radius: 40
            smooth: false
            states: [
                State {
                    name: "POWERHOVEREDSELECTED"
                    when: powerButton.pressed
                    PropertyChanges{target: powerColor; color: colBg}
                    PropertyChanges{target: power}
                    PropertyChanges{target: powerContainer; color: colFocused; scale: 1.16}
                    PropertyChanges{target: powerBorderColor; color: colFocused}
                    PropertyChanges{target: powerBorder; scale: 1.01}
                },

                State {
                    name: "POWERHOVERED"
                    when: powerHoverHandler.hovered
                    PropertyChanges{target: powerColor; color: colBg}
                    PropertyChanges{target: powerContainer; color: colDefault; scale: 1.16}
                    PropertyChanges{target: powerBorderColor; color: colDefault}
                    PropertyChanges{target: powerBorder; scale: 1.01}
                },

                State {
                    name: "POWERSELECTED"
                    when: powerContainer.powerSelected
                    PropertyChanges{target: powerColor; color: colBg}
                    PropertyChanges{target: powerContainer; color: colDefault}
                    PropertyChanges{target: powerBorderColor; color: colDefault}
                },

                State {
                    name: "POWERNORMAL"
                    when: !powerHoverHandler.hovered && !powerContainer.powerSelected
                    PropertyChanges{target: powerColor; color: colDefault}
                    PropertyChanges{target: powerContainer; color: colBg}
                }
            ]

            transitions: [
                Transition {
                    ColorAnimation {
                        easing.type: Easing.InOutQuad
                        duration: 200
                    }
                    NumberAnimation {
                        easing.type: Easing.InOutQuad
                        property: "scale"
                        duration: 200
                    }
                }
            ]

            BorderImage {
                id: powerBorder
                anchors.fill:parent
                border { left: 14; top: 14; right: 14; bottom: 14}
                horizontalTileMode: BorderImage.Repeat
                verticalTileMode: BorderImage.Repeat
                source: "./assets/border-bar-small.png"
                smooth: false
                ColorOverlay {
                    id: powerBorderColor
                    anchors.fill: powerBorder
                    source: powerBorder
                }
            }
            
            Image {
                id: power
                anchors.fill: parent
                anchors.centerIn: parent
                source: "./assets/icons/power.png"
                scale: 0.56
                smooth: false
                ColorOverlay {
                    id: powerColor
                    anchors.fill: power
                    source: power
                }
            }

            Button {
                id: powerButton
                anchors.fill: parent
                flat: true
                background: Rectangle {color: "transparent"}
                HoverHandler {
                    id: powerHoverHandler
                    cursorShape: Qt.PointingHandCursor
                }
                onClicked: powerContainer.powerSelected ? powerContainer.powerSelected = false : powerContainer.powerSelected = true
            }
        }
    }
}

