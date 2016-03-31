//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Lincoln Sea on 3/29/16.
//  Copyright (c) 2016 Lincoln Sea. All rights reserved.
//

import UIKit

class ConversionViewController : UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Conversion loaded")
    }
    
    override func viewWillAppear(animated: Bool) {
        let currentDate = NSDate()
        let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: currentDate)
        
        if hour >= 18 {
            view.backgroundColor = UIColor.grayColor()
        }
    }
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        } else {
            return nil
        }
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        if let text = textField.text, value = Double(text) {
            fahrenheitValue = value
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(".")
        let replacementTextHasDecimalSeparator = string.rangeOfString(".")
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
        }
        
        let charSet = NSCharacterSet.decimalDigitCharacterSet()
        let rangeFromSet = string.rangeOfCharacterFromSet(charSet)
        return string == "" || rangeFromSet != nil || string == "."
    }

}