//
//  AnnouncmentsVC.swift
//  Ed Room
//
//  Created by Nathaniel Burciaga on 10/6/20.
//  Copyright © 2020 Appside of the Box. All rights reserved.
//

import UIKit

class AnnouncmentsVC: UIViewController {

    
    @IBOutlet weak var menu_Btn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Dark Mode
        if #available(iOS 13.0, *) {
               // Always adopt a light interface style.
               overrideUserInterfaceStyle = .light
           }
        
        
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
