import QtQuick 2.0
import "components"
import WeatherInfo 1.0

Item {
    id: window
    width: 360
    height: 640

    state: "loading"

    states: [
        State {
            name: "loading"
            PropertyChanges { target: main; opacity: 0 }
            PropertyChanges { target: wait; opacity: 1 }
        },
        State {
            name: "ready"
            PropertyChanges { target: main; opacity: 1 }
            PropertyChanges { target: wait; opacity: 0 }
        }
    ]
    AppModel {
        id: model
        onReadyChanged: {
            if (model.ready)
                window.state = "ready"
            else
                window.state = "loading"
        }
    }
    Item {
        id: wait
        anchors.fill: parent

        Text {
            text: "Loading weather data..."
            anchors.centerIn: parent
            font.pointSize: 18
        }
    }

    Item {
        id: main
        anchors.fill: parent

        Column {
            spacing: 6

            anchors {
                fill: parent
                topMargin: 6; bottomMargin: 6; leftMargin: 6; rightMargin: 6
            }

            Rectangle {
                width: parent.width
                height: 25
                color: "lightgrey"

                Text {
                    text: (model.hasValidCity ? model.city : "Unknown location") + (model.useGps ? " (GPS)" : "")
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (model.useGps) {
                            model.useGps = false
                            model.city = "Brisbane"
                        } else {
                            switch (model.city) {
                            case "Brisbane":
                                model.city = "Oslo"
                                break
                            case "Oslo":
                                model.city = "Helsinki"
                                break
                            case "Helsinki":
                                model.city = "New York"
                                break
                            case "New York":
                                model.useGps = true
                                break
                            }
                        }
                    }
                }
            }

            BigForecastIcon {
                id: current

                width: main.width -12
                height: 2 * (main.height - 25 - 12) / 3

                weatherIcon: (model.hasValidWeather
                          ? model.weather.weatherIcon
                          : "01d")
                topText: (model.hasValidWeather
                          ? model.weather.temperature
                          : "??")
                bottomText: (model.hasValidWeather
                             ? model.weather.weatherDescription
                             : "No weather data")

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        model.refreshWeather()
                    }
                }
            }

            Row {
                id: iconRow
                spacing: 6

                width: main.width - 12
                height: (main.height - 25 - 24) / 3

                property real iconWidth: iconRow.width / 4 - 10
                property real iconHeight: iconRow.height

                ForecastIcon {
                    id: forecast1
                    width: iconRow.iconWidth
                    height: iconRow.iconHeight

                    topText: (model.hasValidWeather ?
                              model.forecast[0].dayOfWeek : "??")
                    bottomText: (model.hasValidWeather ?
                                 model.forecast[0].temperature : "??/??")
                    weatherIcon: (model.hasValidWeather ?
                              model.forecast[0].weatherIcon : "01d")
                }
                ForecastIcon {
                    id: forecast2
                    width: iconRow.iconWidth
                    height: iconRow.iconHeight

                    topText: (model.hasValidWeather ?
                              model.forecast[1].dayOfWeek : "??")
                    bottomText: (model.hasValidWeather ?
                                 model.forecast[1].temperature : "??/??")
                    weatherIcon: (model.hasValidWeather ?
                              model.forecast[1].weatherIcon : "01d")
                }
                ForecastIcon {
                    id: forecast3
                    width: iconRow.iconWidth
                    height: iconRow.iconHeight

                    topText: (model.hasValidWeather ?
                              model.forecast[2].dayOfWeek : "??")
                    bottomText: (model.hasValidWeather ?
                                 model.forecast[2].temperature : "??/??")
                    weatherIcon: (model.hasValidWeather ?
                              model.forecast[2].weatherIcon : "01d")
                }
                ForecastIcon {
                    id: forecast4
                    width: iconRow.iconWidth
                    height: iconRow.iconHeight

                    topText: (model.hasValidWeather ?
                              model.forecast[3].dayOfWeek : "??")
                    bottomText: (model.hasValidWeather ?
                                 model.forecast[3].temperature : "??/??")
                    weatherIcon: (model.hasValidWeather ?
                              model.forecast[3].weatherIcon : "01d")
                }

            }
        }
    }
}
