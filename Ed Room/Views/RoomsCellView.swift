//
//  RoomsCellView.swift
//  Ed Room
//
//  Created by Nathaniel Burciaga on 11/10/20.
//  Copyright © 2020 Appside of the Box. All rights reserved.
//

import UIKit

//Within the Prototype Cell of RoomsVC

class RoomsCellView: UITableViewCell {

    //Create Outlets
    @IBOutlet weak var nameTeacher: UILabel!
    
    @IBOutlet weak var classNumberOrName: UILabel!
    
    @IBOutlet weak var roomBtn: UIButton!
    
    //Variables
    var onCellButtonTapped: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //MAKE ROOM CELLS POPULATE
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //Create IBOUTLETS
    
    
}
