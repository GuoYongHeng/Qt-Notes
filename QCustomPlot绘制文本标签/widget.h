#ifndef WIDGET_H
#define WIDGET_H

#include <QWidget>
#include "qcustomplot.h"
#include <QHBoxLayout>
#include <QSet>

class Widget : public QWidget
{
    Q_OBJECT

public:
    Widget(QWidget *parent = nullptr);
    ~Widget();

public slots:
    void RecordPoint(QCPAbstractPlottable *plottable, int dataIndex, QMouseEvent *event);
    void PaintText();

private:
    QHBoxLayout* layout;
    QCustomPlot* customPlot;
    QSet<int> points;
};
#endif // WIDGET_H
