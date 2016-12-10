//
//  IntroViewController.swift
//  Spared
//
//  Created by luis loo on 12/9/16.
//  Copyright © 2016 lloo. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var coffee: UIImageView!
    @IBOutlet weak var money: UIImageView!
    @IBOutlet weak var plane: UIImageView!
    
    @IBAction func signUpBtnAction(_ sender: UIButton) {
    }
    
    let gradientLayer = CAGradientLayer()
    
    var loggedIn: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.view.backgroundColor = UIColor(red: 66, green: 191, blue: 183)
        gradientLayer.frame = self.view.bounds
        
        let color1 = UIColor(red: 66, green: 191, blue: 183).cgColor as CGColor
        let color2 = UIColor(red: 8, green: 123, blue: 135).cgColor as CGColor
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.0, 1.0]
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        self.signUpBtn.layer.cornerRadius = 10
        
        self.coffee.image = UIImage(named: "coffee")?.maskWithColor(color: UIColor(red: 253, green: 194, blue: 15))
        self.money.image = UIImage(named: "money")?.maskWithColor(color: UIColor(red: 253, green: 194, blue: 15))
        self.plane.image = UIImage(named: "plane")?.maskWithColor(color: UIColor(red: 253, green: 194, blue: 15))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        print("will check login user \(self.loggedIn)")
        
        if self.loggedIn {
            performSegue(withIdentifier: "fromSigninToRegister", sender: self)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "fromIntroToLogin" {
            print("passed segue")
            if let nc = segue.destination as? SignInNavigationViewController {
                if let vc = nc.topViewController as? SignInViewController {
                    print("setting delegate")
                    vc.dataDelegate = self
                }
            }
        }
    }

}

extension IntroViewController: UserLoginDelegate {
    func userLoggedIn(data: Bool) {
        print("user logged in \(data)")
        self.loggedIn = data
    }
}
