//
//  TypeViewController.swift
//  Spared
//
//  Created by luis loo on 12/9/16.
//  Copyright © 2016 lloo. All rights reserved.
//

import UIKit

class TypeViewController: UIViewController {
    
    @IBOutlet weak var user: UIImageView!
    @IBOutlet weak var users: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.user.image = UIImage(named: "user")?.maskWithColor(color: UIColor(red: 253, green: 194, blue: 15))
        self.users.image = UIImage(named: "users")?.maskWithColor(color: UIColor(red: 253, green: 194, blue: 15))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
