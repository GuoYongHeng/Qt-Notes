#include "widget.h"

Widget::Widget(QWidget *parent)
    : QWidget(parent)
{
    layout = new QHBoxLayout;
    customPlot = new QCustomPlot;
    layout->addWidget(customPlot);
    setLayout(layout);

    customPlot->setInteractions(QCP::iRangeDrag|QCP::iRangeZoom);
    qsrand(QTime(0,0,0).secsTo(QTime::currentTime()));
    customPlot->addGraph();
    customPlot->graph(0)->setPen(QPen(Qt::blue));
    QVector<double> x(151), y(151);
    for(int i = 0; i < 151; ++i)
    {
        x[i] = i;
        y[i] = qrand()%500;
    }
    customPlot->graph(0)->setData(x, y);
    customPlot->graph(0)->rescaleAxes();

    connect(customPlot, &QCustomPlot::plottableClick, this, &Widget::RecordPoint);
    connect(customPlot, &QCustomPlot::beforeReplot, this, &Widget::PaintText);

}

Widget::~Widget()
{
}

void Widget::RecordPoint(QCPAbstractPlottable *plottable, int dataIndex, QMouseEvent *event)
{
    Q_UNUSED(plottable)
    Q_UNUSED(event)
    if(points.contains(dataIndex))
    {
        points.remove(dataIndex);
        customPlot->replot();
        return;
    }
    points.insert(dataIndex);
    customPlot->replot();
}

void Widget::PaintText()
{
    customPlot->clearItems();
    QCPRange range = customPlot->yAxis->range();
    double delta = (range.upper - range.lower) / 25.0;
    for(int dataIndex : points)
    {
        double x = customPlot->graph()->data()->at(dataIndex)->key;
        double y = customPlot->graph()->data()->at(dataIndex)->value;

        QCPItemText* textLabel = new QCPItemText(customPlot);
        textLabel->setVisible(true);
        textLabel->position->setCoords(x, y+delta);
        textLabel->setText(QString::number(x));
        textLabel->setFont(QFont(font().family(), 16));
        textLabel->setPen(QPen(Qt::black));

        QCPItemLine* line = new QCPItemLine(customPlot);
        line->start->setParentAnchor(textLabel->bottom);
        line->end->setCoords(x, y);
    }
}

