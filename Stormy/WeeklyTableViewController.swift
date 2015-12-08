//
//  WeeklyTableViewController.swift
//  Stormy
//
//  Created by Tommy Choe on 10/27/15.
//  Copyright © 2015 Tommy Choe. All rights reserved.
//

import UIKit

class WeeklyTableViewController: UITableViewController {
    @IBOutlet weak var currentTemperatureLabel: UILabel?
    @IBOutlet weak var currentWeatherIcon: UIImageView?
    @IBOutlet weak var currentRangeLabel: UILabel?
    @IBOutlet weak var currentPrecipLabel: UILabel?
    
    private let forecastAPIKey = "cc487e3a84a1e5b692482a1b0f6078d2"
    let coordinate: (lat: Double, long: Double) = (39.401496,-76.601913)

    var weeklyWeather: [DailyWeather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        retrieveWeatherForecast()
    }
    
    func configView() {
        
        //Setting the table view's row height
        tableView.rowHeight = 64
        //Setting the Background view
        tableView.backgroundView = BackgroundView()
        if let navBarFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0){
            let navBarAttributesDictionary: [String: AnyObject]? = [
                NSForegroundColorAttributeName: UIColor.whiteColor(),
                NSFontAttributeName: navBarFont]
            navigationController?.navigationBar.titleTextAttributes = navBarAttributesDictionary
        }
        refreshControl?.layer.zPosition = tableView.backgroundView!.layer.zPosition + 1
        refreshControl?.tintColor = UIColor.whiteColor()
    }

    @IBAction func refreshWeather() {
        retrieveWeatherForecast()
        refreshControl?.endRefreshing()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Forecast"
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyWeather.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell") as! DailyWeatherTableViewCell
        
        let dailyWeather = weeklyWeather[indexPath.row]
        if let maxTemp = dailyWeather.maxTemperature{
            cell.temperatureLabel.text = "\(maxTemp)º"
        }
        cell.weatherIcon.image = dailyWeather.icon
        cell.dayLabel.text = dailyWeather.day
        
        return cell
    }
    
    //MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDaily"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let dailyWeather = weeklyWeather[indexPath.row]
                (segue.destinationViewController as! DailyWeatherViewController).dailyWeather = dailyWeather
            }
        }
    }
    
    
    //MARK: - Delegate Methods
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 170/255.0, green: 131/255.0, blue: 224/255.0, alpha: 1.0)
        
        if let header = view as? UITableViewHeaderFooterView{
            header.textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 14.0)
            header.textLabel?.textColor = UIColor.whiteColor()
        }
    }
    
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.contentView.backgroundColor = UIColor(red: 165/255.0, green: 142/255.0, blue: 203/255.0, alpha:
            1.0)
        let highlightView = UIView()
        highlightView.backgroundColor = UIColor(red: 165/255.0, green: 142/255.0, blue: 203/255.0, alpha: 1.0)
        cell?.selectedBackgroundView = highlightView
    }
    
    //MARK: - Retrieve Weather
    
    func retrieveWeatherForecast(){
        
        let forecastService = ForecastService(APIkey: forecastAPIKey)
        forecastService.getForecast(coordinate.lat, long: coordinate.long){
            (let forecast) in
            if let weatherForecast = forecast,
                let currentWeather = weatherForecast.currentWeather{
                dispatch_async(dispatch_get_main_queue()){
                    if let temperature = currentWeather.temperature{
                        self.currentTemperatureLabel?.text = "\(temperature)º"
                    }
                    if let precipProbability = currentWeather.precipProbability{
                        self.currentPrecipLabel?.text = "Rain: \(precipProbability)%"
                    }
                    if let icon = currentWeather.icon{
                        self.currentWeatherIcon?.image = icon
                    }
                    self.weeklyWeather = weatherForecast.weekly
                    if let highTemp = self.weeklyWeather.first?.maxTemperature,
                        let lowTemp = self.weeklyWeather.first?.minTemperature{
                            self.currentRangeLabel?.text = "↑\(highTemp)↓\(lowTemp)"
                    }
                    self.tableView.reloadData()
                    
                }
            }
        }
        
        
    }

}
