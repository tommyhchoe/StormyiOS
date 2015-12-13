//
//  ViewController.swift
//  Stormy
//
//  Created by Tommy Choe on 10/24/15.
//  Copyright © 2015 Tommy Choe. All rights reserved.
//


import UIKit

class DailyWeatherViewController: UIViewController {

    var dailyWeather: DailyWeather?{
        didSet{
            configureView()
        }
    }
    @IBOutlet weak var weatherIcon: UIImageView?
    @IBOutlet weak var summaryLabel: UILabel?
    @IBOutlet weak var sunriseTimeLabel: UILabel?
    @IBOutlet weak var sunsetTimeLabel: UILabel?
    @IBOutlet weak var lowTemperatureLabel: UILabel?
    @IBOutlet weak var highTemperatureLabel: UILabel?
    @IBOutlet weak var precipitationLabel: UILabel?
    @IBOutlet weak var humidityLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView(){
        if let weather = dailyWeather {
            
            //Update UI with information from the data model
            weatherIcon?.image = weather.largeIcon
            summaryLabel?.text = weather.summary
            sunriseTimeLabel?.text = weather.sunriseTime
            sunsetTimeLabel?.text = weather.sunsetTime
            
            if let lowTemp = weather.convertedMinScale,
                let highTemp = weather.convertedMaxScale,
                let rain = weather.precipProbability,
                let humidity = weather.humidity{
                    lowTemperatureLabel?.text = "\(lowTemp)º"
                    highTemperatureLabel?.text = "\(highTemp)º"
                    precipitationLabel?.text = "\(rain)%"
                    humidityLabel?.text = "\(humidity)%"
            }
            
            self.title = weather.day
        }
        
        //Configure the nav bar back button
        if let buttonFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0){
            let barButtonAttributesDictionary: [String: AnyObject]? = [
                NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSFontAttributeName: buttonFont]
            UIBarButtonItem.appearance().setTitleTextAttributes(barButtonAttributesDictionary, forState: .Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}










