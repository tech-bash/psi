#ifndef CUSTOMSCROLLBAR_H
#define CUSTOMSCROLLBAR_H
#include <QTimer>
#include "qscrollbar.h"

class CustomScrollBar : public QScrollBar {
    Q_OBJECT

public:
    CustomScrollBar(Qt::Orientation orientation, QWidget *parent = nullptr)
        : QScrollBar(orientation, parent), hideTimer(new QTimer(this)) {
        setMouseTracking(true);
        hideTimer->setSingleShot(true);
        hideTimer->setInterval(1000); // hide after 1 second of inactivity
        connect(hideTimer, &QTimer::timeout, this, &CustomScrollBar::hideScrollBar);
    }

protected:
    void enterEvent(QEnterEvent *event) override {
        showScrollBar();
        hideTimer->stop();
        QScrollBar::enterEvent(event);
    }

    void leaveEvent(QEvent *event) override {
        hideTimer->start();
        QScrollBar::leaveEvent(event);
    }

    void mousePressEvent(QMouseEvent *event) override {
        showScrollBar();
        hideTimer->stop();
        QScrollBar::mousePressEvent(event);
    }

    void mouseReleaseEvent(QMouseEvent *event) override {
        hideTimer->start();
        QScrollBar::mouseReleaseEvent(event);
    }

    void mouseMoveEvent(QMouseEvent *event) override {
        showScrollBar();
        hideTimer->stop();
        QScrollBar::mouseMoveEvent(event);
    }

    void wheelEvent(QWheelEvent *event) override {
        showScrollBar();
        hideTimer->stop();
        QScrollBar::wheelEvent(event);
    }

private slots:
    void showScrollBar() {
        setVisible(true);
    }

    void hideScrollBar() {
        setVisible(false);
    }

private:
    QTimer *hideTimer;
};

#endif // CUSTOMSCROLLBAR_H
