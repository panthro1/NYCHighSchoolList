//
//  File.swift
//  NYC High School List
//
//  Created by john ledesma on 10/1/18.
//  Copyright © 2018 john ledesma. All rights reserved.
//

import UIKit

extension UIViewController {
    //Alert view for indicating errors
    func alertView(message: String){
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}
