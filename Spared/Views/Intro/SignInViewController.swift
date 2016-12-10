//
//  SignInViewController.swift
//  Spared
//
//  Created by luis loo on 12/9/16.
//  Copyright © 2016 lloo. All rights reserved.
//

import UIKit
import Eureka

protocol UserLoginDelegate {
    func userLoggedIn(data: Bool)
}


class SignInViewController: FormViewController {
    
    @IBAction func closeSignInAction(_ sender: UIBarButtonItem) {
        if let del = dataDelegate {
            print("will dismiss \(self.login)")
            del.userLoggedIn(data: self.login)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    let gradientLayer = CAGradientLayer()
    
    var dataDelegate: UserLoginDelegate? = nil
    var login: Bool = false

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
        
        ButtonRow.defaultCellSetup = { cell, row in
            cell.backgroundColor = .white
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
        +++ Section()
            <<< ButtonRow() { row in
                row.title = "Log in"
            }
            .onCellSelection { [weak self] (cell, row) in
                self?.login = true
                print("setting true to login \(self?.login)")
            }
        
        self.tableView?.isScrollEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.backgroundView?.backgroundColor = UIColor.clear
            view.textLabel?.backgroundColor = UIColor.clear
            view.textLabel?.textColor = UIColor.white
        }
    }    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

