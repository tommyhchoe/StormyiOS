//
//  DailyWeather.swift
//  Stormy
//
//  Created by Tommy Choe on 10/28/15.
//  Copyright © 2015 Tommy Choe. All rights reserved.
//

import Foundation
import UIKit

struct DailyWeather{

    let maxTemperature: Int?
    let minTemperature: Int?
    let humidity: Int?
    let precipProbability: Int?
    let summary: String?
    var icon: UIImage? = UIImage(named: "default.png")
    var largeIcon: UIImage? = UIImage(named: "default_large.png")
    var sunriseTime: String?
    var sunsetTime: String?
    var day: String?
    let dateFormatter = NSDateFormatter()
    
    init(dailyWeatherDictionary: [String:AnyObject]){
        maxTemperature = dailyWeatherDictionary["temperatureMax"] as? Int
        minTemperature = dailyWeatherDictionary["temperatureMin"] as? Int
        if let humidityFloat = dailyWeatherDictionary["humidity"] as? Double{
            humidity = Int(humidityFloat * 100)
        } else {
            humidity = nil
        }
        if let precipChanceFloat = dailyWeatherDictionary["precipProbability"] as? Double{
            precipProbability = Int(precipChanceFloat * 100)
        } else {
            precipProbability = nil
        }
        summary = dailyWeatherDictionary["summary"] as? String
        if let iconString = dailyWeatherDictionary["icon"] as? String,
            let weatherIcon: Icon = Icon(rawValue: iconString){
                (icon,largeIcon) = weatherIcon.toImage()
        }
        if let sunriseTimeFromDictionary = dailyWeatherDictionary["sunriseTime"] as? Double{
            sunriseTime = timeStringFromUnixTime(sunriseTimeFromDictionary)
        } else {
            sunriseTime = nil
        }
        if let sunsetTimeFromDictionary = dailyWeatherDictionary["sunsetTime"] as? Double{
            sunsetTime = timeStringFromUnixTime(sunsetTimeFromDictionary)
        } else {
            sunsetTime = nil
        }
        if let time = dailyWeatherDictionary["time"] as? Double{
            day = dayStringFromTime(time)
        } else {
            day = nil
        }
    }
    
// MARK: Helper Methods
    
    func timeStringFromUnixTime(unixTime: Double) -> String{
        let date = NSDate(timeIntervalSince1970: unixTime)
        
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.stringFromDate(date)
    }
    func dayStringFromTime(time: Double) -> String{
        let date = NSDate(timeIntervalSince1970: time)
        
        dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.currentLocale().localeIdentifier)
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.stringFromDate(date)
    }

}









