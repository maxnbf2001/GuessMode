//
//  ViewController.swift
//  ClassModeMinutes
//
//  Created by Max's Macbook on 8/15/18.
//  Copyright © 2018 Max Breslauer-Friedman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var actualLabel: UILabel!
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var phraseImage: UIImageView!

    @IBOutlet weak var hoursTextField: UITextField!
    @IBOutlet weak var minutesTextField: UITextField!
    
    var realTotal = 144
    var points = 0
    var dateString = " "
    var guessTime = 0
    var score = 0
    var buttonDay = 0
    var buttonMonth = 0
    var highScoreString = " "
    var thisScoreString = " "
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //retrieves the high score and the corresponding date
        let userDefaults = Foundation.UserDefaults.standard
        score = userDefaults.integer(forKey: "Key")
        let userDefaults2 = Foundation.UserDefaults.standard
        let scoreDate = userDefaults2.string(forKey: "Key2")
        
        //retrieves the day and month from when the submit button was last clicked
        let dayDefaults = Foundation.UserDefaults.standard
        buttonDay = dayDefaults.integer(forKey: "dayKey")
        let monthDefaults = Foundation.UserDefaults.standard
        buttonMonth = monthDefaults.integer(forKey: "monthKey")
        
        let historyDefaults = Foundation.UserDefaults.standard
        let thisScoreStringTemp = historyDefaults.string(forKey: "historyKey")
        thisScoreString = "\(thisScoreStringTemp ?? "")"
        
        //finds today's date
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from:date)
        let month = calendar.component(.month, from:date)
        
        //controls the submit button so it can only be clicked once a day
        if (!(day > buttonDay || month > buttonMonth))
        {
            submitButton.isEnabled = false
        }
        
        //displays the highscore and the corresponding date
        highScoreString = "\(score) point(s) scored on " + "\(scoreDate ?? "")"
        // Do any additional setup after loading the view, typically from a nib.
    }

    //passes the high score over to the second view controller
    @IBAction func myStatsPressed(_ sender: Any) {
        performSegue(withIdentifier: "segue", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var secondController = segue.destination as! SecondViewController
        secondController.highString = highScoreString
        secondController.scoreOne = thisScoreString
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.hoursTextField.delegate = self
        self.minutesTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //exits the keyboard when the screen is touched on anything but the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //exits keyboard when return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hoursTextField.resignFirstResponder()
        minutesTextField.resignFirstResponder()
        return  (true)
    }
    
    @IBAction func submitTapped(_ sender: Any)
    {
        actualLabel.text = ""
        guessLabel.text = ""
        dateLabel.text = ""
        phraseImage.image = UIImage(named: "whiteImage")
        //makes sure numbers are within range and accept criteria
        if (isNumeric(str: hoursTextField.text!) == false || isNumeric(str: minutesTextField.text!) == false){
            pointsLabel.text = "Please enter numeric values"
        }
        else if (Int(hoursTextField.text!)! > 23){
            pointsLabel.text = "Hours must be between 0 and 23"
        }
        else if Int(minutesTextField.text!)! > 59 {
             pointsLabel.text = "Minutes must be between 0 and 59"
        }
        else if (Int(hoursTextField.text!)! < 0){
            pointsLabel.text = "Hours must be a positive number"
        }
        else if Int(minutesTextField.text!)! < 0 {
            pointsLabel.text = "Minutes must be a positive number"
        }
        else {
            //IF THE INPUT IS VALID THE REST OF THE CODE IS PERFORMED IN THIS ELSE BLOCK TO FINISH THE DESIRED TASK
            
            //retrieves the information from the textbox in integer form
            let hours = Int(hoursTextField.text!)
            let minutes = Int(minutesTextField.text!)
            
            //formula used to determine the points that the user will receive
            var total = hours!*60 + minutes!
            var diff = abs(realTotal - total)
            var exp = Double((0-diff+175))/Double(175)
            points = Int(pow(1000, exp))
            
            
            //retrieves the necessary information to display the date
            let date = Date()
            let calendar = Calendar.current
            let day = calendar.component(.day, from:date)
            let month = calendar.component(.month, from:date)
            let year = calendar.component(.year, from:date)
            dateString = String("\(month)/\(day)/\(year)")
            
            
            //disables the button once it is clicked
            submitButton.isEnabled = false
            
            //displays the date of the guess
            dateLabel.text = String(dateString)
            
            //converts the actual time in minutes to hours and minutes
            var realTotalTemp = realTotal
            var realHours = 0
            var realMinutes = 0
            while (realTotalTemp >= 60)
            {
                realHours+=1
                realTotalTemp-=60
            }
            realMinutes+=realTotalTemp
            
            var actualString = "Actual time: " + "\(realHours) hour"
            if (realHours != 1){
                actualString += "s"}
            actualString += " and " + "\(realMinutes) minute"
            if (realMinutes != 1){
                actualString += "s"}
            
            var guessString = "Your guess: " + "\(hours ?? 0) hour"
            if (hours != 1){
                guessString += "s"}
            guessString += " and " + "\(minutes ?? 0) minute"
            if (minutes != 1){
                guessString += "s"}
            
            //displays the actual time spent on phone, the guess, and the points given based on the accuracy of the guess
            actualLabel.text = actualString
            guessLabel.text = guessString
            pointsLabel.text = "Points scored: " + "\(points)"
            
        
            var thisScoreTemp = ""
            thisScoreTemp += "\(dateString ?? "")"
            if (day < 10){
                thisScoreTemp += " "}
            if (month < 10){
                thisScoreTemp += " "}
            thisScoreTemp += "    " + "\(realHours)h\(realMinutes)m"
            if (realHours < 10){
                thisScoreTemp += " "
            }
            if (realMinutes < 10){
                thisScoreTemp += " "
            }
            thisScoreTemp += "            " + "\(hours ?? 0)h\(minutes ?? 0)m"
            if (hours! < 10){
                thisScoreTemp += " "
            }
            if (minutes! < 10){
                thisScoreTemp += " "
            }
            if (points < 10){
                thisScoreTemp += " "}
            if (points < 100){
                thisScoreTemp += " "
            }
            if (points < 1000){
                thisScoreTemp += " "
            }
            thisScoreTemp += "       " + "\(points)"
            thisScoreTemp += "\n"
            thisScoreTemp += thisScoreString
            thisScoreString = thisScoreTemp
            
            let historyDefaults = Foundation.UserDefaults.standard
            historyDefaults.set(thisScoreString, forKey: "historyKey")
           
            //stores todays month and day which is used in the disabling of the button
            let dayDefaults = Foundation.UserDefaults.standard
            dayDefaults.set(day, forKey: "dayKey")
            let monthDefaults = Foundation.UserDefaults.standard
            monthDefaults.set(month, forKey: "monthKey")
            
            //processes which image to display based on the score
            if (points > 800){
                phraseImage.image = UIImage(named: "awesomeImage")
            }else if (points > 600){
                phraseImage.image = UIImage(named: "greatImage")
            }else if (points > 400){
                phraseImage.image = UIImage(named: "goodImage")
            }else if (points > 200){
                phraseImage.image = UIImage(named: "mehImage")
            }else if (points > 20){
                phraseImage.image = UIImage(named: "betterLuckImage")
            }else if (points >= 0){
                phraseImage.image = UIImage(named: "awfulImage")
            }
            
            //stores the highest score and the corresponding date
            if (points >= score)
            {
                let highScore = points
                let userDefaults = Foundation.UserDefaults.standard
                userDefaults.set(highScore, forKey: "Key")
                let userDefaults2 = Foundation.UserDefaults.standard
                let finalDate = dateString
                userDefaults2.set(finalDate, forKey: "Key2")
                highScoreString = "\(points) point(s) scored on " + "\(dateString ?? "")"
            }
            
        }
     
    }
    
    //checks if a string is numeric
    func isNumeric (str: String) -> Bool {
        var isInt: Bool {
            return Int(str) != nil
        }
        return isInt
    }
    

}

