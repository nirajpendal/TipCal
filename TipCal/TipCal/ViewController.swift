//
//  ViewController.swift
//  TipCal
//
//  Created by Niraj Pendal on 2/21/17.
//  Copyright © 2017 Proteus. All rights reserved.
//

import UIKit

struct Theme {
    static let ThemeValues:[String] = ["Black", "Blue", "Green"]
    static let ThemeKey:String = "theme"
    
}


class ViewController: UIViewController {

    @IBOutlet weak var bilTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipSegment: UISegmentedControl!
    @IBOutlet weak var billTitleLabel: UILabel!
    @IBOutlet weak var tipTitleLabel: UILabel!
    @IBOutlet weak var totalTitleLabel: UILabel!
    
    let tipConstants = [0.18, 0.2, 0.25]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let themeIndex = UserDefaults.standard.value(forKey: Theme.ThemeKey) as? Int
        setTheme(themeIndex: themeIndex)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapDetected(_ sender: Any) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: Any) {
        
        let bill = Double(bilTextField.text!) ?? 0
        let tip = bill * tipConstants[tipSegment.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = tip.format()
        totalLabel.text = total.format()
        
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
    
}

extension Double {
    func format() -> String {
        return String(format: "%0.2f", self)
    }
}

