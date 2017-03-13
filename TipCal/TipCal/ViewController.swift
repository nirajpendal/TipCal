//
//  ViewController.swift
//  TipCal
//
//  Created by Niraj Pendal on 2/21/17.
//  Copyright © 2017. All rights reserved.
//

import UIKit

struct Theme {
    static let ThemeValues:[String] = ["Black", "Blue", "Green"]
    static let ThemeKey:String = "theme"
    
}

struct  TipPercentage {
    static let TipPercentages:[Double] = [ 0.18, 0.20, 0.25]
    static let TipSelectedKey:String = "tipSelected"
}

class ViewController: UIViewController {

    @IBOutlet weak var bilTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipSegment: UISegmentedControl!
    @IBOutlet weak var billTitleLabel: UILabel!
    @IBOutlet weak var tipTitleLabel: UILabel!
    @IBOutlet weak var totalTitleLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    let SAVE_STATE_THRESHOLD:Double = 10*60
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let themeIndex = defaults.value(forKey: Theme.ThemeKey) as? Int
        let tipSelectedIndex = defaults.value(forKey: TipPercentage.TipSelectedKey) as? Int
        
        setTheme(themeIndex: themeIndex)
        setTipPercentage(tipSelectedIndex: tipSelectedIndex)

        
        if let savedTime = defaults.value(forKey: "SavedTime") as? Date {
            print(Date().timeIntervalSince1970)
            print(savedTime.timeIntervalSince1970)
            if ( (Date().timeIntervalSince1970 - savedTime.timeIntervalSince1970 ) <  SAVE_STATE_THRESHOLD){
                self.bilTextField.text = defaults.value(forKey: "BillValue") as? String ?? ""
                calculateTip()
            }
        }
        
        
        self.bilTextField.becomeFirstResponder()
        super.viewWillAppear(animated)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapDetected(_ sender: Any) {
        view.endEditing(true)
    }
    
    func calculateTip()  {
        let bill = Double(bilTextField.text!) ?? 0
        let tip = bill * TipPercentage.TipPercentages[tipSegment.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = tip.format()
        totalLabel.text = total.format()
        
        defaults.setValue(String(bill), forKey: "BillValue")
        defaults.synchronize()
    }

    @IBAction func calculateTip(_ sender: Any) {
        
        calculateTip()
        
        
        defaults.set(Date(), forKey: "SavedTime")
        defaults.synchronize()
    }
    
    func setTheme(themeIndex: Int?) {
        
        let themeColor = themeIndex ?? 0
        
        let themeString = Theme.ThemeValues[themeColor]
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: themeString)!)
        self.navigationController?.navigationBar.barTintColor = UIColor(patternImage: UIImage(named: themeString)!)
        
        var fontColor: UIColor
        
        switch themeColor {
        case 0:
            fontColor = UIColor.white
        default:
            fontColor = UIColor.black
        }
        
        self.tipSegment.tintColor = fontColor
        self.bilTextField.textColor = fontColor
        self.bilTextField.layer.borderWidth = CGFloat(1.0)
        self.bilTextField.layer.borderColor = fontColor.cgColor
        self.tipLabel.textColor = fontColor
        self.totalLabel.textColor = fontColor
        self.billTitleLabel.textColor = fontColor
        self.tipTitleLabel.textColor = fontColor
        self.totalTitleLabel.textColor = fontColor
        self.navigationController?.navigationBar.tintColor = fontColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: fontColor]
        
    }
    
    func setTipPercentage(tipSelectedIndex: Int?)  {
        
        let selectedIndex = tipSelectedIndex ?? 0
        self.tipSegment.selectedSegmentIndex = selectedIndex
    }
    
}

extension Double {
    func format() -> String {
        return String(format: "%0.2f", self)
    }
}

