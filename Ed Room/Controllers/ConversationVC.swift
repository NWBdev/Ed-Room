//
//  ViewController.swift
//  Ed Room
//
//  Created by Nathaniel Burciaga on 9/19/20.
//  Copyright © 2020 Appside of the Box. All rights reserved.
//

import UIKit


class ConversationVC: UIViewController {

    //Outlets
    @IBOutlet weak var menu_Btn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Dark Mode
        if #available(iOS 13.0, *) {
               // Always adopt a light interface style.
               overrideUserInterfaceStyle = .light
           }
        
        
        menu_Btn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        //adds gestures for menu options
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)

    }


    
    //Actions
    @IBAction func menu_BtnWasPressed(_ sender: Any) {
    }
    
}

