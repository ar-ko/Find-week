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
    var startDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: "startDate") == nil {
            datePicker.isEnabled = false
            resultLabel.font = resultLabel.font.withSize(35)
            resultLabel.text = NSLocalizedString("Please set the start date", comment: "resultLabel")
            
        }
        else {
            startDate = UserDefaults.standard.value(forKey: "startDate") as! Date
            let date = dateToString(date: startDate, in: "d MMMM yyyy")
            startDateField.text = NSLocalizedString("Start date is ", comment: "startDateField") + date
            
            datePicker.minimumDate = startDate
            
            resultLabel.text = findWeek(from: startDate)
            }

        setStartDatePicker()
        startDateField.inputAccessoryView = setToolbar()
    }
    
    
    func setToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        return toolbar
    }
    
    func setStartDatePicker() {
        startDateField.inputView = startDatePicker
        startDatePicker.datePickerMode = .date
        startDatePicker.backgroundColor = resultLabel.textColor
    }
    
    
    @IBAction func rollDatePicker(_ sender: UIDatePicker) {
        resultLabel.text = findWeek(from: startDate, to: sender.date)
    }
    
 
    // MARK: Узнаем четная неделя или нет
    func findWeek(from startDate: Date, to currentDate:Date = Date()) -> String {
        let currentDay = dateToString(date: currentDate, in: "EEEE")
               
        let diffInDays = Calendar.current.dateComponents([.day], from: startDate, to: currentDate).day
            
        guard let days: Int = diffInDays else {
            return NSLocalizedString("diffInDays is incorrect", comment: "diffInDays")
        }
        
        // Коррекция даты, находим начало недели
        let calendar = Calendar.current
        var dateCorrection = calendar.component(.weekday, from: startDate) - 2
        if calendar.component(.weekday, from: startDate) == 1 {
            dateCorrection += 7
        }
        
        let numberOfWeek = (days + dateCorrection) / 7
        switch numberOfWeek.isMultiple(of: 2){
                 case true:
                     return currentDay + NSLocalizedString(", white week", comment: "whiteWeek")
                 case false:
                     return currentDay + NSLocalizedString(", blue week", comment: "blueWeek")
                 }
            }
    
    
    @objc func doneAction() {
        getDateFromStartDatePicker()
        view.endEditing(true)
    }
    
    
    func getDateFromStartDatePicker() {
        let dateS = dateToString(date: startDatePicker.date, in: "d MMMM yyyy")
        
        //Устанавливаем стартовую дату. Приобразуем в строку и обратно для корректного определения даты.
        //Если делать иначе, то при первом выборе стартовая дата определяется некорректно
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        startDateField.text = NSLocalizedString("Start date is ", comment: "startDateField") + dateS
        let date = dateFormatter.date(from:dateS)!
        startDate = date
        
        UserDefaults.standard.setValue(startDate, forKey: "startDate")
        resultLabel.text = findWeek(from: startDate, to: datePicker.date)
        
        datePicker.minimumDate = startDate
        datePicker.isEnabled = true
        resultLabel.font = resultLabel.font.withSize(40)
    }
    
    func dateToString(date:Date, in format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}

