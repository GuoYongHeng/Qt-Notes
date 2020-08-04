import QtQuick 2.12
import QtQuick.Window 2.0
import QtQuick.Controls 2.12

ApplicationWindow {
    id: frmWindow
    visible: true
    width: 300
    height: 400
    title: qsTr("Qml底部导航")

    footer: Navigation{
        id:bar
        height:48
        width: parent.width
        currentIndex: view.currentIndex
    }

    SwipeView{
        id:view
        height: frmWindow.height - bar.height
        width: parent.width
        currentIndex: bar.currentIndex

        //当滑动切换页面时，发出信号，切换底部导航栏
        onCurrentIndexChanged: {
            bar.repeater.itemAt(bar.lastIndex).imageSource = bar.myModel.get(bar.lastIndex).modelSrc
            bar.repeater.itemAt(bar.lastIndex).textColor = bar.myModel.get(bar.lastIndex).modelColor;

            bar.repeater.itemAt(currentIndex).imageSource = bar.myModel.get(currentIndex).modelSrcG
            bar.repeater.itemAt(currentIndex).textColor = bar.myModel.get(currentIndex).modelColorG

            bar.lastIndex = currentIndex
        }

        Rectangle{
            Text{
                text: qsTr("消息")
                anchors.centerIn: parent
            }
        }
        Rectangle{
            Text{
                text: qsTr("联系人")
                anchors.centerIn: parent
            }
        }
        Rectangle{
            Text{
                text: qsTr("发现")
                anchors.centerIn: parent
            }
        }
        Rectangle{
            Text{
                text: qsTr("我")
                anchors.centerIn: parent
            }
        }
    }
}
