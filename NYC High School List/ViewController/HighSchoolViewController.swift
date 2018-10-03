//
//  File.swift
//  NYC High School List
//
//  Created by john ledesma on 10/1/18.
//  Copyright © 2018 john ledesma. All rights reserved.
//

import UIKit

class HighSchoolViewController: UIViewController {
   
    @IBOutlet weak var schoolTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    
    // SchoolViewModel
    let schoolViewModel = SchoolViewModel()
   
    //to indicate if we are currently searching a school
    var searchFlag: Bool = false
    
    let refreshControl = UIRefreshControl()
    
    // MARK: - HighSchoolViewController lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schoolTableView.estimatedRowHeight = 200
        schoolTableView.tableFooterView = UIView(frame: .zero)

        setupTableViewDataSource()
        getSATDataForAllSchools()
        setupRefreshControl()
    
    }
    
    // MARK: - HighSchoolViewController setup methods
    
    /**
     This function will receive the array of SchoolModel objects from the corresponding singleton class function and store it in schoolsArray and reload the table view in the main queue
     */
    @objc func setupTableViewDataSource() {
        
        //        SchoolViewModel.schoolDataArray.removeAll()
        schoolViewModel.getSchoolData { [unowned self] (obtainedSchoolArr) in
            
            //if no schools to show then display alert view with error
            if obtainedSchoolArr.count == 0{
                self.alertView(message: "No Schools to Show")
            }
            
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                //reload the table view
                self.schoolTableView.reloadData()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// Mark: HighSchoolViewController UITableViewDelegate, UITableViewDataSource & UISearchBarDelegate

extension HighSchoolViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    func setupRefreshControl() {
        
        refreshControl.isEnabled = true
        refreshControl.tintColor = UIColor.black
        refreshControl.addTarget(self, action: #selector(setupTableViewDataSource), for: .valueChanged)
        //refreshAction method down below
        schoolTableView.addSubview(refreshControl)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        schoolViewModel.searchResults(searchText: searchText)
        searchFlag = true
        schoolTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchFlag = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        schoolTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchFlag == true{
            return schoolViewModel.searchedSchoolDataArray.count
        }
        else{
            return schoolViewModel.schoolDataArray.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.schoolCell)
        if searchFlag == true{
            cell?.textLabel?.text = schoolViewModel.searchedSchoolDataArray[indexPath.row].school_name
            cell?.detailTextLabel?.text = schoolViewModel.searchedSchoolDataArray[indexPath.row].borough
        }else{
            cell?.textLabel?.text = schoolViewModel.schoolDataArray[indexPath.row].school_name
            cell?.detailTextLabel?.text = schoolViewModel.schoolDataArray[indexPath.row].borough
        }
        return cell!
    }
    
    /**
     This function will receive the array for all the schools' SAT stats from the corresponding singleton class function and store it in satArray
     */
    func getSATDataForAllSchools(){
        schoolViewModel.getSATData {(obtainedSATArr) in
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var selectedArray: Array<School> = []
        
        if searchFlag == true{
            selectedArray = schoolViewModel.searchedSchoolDataArray
        }else{
            selectedArray = schoolViewModel.schoolDataArray
        }
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: ViewControllerNames.satViewController) as? SATViewController{
           
            let filteredObj = schoolViewModel.satDataArray.filter {$0.dbn == selectedArray[indexPath.row].dbn}
            if filteredObj.count > 0 {
                
                let satModel = SATViewModel(model: filteredObj.first!)
                controller.satViewModel = satModel
                navigationController?.pushViewController(controller, animated: true)
            } else {
                self.alertView(message: "School Not Found")
            }
        }
    }
}
