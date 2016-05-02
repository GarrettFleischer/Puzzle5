import QtQuick 2.0

Rectangle {
    property string song_title
    property string band_title

    anchors.fill: parent

    Text
    {
        id: txt_screen_song
        anchors.left: parent.left
        anchors.right: parent.right
        text: "Song: " + song_title
        font.family: "BELLABOO"
        font.pointSize: 14
        wrapMode: Text.Wrap
    }

    Text
    {
        id: txt_screen_band
        anchors.top: txt_screen_song.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        text: "Band: " + band_title
        font.family: "BELLABOO"
        font.pointSize: 14
        wrapMode: Text.Wrap
    }
}
