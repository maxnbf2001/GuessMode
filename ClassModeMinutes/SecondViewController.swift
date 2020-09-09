//
//  SecondViewController.swift
//  ClassModeMinutes
//
//  Created by Max's Macbook on 8/29/18.
//  Copyright © 2018 Max Breslauer-Friedman. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var scoreOneLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    var highString = String()
    var scoreList = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = highString
        
        scoreOneLabel.text = scoreList
        scoreOneLabel.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
