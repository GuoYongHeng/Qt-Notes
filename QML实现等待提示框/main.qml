import QtQuick 2.12
import QtQuick.Window 2.0
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 400
    height: 400
    title: qsTr("等待提示框")

    BusyIndicator {
        id: loading
        anchors.centerIn: parent
        implicitWidth: 96
        implicitHeight: 96
        opacity: running ? 0.0:1.0
        contentItem:Loading{}
    }

    MouseArea{
        anchors.fill: parent
        onClicked:loading.running = !loading.running
    }
}
