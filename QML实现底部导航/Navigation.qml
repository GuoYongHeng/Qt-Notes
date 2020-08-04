import QtQuick 2.12
import QtQuick.Controls 2.5

TabBar {
    property alias myModel: myModel
    property int lastIndex: 0
    property alias repeater: repeater

    id: bar
    currentIndex: 0

    ListModel {
        id: myModel
        ListElement{modelText:"消息";
                           modelColor:"#000000";
                           modelColorG:"#148014";
                           modelSrc:"qrc:/images/Chat_MsgRecord.svg";
                           modelSrcG:"qrc:/images/Chat_MsgRecordG.svg"}
        ListElement{modelText:"联系人";
                           modelColor:"#000000";
                           modelColorG:"#148014";
                           modelSrc:"qrc:/images/Chat_FriendManager.svg";
                           modelSrcG:"qrc:/images/Chat_FriendManagerG.svg"}
        ListElement{modelText:"发现";
                           modelColor:"#000000";
                           modelColorG:"#148014";
                           modelSrc:"qrc:/images/Mobile_Find.svg";
                           modelSrcG:"qrc:/images/Mobile_FindG.svg"}
        ListElement{modelText:"我";
                           modelColor:"#000000";
                           modelColorG:"#148014";
                           modelSrc:"qrc:/images/Main_P2PChat.svg";
                           modelSrcG:"qrc:/images/Main_P2PChatG.svg"}
    }

    Repeater {
        id: repeater
        model: myModel

        TabButton {
            property alias imageSource: image.source
            property alias textColor: text.color

            height: bar.height
            contentItem: Text{
                id: text
                text: modelText
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignBottom
                color: (model.index === bar.currentIndex) ? modelColorG : modelColor
            }
            background: Image{
                id:image
                width: 24
                height: 24
                anchors.horizontalCenter: parent.horizontalCenter
                source: (model.index === bar.currentIndex) ? modelSrcG : modelSrc
            }
            //当鼠标悬浮在某个导航栏按钮上的时候，高亮该按钮
            onHoveredChanged: {
                if(model.index !== bar.currentIndex) {
                    hovered ? text.color = modelColorG : text.color = modelColor
                    hovered ? image.source = modelSrcG : image.source = modelSrc
                    console.log("model.index:",model.index,"bar.currentindex",bar.currentIndex)
                }
            }

            //当点击某个导航栏按钮的时候，切换页面
            onClicked: {
                repeater.itemAt(bar.lastIndex).imageSource = myModel.get(bar.lastIndex).modelSrc
                repeater.itemAt(bar.lastIndex).textColor = modelColor;

                image.source = modelSrcG;
                text.color = modelColorG;
                bar.lastIndex = model.index;
            }
        }
    }
}
