//
//  CurrentWeather.swift
//  Stormy
//
//  Created by Tommy Choe on 10/24/15.
//  Copyright © 2015 Tommy Choe. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    let temperature: Int?
    let humidity: Int?
    let precipProbability: Int?
    let summary: String?
    var icon: UIImage? = UIImage(named: "default.png")
    
    var isFahrenheit = true
    
    var convertedTemperatureScale: Int? {
        get{
            if let temperature = self.temperature{
                if isFahrenheit == true{
                    return self.temperature
                }else{
                    return (temperature - 32) * 5/9
                }
            }else{
                return nil
            }
        }
    }
    
    init(weatherDictionary: [String: AnyObject]){
        let defaults = NSUserDefaults.standardUserDefaults()
        isFahrenheit = defaults.valueForKey("asFahrenheit") as! Bool
        
        temperature = weatherDictionary["temperature"] as? Int
        if let humidityRaw = weatherDictionary["humidity"] as? Double{
            humidity = Int(humidityRaw * 100)
        } else {
            humidity = nil
        }
        if let precipProbabilityRaw = weatherDictionary["precipProbability"] as? Double{
            precipProbability = Int(precipProbabilityRaw * 100)
        } else {
            precipProbability = nil
        }
        summary = weatherDictionary["summary"] as? String
        if let iconString = weatherDictionary["icon"] as? String,
            let weatherIcon = Icon(rawValue: iconString){
                (icon,_) = weatherIcon.toImage()
        }
    }
}










