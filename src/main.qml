import QtQuick 2.5
import QtQuick.Controls 1.4
import QtMultimedia 5.5

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("iPod")


    ListModel
    {
        id: mdl_library

        ListElement {
            song: "Burning the Nicotine Armoire"
            band: "Dance Gavin Dance"
            source: "../songs/Dance Gavin Dance - Burning Down the Nicotine Armoire (audio-cutter.com).mp3"
        }
        ListElement {
            song: "Happiness"
            band: "Dance Gavin Dance"
            source: "../songs/Dance Gavin Dance - Happiness.mp3"
        }
        ListElement {
            song: "Open Your Eyes And Look North"
            band: "Dance Gavin Dance"
            source: "../songs/Dance Gavin Dance - Open Your Eyes and Look North.mp3"
        }
    }
    property int song_index: 0
    property bool show_menu: true
    property bool is_playing: song_current.playbackState === Audio.PlayingState

    Rectangle
    {
        id: big_wrapper
        anchors.fill: parent

        Audio
        {
            id: song_current
            source: mdl_library.get(song_index).source
        }

        Image {
            id: img_iPod
            source: "iPod.svg"
            smooth: true
            sourceSize.width: parent.width * .89
            sourceSize.height: parent.height * .90
            anchors.centerIn: parent

            Rectangle
            {
                id: iPod_screen
                x: 50
                y: 31
                width: 258 - x
                height: 187 - y
                color: "orange"


                ListView
                {
                    id: lst_menu
                    anchors.fill: parent

                    visible: show_menu

                    model: mdl_library
                    delegate: MarqueeText {
                        text: band + "/" + song
                        pointSize: 10

                        scroll_duration: 9000
                    }
                }


                MarqueeText
                {
                    id: txt_screen_song
                    text: mdl_library.get(song_index).song
                    pointSize: 12

                    pause_begin: 2000
                    scroll_duration: 4000

                    visible: !show_menu
                }

                MarqueeText
                {
                    id: txt_screen_band
                    anchors.top: txt_screen_song.bottom
                    text: mdl_library.get(song_index).band
                    pointSize: 12

                    pause_begin: 2000
                    scroll_duration: 4000

                    visible: !show_menu
                }

                Text
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    text: "Paused..."

                    visible: !show_menu && !is_playing
                }

                MouseArea
                {
                    id: ma_screen
                    anchors.fill: parent
                    onClicked:
                    {
                        if(show_menu)
                        {
                            show_menu = false
                            song_current.stop()
                            song_index = lst_menu.indexAt( ma_screen.mouseX, ma_screen.mouseY)
                            song_current.play()
                        }
                    }
                }
            }

            Rectangle
            {
                id: iPod_back_button
                x:80
                y: 250
                width: 40
                height: 83
                color: "transparent"

                MouseArea
                {
                    id: ma_mousearea_back
                    anchors.fill: parent

                    onClicked:
                    {
                        var was_playing = is_playing
                        song_index = ((song_index - 1) < 0) ? (mdl_library.count - 1) : (song_index - 1)
                        if(was_playing)
                            song_current.play()

                        show_menu = false
                    }
                }
            }

            Rectangle
            {
                id: iPod_forward_button
                x: 185
                y: 262
                width: 228 - x
                height: 331 - y
                color: "transparent"

                MouseArea
                {
                    id: ma_mousearea_forward
                    anchors.fill: parent

                    onClicked:
                    {
                        var was_playing = is_playing
                        song_index = (song_index + 1) % mdl_library.count
                        if(was_playing)
                            song_current.play()
                    }
                }
            }

            Rectangle
            {
                id: iPod_menu_button
                x: 130
                y: 225
                width: 47
                height: 263 - y
                color: "transparent"

                MouseArea
                {
                    id: ma_mousearea_menu
                    anchors.fill: parent

                    onClicked:
                    {
                        show_menu = !show_menu
                    }
                }
            }

            Rectangle
            {
                id: iPod_play_button
                x: 130
                y: 330
                width: 47
                height: 47

                color: "transparent"

                MouseArea
                {
                    id: ma_mousearea_play
                    anchors.fill: parent

                    onClicked:
                    {
                        show_menu = false

                        if(is_playing)
                            song_current.pause()
                        else
                            song_current.play()
                    }
                }
            }
        }

    }
}
