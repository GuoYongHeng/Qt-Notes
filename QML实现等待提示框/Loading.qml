import QtQuick 2.12
import QtGraphicalEffects 1.0

Item {
    Rectangle{
        id: rect
        width: parent.width
        height: parent.height
        color: Qt.rgba(0,0,0,0)
        radius: width/2
        border.width: width/4
        visible: false
    }

    //圆锥渐变  这个渐变转圈，中间透明，就是个进度条了
    ConicalGradient{
        width: rect.width
        height: rect.height
        gradient: Gradient{
            GradientStop{position: 0.0;color: "#80c342"}
            GradientStop{position: 1.0;color: "#006325"}
        }
        source: rect //This property defines the item that is going to be filled with gradient

        Rectangle{
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: rect.border.width
            height: width
            radius: width/2
            color: "#000000" //006325
        }

        //旋转动画，属性动画 - 元素完全加载后自动运行，三种实现动画的方式之一
        RotationAnimation on rotation{
            from:0
            to:360
            duration: 800
            loops:Animation.Infinite
        }
    }
}
