//
//  ViewController.swift
//  Find week
//
//  Created by Admin on 18.11.2019.
//  Copyright © 2019 ar_ko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var startDateButton: UIButton!
    
   
    override func viewDidLoad() {

        super.viewDidLoad()
        datePicker.minimumDate = getStartDate()
        resultLabel.text = findWeek()
    }
    
    
    @IBAction func rollDatePicker(_ sender: UIDatePicker) {
       
        resultLabel.text = findWeek(sender.date)
    }
    
    // MARK: Установка даты начала отсчета
    func getStartDate() -> Date? {
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        
        dateComponents.day = 2
        dateComponents.month = 9
        dateComponents.year = 2019
        
        guard let date = calendar.date(from: dateComponents) else {
            return nil
        }
        
        return date
    }
    
    // MARK: Узнаем четная неделя или нет
    func findWeek(_ date:Date = Date()) -> String {
        
        let calendar = Calendar.current
        var result = String()
        
        guard let startDate = getStartDate() else {
            return "StartDate is incorrect"
        }
        
        let diffInDays = Calendar.current.dateComponents([.day], from: startDate, to: date).day
            
        guard let days: Int = diffInDays else {
            return "diffInDays is incorrect"
        }
        
        // Коррекция даты, находим начало недели
        var dateCorrection = calendar.component(.weekday, from: startDate) - 2
        if calendar.component(.weekday, from: startDate) == 1 {
            dateCorrection += 7
        }
        
        
        let numberOfWeek = (days + dateCorrection) / 7
        switch numberOfWeek.isMultiple(of: 2){
                 case true:
                     result = "White week"
                 case false:
                     result = "Blue week"
                 }
                 return result
            }
    
}

