//
//  ViewController.swift
//  Vegas
//
//  Created by Chris Archibald on 8/18/15.
//  Copyright (c) 2015 Chris Archibald. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var isOut = false
    @IBOutlet weak var inTextField: UITextField!
    @IBOutlet weak var outTextField: UITextField!
    @IBOutlet weak var dateField: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //When the user click on the Check in Text Field a Date picker will appear
    //At the bottom of the screen to pick a date
    @IBAction func inTextFieldEdit(sender: UITextField) {
        isOut = false
        var datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }

    //When the user clicks on the Check out text field a Date Picker will appear 
    //At the bottom of the screen to pick a date
    @IBAction func outTextFiledEdit(sender: UITextField) {
        isOut = true
        var datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    //Take the date and moved it to the textfield
    func datePickerValueChanged(sender:UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        //because we are using the same textfield, we have a bolean vaule that
        //will tell us which field to save the vaule to
        if isOut {
            outTextField.text = dateFormatter.stringFromDate(sender.date)
        } else {
            inTextField.text = dateFormatter.stringFromDate(sender.date)
        }
    }
}

