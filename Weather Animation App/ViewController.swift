//
//  ViewController.swift
//  Weather Animation App
//
//  Created by Ali Akkawi on 26/10/2016.
//  Copyright © 2016 Ali Akkawi. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var topimageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var cityAndCountryName: UILabel!
    let locationManager = CLLocationManager()
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temepratureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    
    @IBOutlet weak var minTemperatureLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var todaysTemp = 0.0
    var todaysHightTemp = 0.0
    var todaysLowTemp = 0.0
    var todaysShortDescription = ""
    var todaysFullDescription = ""
    
    
    var theTempArray = [Double]()
    var theMaxTempArray = [Double]()
    var theMinTempArray = [Double]()
    var theWeatherMainArray = [String]()
    var theDescriptionArray = [String]()
    
    var theSubMaxTempArray = [Double]()
    var theSubMinTempArray = [Double]()
    var theSubWeatherMainArray = [String]()
    var theSubDescriptionArray = [String]()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
                
        

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theSubMaxTempArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        
        
        cell.maxTemperatureLabel.text = "\(theSubMaxTempArray[indexPath.row])°"
        cell.minTemperatureLabel.text = "\(theSubMinTempArray[indexPath.row])°"
        cell.weatherDescriptionLabel.text = theSubDescriptionArray[indexPath.row]
        
        let desc = theSubWeatherMainArray[indexPath.row]
        // update the mini imageview.
        
        
        switch desc{
            
        case "Clear":
            
            cell.eatherImageView.image = UIImage(named: "Clear Mini")
            
            
        case "Rain":
            
            cell.eatherImageView.image = UIImage(named: "Rain Mini")
            
        case "Clouds":
            
            cell.eatherImageView.image = UIImage(named: "Clouds Mini")
            
            
        case "Snow":
            
            cell.eatherImageView.image = UIImage(named: "Snow Mini")
            
        case "Thunderstorm":
            
            cell.eatherImageView.image = UIImage(named: "Thunderstorm Mini")
            
        case "Partially Cloudy":
            
            cell.eatherImageView.image = UIImage(named: "Partially Cloudy Copy")
            
            
            
            
        default:
            
            cell.eatherImageView.image = UIImage(named: "Snow")
            
            
            
        }
        
        
        
        return cell
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation: CLLocation = locations[0]
        latitude = userLocation.coordinate.latitude
        longitude = userLocation.coordinate.longitude
        
        print("lat: \(latitude), lng: \(longitude)")
        
        // we need to empty our array each time the location is updated.
        
        let city = City(_latitude: latitude, _longitude: longitude)
        
        self.theTempArray.removeAll(keepingCapacity: true)
        self.theMinTempArray.removeAll(keepingCapacity: true)
        self.theMaxTempArray.removeAll(keepingCapacity: true)
        self.theDescriptionArray.removeAll(keepingCapacity: true)
        self.theWeatherMainArray.removeAll(keepingCapacity: true)
        
        
        self.theSubMinTempArray.removeAll(keepingCapacity: true)
        self.theSubMaxTempArray.removeAll(keepingCapacity: true)
        self.theSubDescriptionArray.removeAll(keepingCapacity: true)
        self.theSubWeatherMainArray.removeAll(keepingCapacity: true)
        
        city.downloadPokemonDetails{
            print("We are here")
            
            
            self.theTempArray = city._tempArray
            self.theMinTempArray = city._minArray
            self.theMaxTempArray = city._maxArray
            self.theDescriptionArray = city._weatherDescriptionArray
            self.theWeatherMainArray = city._weatherShortDescriptionArray
            
            
            
            
            // load the sub arrays with data.
            
            for i in 1..<self.theMaxTempArray.count{
                
                self.theSubMaxTempArray.append(self.theMaxTempArray[i])
                self.theSubMinTempArray.append(self.theMinTempArray[i])
                self.theSubDescriptionArray.append(self.theDescriptionArray[i])
                self.theSubWeatherMainArray.append(self.theWeatherMainArray[i])
                
            }
            
            print("Sub array count: \(self.theSubMaxTempArray.count)")
            

            
            self.todaysTemp = city._tempArray.first!
            self.todaysHightTemp = city._maxArray.first!
            self.todaysLowTemp = city._minArray.first!
            self.todaysShortDescription = city._weatherShortDescriptionArray.first!
            self.todaysFullDescription = city._weatherDescriptionArray.first!
            
            
            // update todays ui.
            
            
            self.updateWeatherImage(description: self.todaysShortDescription, imageView: self.weatherImageView)
            self.updateWeatherImage(description: self.todaysShortDescription, imageView: self.topimageView)
            self.temepratureLabel.text = "\(Int(self.todaysTemp))°"
            self.maxTemperatureLabel.text = "\(Int(self.todaysHightTemp))°"
            self.minTemperatureLabel.text = "\(Int(self.todaysLowTemp))°"
            self.cityAndCountryName.text =  "\(city.cityname), \(city.country)"
            self.weatherDescriptionLabel.text = self.todaysFullDescription
            
            
            
            
            self.tableView.reloadData()
            
        }
    }
    
    
    func updateWeatherImage (description: String, imageView: UIImageView){
        
        
        
        switch description{
            
            case "Clear":
            
            imageView.image = UIImage(named: "Clear")
            
            
            case "Rain":
            
            imageView.image = UIImage(named: "Rain")
            
            case "Clouds":
            
            imageView.image = UIImage(named: "Clouds")
            
            
            case "Snow":
            
            imageView.image = UIImage(named: "Snow")
            
        case "Thunderstorm":
            
            imageView.image = UIImage(named: "Thunderstorm")
            
            
        case "Partially Cloudy":
            
            imageView.image = UIImage(named: "Partially Cloudy")
            
            
            
            
        default:
            
            imageView.image = UIImage(named: "Snow")
            
            
            
        }
        
    }

    


}

