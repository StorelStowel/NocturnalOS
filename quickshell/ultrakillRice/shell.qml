import QtQuick
import Quickshell
import "./modules/bar/"
import "./modules/screenBorder/"

ShellRoot {
    FontLoader {
        id: vcr
        source: "fonts/VCR_OSD_MONO.ttf"
    }

    Loader {
        active: true
        sourceComponent: ScreenBorder {}
    }
    Loader {
        active: true
        sourceComponent: Bar {}
    }
}