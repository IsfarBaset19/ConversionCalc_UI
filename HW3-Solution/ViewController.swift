//
//  ViewController.swift
//  HW3-Solution
//
//  Created by Jonathan Engelsma on 9/7/18.
//  Copyright © 2018 Jonathan Engelsma. All rights reserved.
//

import UIKit
import Firebase

class ViewController: CalculatorScreenViewController, SettingsViewControllerDelegate, HistoryTableViewControllerDelegate {
    
    fileprivate var ref : DatabaseReference?

    @IBOutlet weak var fromField: UITextField!
    @IBOutlet weak var toField: UITextField!
    @IBOutlet weak var fromUnits: UILabel!
    @IBOutlet weak var toUnits: UILabel!
    @IBOutlet weak var calculatorHeader: UILabel!
    
    var currentMode : CalculatorMode = .Length
    
    var entries : [Conversion] = [Conversion(fromVal: 1, toVal: 1760, mode: .Length, fromUnits: LengthUnit.Miles.rawValue, toUnits:
        LengthUnit.Yards.rawValue, timestamp: Date.distantPast),
    Conversion(fromVal: 1, toVal: 4, mode: .Volume, fromUnits: VolumeUnit.Gallons.rawValue, toUnits:
        VolumeUnit.Quarts.rawValue, timestamp: Date.distantFuture)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toField.delegate = self
        fromField.delegate = self
        
        self.ref = Database.database().reference()
        self.registerForFireBaseUpdates()

        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    func selectEntry(entry: Conversion) {
        
        self.currentMode = entry.mode
        self.fromField.text = "\(entry.fromVal)"
        self.fromUnits.text = entry.fromUnits
        self.toField.text = "\(entry.toVal)"
        self.toUnits.text = entry.toUnits
          
      }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        // determine source value of data for conversion and dest value for conversion
        var dest : UITextField?

        var val = ""
        if let fromVal = fromField.text {
            if fromVal != "" {
                val = fromVal
                dest = toField
            }
        }
        if let toVal = toField.text {
            if toVal != "" {
                val = toVal
                dest = fromField
            }
        }
        if dest != nil {
            switch(currentMode) {
            case .Length:
                var fUnits, tUnits : LengthUnit
                if dest == toField {
                    fUnits = LengthUnit(rawValue: fromUnits.text!)!
                    tUnits = LengthUnit(rawValue: toUnits.text!)!
                } else {
                    fUnits = LengthUnit(rawValue: toUnits.text!)!
                    tUnits = LengthUnit(rawValue: fromUnits.text!)!
                }
                if let fromVal = Double(val) {
                    let convKey =  LengthConversionKey(toUnits: tUnits, fromUnits: fUnits)
                    let toVal = fromVal * lengthConversionTable[convKey]!;
                    dest?.text = "\(toVal)"
                }
                
                // save history to firebase
                let entry = Conversion(fromVal: Double(self.fromField.text!)!, toVal: Double(toField.text!)!, mode: .Length,
                               fromUnits: fUnits.rawValue, toUnits: tUnits.rawValue, timestamp: Date())
                               
                let newChild = self.ref?.child("history").childByAutoId()
                                                   newChild?.setValue(self.toDictionary(vals: entry))
                
            case .Volume:
                var fUnits, tUnits : VolumeUnit
                if dest == toField {
                    fUnits = VolumeUnit(rawValue: fromUnits.text!)!
                    tUnits = VolumeUnit(rawValue: toUnits.text!)!
                } else {
                    fUnits = VolumeUnit(rawValue: toUnits.text!)!
                    tUnits = VolumeUnit(rawValue: fromUnits.text!)!
                }
                if let fromVal = Double(val) {
                    let convKey =  VolumeConversionKey(toUnits: tUnits, fromUnits: fUnits)
                    let toVal = fromVal * volumeConversionTable[convKey]!;
                    dest?.text = "\(toVal)"
                }
                
                 // save history to firebase
                let entry = Conversion(fromVal: Double(self.fromField.text!)!, toVal: Double(toField.text!)!, mode: .Length,
                fromUnits: fUnits.rawValue, toUnits: tUnits.rawValue, timestamp: Date())
                
                let newChild = self.ref?.child("history").childByAutoId()
                                    newChild?.setValue(self.toDictionary(vals: entry))

                
            }
        }
        self.view.endEditing(true)
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        self.fromField.text = ""
        self.toField.text = ""
        self.view.endEditing(true)
    }
    
    @IBAction func modePressed(_ sender: UIButton) {
        clearPressed(sender)
        switch (currentMode) {
        case .Length:
            currentMode = .Volume
            fromUnits.text = VolumeUnit.Gallons.rawValue
            toUnits.text = VolumeUnit.Liters.rawValue
            fromField.placeholder = "Enter volume in \(fromUnits.text!)"
            toField.placeholder = "Enter volume in \(toUnits.text!)"
        case .Volume:
            currentMode = .Length
            fromUnits.text = LengthUnit.Yards.rawValue
            toUnits.text = LengthUnit.Meters.rawValue
            fromField.placeholder = "Enter length in \(fromUnits.text!)"
            toField.placeholder = "Enter length in \(toUnits.text!)"
        }
        calculatorHeader.text = "\(currentMode.rawValue) Conversion Calculator"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dest = segue.destination as? SettingsViewController {
            if segue.identifier == "settingsSegue" {
                
                dest.mode = currentMode
                dest.fUnits = fromUnits.text
                dest.tUnits = toUnits.text
                dest.delegate = self
                
            }
        }
        
        if let dest = segue.destination as? HistoryTableViewController {
            if segue.identifier == "historySegue" {
                dest.historyDelegate = self
                dest.entries = self.entries
            }
        }
    }
    
    func toDictionary(vals: Conversion) -> NSDictionary {
        return [
            "timestamp": NSString(string: (vals.timestamp.iso8601)),
            "origFromVal" : NSNumber(value: vals.fromVal),
            "origToVal" : NSNumber(value: vals.toVal),
            "origMode" : vals.mode.rawValue,
            "origFromUnits" : vals.fromUnits,
            "origToUnits" : vals.toUnits
        ]
    }

    func settingsChanged(fromUnits: LengthUnit, toUnits: LengthUnit)
    {
        self.fromUnits.text = fromUnits.rawValue
        self.toUnits.text = toUnits.rawValue
        
    }
    
    func settingsChanged(fromUnits: VolumeUnit, toUnits: VolumeUnit)
    {
        self.fromUnits.text = fromUnits.rawValue
        self.toUnits.text = toUnits.rawValue
    }
    
    fileprivate func registerForFireBaseUpdates()
     {
         self.ref!.child("history").observe(.value, with: { snapshot in
             if let postDict = snapshot.value as? [String : AnyObject] {
                 var tmpItems = [Conversion]()
                 for (_,val) in postDict.enumerated() {
                     let entry = val.1 as! Dictionary<String,AnyObject>
                     let timestamp = entry["timestamp"] as! String?
                     let origFromVal = entry["origFromVal"] as! Double?
                     let origToVal = entry["origToVal"] as! Double?
                     let origFromUnits = entry["origFromUnits"] as! String?
                     let origToUnits = entry["origToUnits"] as! String?
                     let origMode = entry["origMode"] as! String?
                     
                     tmpItems.append(Conversion(fromVal: origFromVal!, toVal: origToVal!, mode: CalculatorMode(rawValue: origMode!)!, fromUnits: origFromUnits!, toUnits: origToUnits!, timestamp: (timestamp?.dateFromISO8601)!))
                 }
                 self.entries = tmpItems
             }
         })
         
     }

}

extension ViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == toField) {
            fromField.text = ""
        } else {
            toField.text = ""
        }
    }
}

extension UINavigationController {
    override open var preferredStatusBarStyle: UIStatusBarStyle{
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}

extension Date {
    struct Formatter {
        static let iso8601: DateFormatter = {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSxxx"
            return formatter
        }()
        
        static let short: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
    }
    
    var short: String {
        return Formatter.short.string(from: self)
    }
    
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
}

extension String {
    var dateFromISO8601: Date? {
        return Date.Formatter.iso8601.date(from: self)
    }
}


