//
//  ToastTableViewCell.swift
//  Toaster
//
//  Created by Nikita Pekurin on 9/12/20.
//  Copyright © 2020 Nikita Pekurin. All rights reserved.
//

import UIKit

class ToastTableViewCell: UITableViewCell {

    @IBOutlet weak var toastContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
