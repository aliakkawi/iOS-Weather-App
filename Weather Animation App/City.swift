//
//  City.swift
//  Weather Animation App
//
//  Created by Ali Akkawi on 26/10/2016.
//  Copyright © 2016 Ali Akkawi. All rights reserved.
//

import Foundation
import Alamofire



class City {
    
    
    
    private var _latitude: Double
    private var _longitude: Double
    private var _cityName: String!
    private var _country: String!
    private var _url: String!
    var _date = [String]()
    var _tempArray = [Double]()
    var _maxArray = [Double]()
    var _minArray = [Double]()
    var _weatherShortDescriptionArray = [String]()
    var _weatherDescriptionArray = [String]()
    
    
    
    
    
    
    
    var latitude: Double {
        
        get {
            
            return self._latitude
        }
    }
    
    
    var longitude: Double {
        
        get {
            
            
            return self._longitude
        }
    }
    
    
    
    var cityname: String {
        
        get {
            
            
            return self._cityName
        }
        
    }
    
    
    var country: String{
        
        
        get {
            
            return self._country
        }
    }
    
    var url: String {
        
        get {
            
            
            return self._url
        }
        
        
    }
    
    
    
    
    init (_latitude: Double, _longitude: Double){
        
        self._latitude = _latitude
        self._longitude = _longitude
        self._url = "\(URL_BASE)\(_latitude)\(BETWEEN)\(_longitude)\(AFTER_CITY_COORD)"
        self._tempArray = []
        self._maxArray = []
        self._minArray = []
        self._weatherShortDescriptionArray = []
        self._weatherDescriptionArray = []
        self._date = []
        
        
    }
    
    
    func downloadPokemonDetails (completed: @escaping DownloadComplete) {
        
        Alamofire.request(_url).responseJSON { (response) in
            
            let request = response.result.value
            
            if let dict = request as? Dictionary<String, AnyObject> {
                
                
                if let city = dict["city"] as? Dictionary<String, AnyObject> {
                    
                    if let theCountry = city["country"] as? String, let theCityName = city["name"] as? String{
                    self._country = theCountry
                    self._cityName = theCityName
                        
                    }
                    
                }
                
                
                
                // the temperature  is inside the list , wich is an array, each element is every 3 hours.
                // lets try to grap the first.
                
                
                if let theList = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    
                    // we need the first element of the array wich is the next 3 hours.
                    
                    print("Array count: \(theList.count)")
                    
                    
                    /*
                    // testing the first element of the array.
                     let firstItem = theList[0] // the first item is actually a dictionary.
                    
                    
                    
                    // lets grap the temp witch is inside the main.
                    // the main is actually a dictionary
                    
                    if let main = firstItem["main"] as? Dictionary<String, AnyObject>{
                        
                        if let temperature = main["temp"] as? Double {
                            
                            
                            print("Temperature: \(temperature)")
                            
                        }
                        
                        
                    }  */
                    
                    
                    // we are not interested in the hours, we need the days, so we need once a day, the api give us every 3 hours. which means 8 times a day.
                    var i = 0
                    
                    print("List count: \(theList.count)")
                    if theList.count > 0 {
                    repeat {
                        
                        
                        let day = theList[i]
                        
                        
                        // get the date.
                        
                        if let date = day ["dt"] as? Double{
                            
                            
                            // Date formatting.
                            
                            let unixConvertedDate = Date(timeIntervalSince1970: date)
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateStyle = .full
                            dateFormatter.dateFormat = "EEEE"
                            dateFormatter.timeStyle = .none
                            
                            self._date.append(unixConvertedDate.dayOfTheWeek())
                            print("date: \(self._date)")
                            
                        }
                        
                        
                        // get the temperatures.
                        
                        if let main = day["main"] as? Dictionary<String, AnyObject>{  // get the main from each and every day.
                            
                            if let temperature = main["temp"] as? Double, let minTemperature = main["temp_min"] as? Double, let maxTemperature = main["temp_max"] as? Double {
                                
                                
                                
                                
                                self._tempArray.append(temperature)
                                self._minArray.append(minTemperature)
                                self._maxArray.append(maxTemperature)
                                
                                
                                print("Temp: \(temperature)")
                                print("Tempmax: \(maxTemperature)")
                                print("Tempmin: \(minTemperature)")
                                
                            }
                            
                            
                        }
                        
                        
                        // get the weather type for each day.
                        
                        
                        
                        if let weatherType = day["weather"] as? [Dictionary<String, AnyObject>]{ // the weather is an array of dictionary that has only one item :  weired!!!.
                            
                            
                             let weatherFirstItem = weatherType[0]
                            
                            if let weatherMain = weatherFirstItem["main"] as? String{
                                
                                
                                self._weatherShortDescriptionArray.append(weatherMain)
                            }
                                
                            if let weatherDescription = weatherFirstItem["description"] as? String{
                                
                                
                                self._weatherDescriptionArray.append(weatherDescription)
                            }
                                
                            
                        }
                        
                        
                        i += 8
                        
                    }while(i < theList.count)
                    
                    
                }
                
            }
                
                
                
            }
            completed()
        }
        
        
        
        
        
    }
    
    
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
