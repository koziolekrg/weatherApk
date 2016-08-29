TEMPLATE = app
TARGET = weatherinfo

QT += core network positioning qml quick
CONFIG += c++11

SOURCES += main.cpp \
    appmodel.cpp

RESOURCES += qml.qrc

HEADERS += \
    appmodel.h

INSTALLS += target

OTHER_FILES  += main.qml \
    components/BigForecastIcon.qml \
    components/ForecastIcon.qml \
    components/WeatherIcon.qml \
    icons/*

target.path = $$[QT_INSTALL_EXAMPLES]/positioning/weatherinfo
