//
//  File.swift
//  NYC High School List
//
//  Created by john ledesma on 10/1/18.
//  Copyright © 2018 john ledesma. All rights reserved.
//

import UIKit

// This is an enum for storing all the URLs required for API calls in string format
enum UrlStrings: String{
    ///- URL for all schools; 1st screen
    case schoolURLString = "https://data.cityofnewyork.us/resource/97mf-9njv.json"
    
    ///- URL for SAT scores of all schools; 2nd screen
    case satURLString = "https://data.cityofnewyork.us/resource/734v-jeq5.json"
}

struct ViewControllerNames{
    static let satViewController = "SATViewController"
}

struct TableViewCellIdentifiers{ 
    static let schoolCell = "SchoolCell"
}
