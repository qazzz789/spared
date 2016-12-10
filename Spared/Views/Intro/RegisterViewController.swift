//
//  RegisterViewController.swift
//  Spared
//
//  Created by luis loo on 12/9/16.
//  Copyright © 2016 lloo. All rights reserved.
//

import UIKit
import Eureka

class RegisterViewController: FormViewController {
    
    @IBAction func closeRegisterBtn(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    let gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(red: 66, green: 191, blue: 183)
        gradientLayer.frame = self.view.bounds
        
        let color1 = UIColor(red: 66, green: 191, blue: 183).cgColor as CGColor
        let color2 = UIColor(red: 8, green: 123, blue: 135).cgColor as CGColor
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.0, 1.0]
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        
        self.tableView?.backgroundColor = .clear
        
        navigationOptions = RowNavigationOptions.Enabled.union(.SkipCanNotBecomeFirstResponderRow)
        
        EmailRow.defaultCellSetup = { cell, row in
            cell.backgroundColor = .clear
            cell.titleLabel?.textColor = .white
            cell.textField.textColor = .white
            cell.textLabel?.textColor = .white
        }
        
        PasswordRow.defaultCellSetup = { cell, row in
            cell.backgroundColor = .clear
            cell.titleLabel?.textColor = .white
            cell.textField.textColor = .white
            cell.textLabel?.textColor = .white
        }
        
        SwitchRow.defaultCellSetup = { cell, row in
            cell.backgroundColor = .clear
            cell.detailTextLabel?.textColor = .white
            cell.textLabel?.textColor = .white
        }
        
        ButtonRow.defaultCellSetup = { cell, row in
            cell.backgroundColor = .white
            cell.textLabel?.textColor = UIColor(red: 179, green: 64, blue: 67)
            cell.layer.cornerRadius = 10
            cell.tintColor = UIColor(red: 179, green: 64, blue: 67)
        }
        
        form +++ Section()
            <<< EmailRow() {
                $0.title = "Email Address"
                $0.placeholder = "loan@spared.com"
            }
            .cellUpdate { cell, row in
                cell.textField.textColor = .white
                cell.textLabel?.textColor = .white
            }
            <<< PasswordRow() {
                $0.title = "Password"
                $0.placeholder = "Password"
            }
            .cellUpdate { cell, row in
                cell.textField.textColor = .white
                cell.textLabel?.textColor = .white
            }
            <<< SwitchRow() {
                $0.title = "I am a U.S. Resident, 18 years or older"
            }
            .cellUpdate { cell, row in
                cell.textLabel?.textColor = .white
                cell.switchControl?.onTintColor = UIColor(red: 179, green: 64, blue: 67)
            }
        +++ Section()
            <<< ButtonRow() { row in
                row.title = "Next"
                row.presentationMode = .segueName(segueName: "fromRegisterToType", onDismiss: nil)
            }
            .cellUpdate { cell, row in
                cell.textLabel?.textColor = UIColor(red: 179, green: 64, blue: 67)
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
