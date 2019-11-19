//
//  ViewController.swift
//  Find week
//
//  Created by Admin on 18.11.2019.
//  Copyright © 2019 ar_ko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var resultLabel: UILabel!
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = findWeek()
    }
        
    
    @IBAction func rollDatePicker(_ sender: UIDatePicker) {
        resultLabel.text = findWeek(sender.date)
  
    }
    
    // MARK: Установка даты начала отсчета
    func getStartDate() -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        
        dateComponents.day = 2
        dateComponents.month = 9
        dateComponents.year = 2019
        let date = calendar.date(from: dateComponents)
        
        return date!
    }
    
    func findWeek(_ date:Date = Date()) -> String {
        var result:String = ""
        
        let diffInDays = Calendar.current.dateComponents([.day], from: getStartDate(), to: date).day
        resultLabel.text = String(diffInDays!)
        
        let numberOfWeek = diffInDays! / 7
        
        switch numberOfWeek % 2 {
        case 0:
            result = "White week"
        default:
            result = "Blue week"
        }
        
        return result
    }
}

