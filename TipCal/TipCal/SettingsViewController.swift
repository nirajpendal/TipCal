//
//  SettingsViewController.swift
//  TipCal
//
//  Created by Niraj Pendal on 2/24/17.
//  Copyright © 2017. All rights reserved.
//

import UIKit

protocol MainScreenDelegate: class {
    func didSelectTheme()
}

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    let settingsSections = ["Select Theme", "Default Tip Percentage"]
    
    let selectedThemeIndex = UserDefaults.standard.value(forKey: Theme.ThemeKey) as? Int ?? 0
    let selectedTipIndex = UserDefaults.standard.value(forKey: TipPercentage.TipSelectedKey) as? Int ?? 0
    
    weak var mainScreenDelegate: MainScreenDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "settingCell")
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsSections.count
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Theme.ThemeValues.count
        case 1:
            return TipPercentage.TipPercentages.count
        default:
            return 0
        }
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "settingCell") as UITableViewCell!
        let accessoryType = UITableViewCellAccessoryType.none
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = Theme.ThemeValues[indexPath.row]
            if indexPath.row == selectedThemeIndex {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            } else {
                cell.accessoryType = accessoryType
            }
        case 1:
            cell.textLabel?.text = String(format: "%2.0f", TipPercentage.TipPercentages[indexPath.row] * 100) + "%"
            if indexPath.row == selectedTipIndex {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
            } else {
                cell.accessoryType = accessoryType
            }
        default:
            fatalError()
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingsSections[section]
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        switch indexPath.section {
        case 0:
            UserDefaults.standard.setValue(indexPath.row, forKey: Theme.ThemeKey)
            UserDefaults.standard.synchronize()
        case 1:
            UserDefaults.standard.setValue(indexPath.row, forKey: TipPercentage.TipSelectedKey)
            UserDefaults.standard.synchronize()
        default:
            fatalError()
        }
        
        
        
        self.dismiss(animated: true) {}
    }
    
    
}
