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
    @IBOutlet weak var startDateField: UITextField!
    
    let startDatePicker = UIDatePicker()
    
    // MARK: Установка даты начала отсчета
     func setStartDate() -> Date? {
         
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
    
    var startDate = Date()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        startDate = setStartDate()!
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        let dateS = formatter.string(from: startDate)
        startDateField.text = "Start date is \(dateS)"
        
        datePicker.minimumDate = startDate
        resultLabel.text = findWeek(Date(), startDate)
        startDateField.inputView = startDatePicker
        startDatePicker.datePickerMode = .date
        startDatePicker.backgroundColor = resultLabel.textColor
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexSpace, doneButton], animated: true)

        
        startDateField.inputAccessoryView = toolbar
        
        
    }
    
    
    @IBAction func rollDatePicker(_ sender: UIDatePicker) {
       
        resultLabel.text = findWeek(sender.date, startDate)
    }
    
 
    
    // MARK: Узнаем четная неделя или нет
    func findWeek(_ currentDate:Date = Date(), _ startDate: Date) -> String {
        
        let calendar = Calendar.current
        var result = String()
               
        let diffInDays = Calendar.current.dateComponents([.day], from: startDate, to: currentDate).day
            
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
    
    
    @objc func doneAction() {
        getDateFromStartDatePicker()
        view.endEditing(true)
    }
    
    func getDateFromStartDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        let dateS = formatter.string(from: startDatePicker.date)
        
        startDateField.text = "Start date is \(dateS)"
        let date = formatter.date(from:dateS)!
        startDate = date
        datePicker.minimumDate = startDate
        resultLabel.text = findWeek(datePicker.date, startDate)
        
        
    }
}

