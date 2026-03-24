import QtQuick
import QtQuick.Controls.Basic
import Quickshell
import Qt5Compat.GraphicalEffects
import "./searchModules/"

Rectangle {
    id: root
    property bool searchSelected: false
    anchors.centerIn: parent
    width: 52
    height: 52
    radius: 40
    smooth: false
    states: [
        State {
            name: "searchHOVEREDSELECTED"
            when: searchButton.pressed
            PropertyChanges{target: searchColor; color: colBg}
            PropertyChanges{target: search; scale: 0.56}
            PropertyChanges{target: root; color: colFocused; width: 60; height: 60}
            PropertyChanges{target: searchBorderColor; color: colFocused}
        },
        State {
            name: "searchHOVERED"
            when: searchHoverHandler.hovered
            PropertyChanges{target: searchColor; color: colBg}
            PropertyChanges{target: search; scale: 0.62}
            PropertyChanges{target: root; color: colDefault; width: 60; height: 60}
            PropertyChanges{target: searchBorderColor; color: colDefault}
        },
        State {
            name: "searchSELECTED"
            when: searchSelected
            PropertyChanges{target: searchColor; color: colBg}
            PropertyChanges{target: root; color: colDefault}
            PropertyChanges{target: searchBorderColor; color: colDefault}
        },
        State {
            name: "searchNORMAL"
            when: !searchHoverHandler.hovered && !searchSelected
            PropertyChanges{target: searchColor; color: colDefault}
            PropertyChanges{target: root; color: colBg}
        }
    ]

    transitions: [
        Transition {
            ColorAnimation {
                easing.type: Easing.InOutQuad
                duration: 150
            }
            NumberAnimation {
                easing.type: Easing.InOutQuad
                properties: "scale,width,height"
                duration: 150
            }
        }
    ]

    BorderImage {
        id: searchBorder
        anchors.fill:parent
        border { left: 14; top: 14; right: 14; bottom: 14}
        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Repeat
        source: "../assets/border-bar-small.png"
        smooth: false
        ColorOverlay {
            id: searchBorderColor
            anchors.fill: searchBorder
            source: searchBorder
        }
    }
    

    Button {    
        Image {
            id: search
            anchors.fill: parent
            anchors.centerIn: parent
            source: "../assets/icons/search.png"
            scale: 0.56
            smooth: false
            ColorOverlay {
                id: searchColor
                anchors.fill: search
                source: search
            }
        }
        id: searchButton
        anchors.fill: parent
        flat: true
        background: Rectangle {color: "transparent"}
        HoverHandler {
            id: searchHoverHandler
            cursorShape: Qt.PointingHandCursor
        }
        onClicked: {
            searchSelected = false
            Quickshell.execDetached(["wofi", "--show", "drun"])
        }
    }
}