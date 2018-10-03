//
//  ApiClient .swift
//  NYC High School List
//
//  Created by john ledesma on 10/1/18.
//  Copyright © 2018 john ledesma. All rights reserved.
//

import Foundation

/**
With more time I would have Abstract The ApiClient into a protocol. Avoid using Singletons
Given more time I would create better cases that handle error handling. also using a linter would help with introducing less bugs.
 Testing the app with unit. 
*/

class ApiClient: NSObject {
    
    private override init() {}
    static let sharedInstance = ApiClient()
    
    /**
     This function takes in a URL and obtains data doing an API call using URLSession
     */
    func getData(urlAPI: URL, completion: @escaping (Data?) -> ()){ // different
        
        URLSession.shared.dataTask(with: urlAPI) { (data, response, error) in
            if error != nil{
                print("Error occurred while obtianing response from schoolURL\n")
                completion(nil)
            }else{
                //Data has been successfully obtained, hence pass it in the completion handler
                completion(data!)
                
            }
            
            }.resume()
    }
    
    /**
     This function will receive the data from the API for schools in New York and store it in an array of SchoolModel. It will return this array in the completion handler.
     */
    func getSchoolData(data: Data?, completion: @escaping(Array<School>) -> ()){ // some what different
        if let usableSchoolData = data{
            do{
                if let jsonObject = try JSONSerialization.jsonObject(with: usableSchoolData, options: .mutableContainers) as? Array<Dictionary<String, Any>>
                {
                    print("School JSON object obtained has: \(jsonObject.count) members")
                    
                    //iterating through the array of dictionaries obtained from the API call using for..in
                    var schoolDataArray = [School]()
                    for schoolDict in jsonObject{
                        let schoolData = School()    //model object to store relevant details of school
                        
                        schoolData.school_name = schoolDict["school_name"] as? String ?? "Unavailable school"
                        schoolData.borough = schoolDict["borough"] as? String ?? "No state"
                        schoolData.dbn = schoolDict["dbn"] as? String ?? "666"
                        
                        schoolDataArray.append(schoolData)    //adding the SchoolModel object to the array. This array will be finally displayed in the table view
                    }
                    print("Array for the schools has: \(schoolDataArray.count) schools\n")
                    completion(schoolDataArray)
                }
                
            }catch{
                print("Caught an error in obtaining JSONSerialised data")
            }
        }
        
    }
    
    /**
     This function will receive the data from the API for SAT stats for schools in New York and store it in an array of SATScores. It will return this array in the completion handler.
     */
    func getSATData(data: Data?, completion: @escaping(Array<SATScore>) -> ()){ // some what the same
        if let usableSATData = data{
            do{
                let satModelInfoArray = try JSONDecoder().decode(Array<SATScore>.self, from: usableSATData)
                print("Number of schools with valid SAT stats are: \(satModelInfoArray.count)\n")
                completion(satModelInfoArray)
                
            }catch{
                print("Problem with obtaining data from JSONDecoder")
                completion([])
            }
        }
        
    }
    
}
