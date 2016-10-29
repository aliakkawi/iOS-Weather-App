//
//  Constants.swift
//  Weather Animation App
//
//  Created by Ali Akkawi on 26/10/2016.
//  Copyright © 2016 Ali Akkawi. All rights reserved.
//

import Foundation


let URL_BASE = "http://api.openweathermap.org/data/2.5/forecast?lat="
let BETWEEN = "&lon="
let AFTER_CITY_COORD = "&units=metric&mode=json&appid=e8cd4e3500ef2a12eeae71123f949871"

typealias DownloadComplete = () -> ()
