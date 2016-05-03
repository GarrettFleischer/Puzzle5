import QtQuick 2.0

Rectangle
{
    id: outer
    anchors.left: parent.left
    anchors.right:  parent.right
    height: txt_inner.height
    clip: true
    color: "transparent"

    property alias text: txt_inner.text
    property alias family: txt_inner.font.family
    property alias pointSize: txt_inner.font.pointSize
    property int pause_begin: 3000
    property int scroll_duration: 8000
    property int pause_end: 1000

    Text
    {
        id: txt_inner
        width: parent.width

        property real start_x: parent.x
        property real end_x: parent.x - (Math.max(0, (txt_inner.contentWidth - txt_inner.width * 0.9)))

        onTextChanged: {
            anim.stop()
            anim.start()
        }

        SequentialAnimation on x
        {
            id: anim
            loops: Animation.Infinite

            NumberAnimation {
                from: txt_inner.end_x
                to: txt_inner.start_x
                duration: 1
            }

            PauseAnimation {
                duration: outer.pause_begin
            }

            NumberAnimation {
                from: txt_inner.start_x
                to: txt_inner.end_x
                duration: outer.scroll_duration
            }

            PauseAnimation {
                duration: outer.pause_end
            }
        }
    }
}
