const express = require("express")
const request = require("request")
const app = express()
const port = 3000
const absZero = -273.15

let api = "api.openweathermap.org/data/2.5/forecast?q="
let token = "APPID=3e2d927d4f28b456c6bc662f34350957"

app.get("/weather/:city", getForecast)

app.listen(port, () => console.log("Server up, listening to port " + port))

function truncate(num, index) {
    num = num.toString(); //If it's not already a String
    num = num.slice(0, (num.indexOf("."))+index); //With 3 exposing the hundredths place
    return Number(num); //If you need it back as a Number
}

function getForecast(req, res) {
    console.log("Request received: " + req.params.city )
    let city = req.params.city
    const response = request("http://" + api + city + "&" + token, function(err, response, body) {
        if(err) {
            console.log("error: ", err)
        }
        else {
            let forecast = JSON.parse(body)
            let rain = false
            let minTemp, maxTemp = 0
            let summary = {"days" : []}
            let responseJSON = { rain : false, minTemp : Number.MAX_VALUE, maxTemp : null, summary : []}
            let avgJSON = {day : 0, avgTemp : 0, avgWindSpeed: 0, avgRainFall: 0}
            
            for (ele in forecast.list) {
                if (forecast.list[ele].main.temp_min <= responseJSON.minTemp) {
                    responseJSON.minTemp = forecast.list[ele].main.temp_min 
                }
                if (forecast.list[ele].main.temp_max >= responseJSON.maxTemp) {
                    responseJSON.maxTemp = forecast.list[ele].main.temp_max
                }
                if (forecast.list[ele].weather[0].main == "Rain") {
                    responseJSON.rain = true
                }
                avgJSON.avgTemp += forecast.list[ele].main.temp
                avgJSON.avgWindSpeed += forecast.list[ele].wind.speed
                if(forecast.list[ele].hasOwnProperty('rain')) {
                    if(forecast.list[ele].rain.hasOwnProperty("3h")){
                        avgJSON.avgRainFall += forecast.list[ele].rain["3h"]
                    }
                }
                if (ele % 8 == 7) {
                    avgJSON.day = Math.trunc(ele/8 +1)
                    avgJSON.avgTemp /= 8
                    avgJSON.avgTemp = truncate(avgJSON.avgTemp+absZero, 3) 
                    avgJSON.avgWindSpeed = truncate(avgJSON.avgWindSpeed/8, 3)
                    avgJSON.avgRainFall = truncate(avgJSON.avgRainFall/8, 3)
                    responseJSON.summary.push(avgJSON)
                    avgJSON = {day: 0, avgTemp : 0, avgWindSpeed: 0, avgRainFall: 0}
                }
            }
            responseJSON.maxTemp = responseJSON.maxTemp + absZero
            responseJSON.minTemp = responseJSON.minTemp + absZero
            responseJSON = JSON.stringify(responseJSON)
            console.log(responseJSON)
            res.header("Access-Control-Allow-Origin", "*")
            res.send(responseJSON)
        }
    })
}