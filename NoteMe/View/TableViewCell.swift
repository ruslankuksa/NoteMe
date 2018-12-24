//
//  TableViewCell.swift
//  NoteMe
//
//  Created by Руслан Кукса on 12/18/18.
//  Copyright © 2018 Ruslan Kuksa. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
