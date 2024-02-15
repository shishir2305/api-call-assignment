//
//  ApiDetailVC.swift
//  api call assignment
//
//  Created by Promact on 15/02/24.
//

import UIKit

class ApiDetailVC: UIViewController {
    
    var dataStore: [String: Any]?
    
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var activityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showFilledData()
        
    }
    
        func showFilledData() {
            guard let dataStore = dataStore else {
                return
            }
            
//            typeLabel.text = dataStore["type"] as? String ?? "Unknown"
//            activityLabel.text = dataStore["activity"] as? String ?? "Unknown"
            
            typeLabel.numberOfLines = 0
            typeLabel.lineBreakMode = .byWordWrapping
            typeLabel.text = dataStore["type"] as? String ?? "Unknown"

            // For activityLabel
            activityLabel.numberOfLines = 0
            activityLabel.lineBreakMode = .byWordWrapping
            activityLabel.text = dataStore["activity"] as? String ?? "Unknown"

        }
    
}
