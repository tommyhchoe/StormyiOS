//
//  ForecastService.swift
//  Stormy
//
//  Created by Tommy Choe on 10/25/15.
//  Copyright © 2015 Tommy Choe. All rights reserved.
//

import Foundation

struct ForecastService{
    let forecastBaseURL: NSURL?
    let forecastAPI: String
    
    init(APIkey: String){
        forecastAPI = APIkey
        forecastBaseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPI)/")
    }
    
    func getForecast(lat: Double, long:Double, completion: (Forecast? -> Void)){
        if let forecastURL = NSURL(string: "\(lat),\(long)", relativeToURL: forecastBaseURL){
            let networkOperation = NetworkOperation(url: forecastURL)
            print("Connected to network with \(lat) and \(long)")
            networkOperation.downloadJSONFromURL { (let JSONDictionary) in
                let forecast = Forecast(weatherDictionary: JSONDictionary)
                print("Getting JSON data")
                completion(forecast)
            }
        } else{
            print("Could not construct a valid URL")
        }
    }
}


