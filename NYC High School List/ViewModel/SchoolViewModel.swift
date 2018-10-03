//
//  SchoolViewModel.swift
//  NYC High School List
//
//  Created by john ledesma on 10/3/18.
//  Copyright © 2018 john ledesma. All rights reserved.
//

import Foundation

class SchoolViewModel: NSObject {
   
    //stores the array of SchoolModel objects in View Model
    var schoolDataArray: [School] = []
    
    //stores the array of SATModel objects in View Model
    var satDataArray: Array<SATScore> = []
    
     //stores results of the searched schools as an array of SchoolModel objects in View Model
    var searchedSchoolDataArray: [School] = []
    
    //converting strings to URL for use with URLSession
    let schoolURL = URL(string: UrlStrings.schoolURLString.rawValue)
    let satURL = URL(string: UrlStrings.satURLString.rawValue)
    
}

extension SchoolViewModel {
    
    func getSchoolData(completion: @escaping (Array<School>)->()){
        
        ApiClient.sharedInstance.getData(urlAPI: schoolURL!) {[unowned self] (schoolData) in
            
            ApiClient.sharedInstance.getSchoolData(data: schoolData, completion: { [unowned self] (schoolArr) in
                self.schoolDataArray = schoolArr
                completion(self.schoolDataArray)
            })
        }
    }
    
    func getSATData(completion: @escaping (Array<SATScore>) -> ()){
        
        ApiClient.sharedInstance.getData(urlAPI: satURL!) {[unowned self] (satData) in
            
            ApiClient.sharedInstance.getSATData(data: satData, completion: { [unowned self] (satArr) in
                self.satDataArray = satArr
                completion(self.satDataArray)
            })
        }
        
    }
    
    func searchResults(searchText: String){
        searchedSchoolDataArray = schoolDataArray.filter({$0.school_name!.prefix(searchText.count) == searchText})
    }
}
