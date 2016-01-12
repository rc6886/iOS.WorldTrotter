//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Home on 1/9/16.
//  Copyright © 2016 Home. All rights reserved.
//

import Foundation
import UIKit

public class ConversionViewController : UIViewController, UITextFieldDelegate {
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    var farenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Double? {
        if let value = farenheitValue {
            return (value - 32) * (5/9)
        } else {
            return nil
        }
    }
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        celsiusLabel.text = textField.text
        
        if let text = textField.text where !text.isEmpty {
            celsiusLabel.text = text
        } else{
            celsiusLabel.text = "???"
        }
        
        if let text = textField.text, value = Double(text) {
            farenheitValue = value
        } else {
            farenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        print("Current Text: \(textField.text)")
        print("Replacement Text: \(string)")
        
        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(".")
        let replacementTextHasDecimalSeparator = string.rangeOfString(".")
        let replacementTextContainsLetters = doesStringContainLetters(string)
        
        let shouldReplaceDecimal = existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil
        
        if shouldReplaceDecimal || replacementTextContainsLetters {
            return false
        } else {
            return true
        }
    }
    
    func doesStringContainLetters(value: String?) -> Bool {
        if let string = value {
        let letters = NSCharacterSet.letterCharacterSet()
        let range = string.rangeOfCharacterFromSet(letters)
        
        // range will be nil if no letters is found
        if let _ = range {
            return true
        }
        else {
            return false
        }
        } else {
            return false
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        print("ConversionViewController loaded its view.")
    }
    
    override public func viewWillAppear(animated: Bool) {
        
        if getDateTime() > 7 && getDateTime() < 7 {
            view.backgroundColor = UIColor.lightGrayColor()
        } else {
            view.backgroundColor = UIColor.darkGrayColor()
        }
    }
    
    func getDateTime() -> Int {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute, .Second], fromDate: date)
        return components.hour
    }
}
