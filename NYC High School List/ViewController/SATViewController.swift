//
//  File.swift
//  NYC High School List
//
//  Created by john ledesma on 10/1/18.
//  Copyright © 2018 john ledesma. All rights reserved.
//

import UIKit

class SATViewController: UIViewController {
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var numOfTestTakersLabel: UILabel!
    @IBOutlet weak var criticalReadingScoreLabel: UILabel!
    @IBOutlet weak var mathsScoreLabel: UILabel!
    @IBOutlet weak var writingScoreLabel: UILabel!
    @IBOutlet weak var dbnLabel: UILabel!
    
    // MARK: - Properties
    
    // SATViewModel
    var satViewModel: SATViewModel!
    
    // MARK: - SATViewController lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabels()
        // Do any additional setup after loading the view.
    }
    
}

// MARK: - SATViewController setup methods

extension SATViewController {
    
    func setLabels(){
        DispatchQueue.main.async {
            self.dbnLabel.text = "DBN: \(self.satViewModel.satDataForSchool.dbn ?? "666")"
            self.schoolNameLabel.text = "Name: \(self.satViewModel.satDataForSchool.school_name ?? "None")"
            self.numOfTestTakersLabel.text = "Number of Test Takers: \(self.satViewModel.satDataForSchool.num_of_sat_test_takers ?? "0")"
            self.criticalReadingScoreLabel.text = "Critical Reading Average Score: \(self.satViewModel.satDataForSchool.sat_critical_reading_avg_score ?? "0")"
            self.mathsScoreLabel.text = "Maths Average Score: \(self.satViewModel.satDataForSchool.sat_math_avg_score ?? "0")"
            self.writingScoreLabel.text = "Writing Average Score: \(self.satViewModel.satDataForSchool.sat_writing_avg_score ?? "0")"
            
        }
    }
}
