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
    
    init(weatherDictionary: [String: AnyObject]){
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










