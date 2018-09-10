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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
