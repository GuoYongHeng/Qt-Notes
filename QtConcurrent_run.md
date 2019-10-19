* QtConcurrent::run，文档中有

  The QtConcurrent::run() function runs a function in a separate thread. The return value of the function is made available through the QFuture API.



* 关于QFuture，文档中有

  The QFuture class represents the result of an asynchronous computation.

  QFuture allows threads to be synchronized against one or more results which will be ready at a later point in time. The result can be of any type that has a default constructor and a copy constructor. If a result is not available at the time of calling the result(), resultAt(), or results() functions, QFuture will wait until the result becomes available. You can use the isResultReadyAt() function to determine if a result is ready or not. For QFuture objects that report more than one result, the resultCount() function returns the number of continuous results. This means that it is always safe to iterate through the results from 0 to resultCount().

  QFuture\<void\> is specialized to not contain any of the result fetching functions. Any QFuture\<T\> can be assigned or copied into a QFuture\<void\> as well. This is useful if only status or progress information is needed - not the actual result data.

  To interact with running tasks using signals and slots, use QFutureWatcher.



* 关于QFutureWatcher，文档中有

  The QFutureWatcher class allows monitoring a QFuture using signals and slots.

  QFutureWatcher provides information and notifications about a QFuture. Use the setFuture() function to start watching a particular QFuture. The future() function returns the future set with setFuture().

  

  更多的信息可以查看文档

  下边是一个使用QtConcurrent::run更新进度条的例子：

```c++
//weight.h
#ifndef WIDGET_H
#define WIDGET_H

#include <QWidget>
#include <QtConcurrent>
#include <QFutureWatcher>
#include <QString>
#include <QProgressBar>
#include <QPushButton>
#include <QHBoxLayout>
#include <QDebug>

class Widget : public QWidget
{
    Q_OBJECT

public:
    Widget(QWidget *parent = 0);
    ~Widget();

signals:
	//发送信号改变进度条的值
    void valueChange(int cur);

private slots:
    void startButtonClicked();
    void threadFinished();
    void updateProgressBar(int cur);

private:
    void calc();

    QFutureWatcher<void> futureWatcher;
    QHBoxLayout *layout;
    QPushButton *startButton;
    QProgressBar *progressBar;
};

#endif // WIDGET_H
```



```c++
//weight.cpp
#include "widget.h"

Widget::Widget(QWidget *parent)
    : QWidget(parent)
{
    layout = new QHBoxLayout;
    startButton = new QPushButton("start");
    progressBar = new QProgressBar;
    progressBar->setMinimum(0);
    progressBar->setMaximum(100);
    layout->addWidget(startButton);
    layout->addWidget(progressBar);
    this->setLayout(layout);
    //按钮
    connect(startButton, &QPushButton::clicked, this, &Widget::startButtonClicked);
    //监视线程，线程结束调用槽函数
    connect(&futureWatcher, &QFutureWatcher<void>::finished, this, &Widget::threadFinished);
    //更新进度条
    connect(this, &Widget::valueChange, this, &Widget::updateProgressBar);
}

Widget::~Widget()
{

}

void Widget::startButtonClicked()
{
    qDebug() << "main thread id:" << QThread::currentThreadId();
    //在一个新的线程中运行calc函数
    futureWatcher.setFuture(QtConcurrent::run(this, &Widget::calc));
}

void Widget::threadFinished()
{
    qDebug() << "finished";
}

void Widget::updateProgressBar(int cur)
{
    progressBar->setValue(cur);
}

void Widget::calc()
{
    qDebug() << "sub thread id:" << QThread::currentThreadId();
    int size = 1e9;
    int step = 1e7;
    for(int i = 0; i < size; ++i)
    {
        if(i%step == 0)
            emit valueChange(i/step);
    }
    emit valueChange(100);
}

```



