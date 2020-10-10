//
//  ContentVC.swift
//  Ed Room
//
//  Created by Nathaniel Burciaga on 10/10/20.
//  Copyright © 2020 Appside of the Box. All rights reserved.
//

import UIKit

class ContentVC: UIViewController {

    //Outlets
    @IBOutlet weak var menu_Btn: UIButton!
    
    
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        menu_Btn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        //adds gestures for menu options
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
