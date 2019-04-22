//
//  SearchTableViewCell.swift
//  BLANJA_Test
//
//  Created by Ernando Kasaluhe on 22/04/19.
//  Copyright © 2019 Ernando Kasaluhe. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var labelAddress: UILabel!
    
    func setupConfigureCell(withDescription description: String) {
        labelAddress.text = description
    }
    
}
