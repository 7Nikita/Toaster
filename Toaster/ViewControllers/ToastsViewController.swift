//
//  ToastsViewController.swift
//  Toaster
//
//  Created by Nikita Pekurin on 9/3/20.
//  Copyright © 2020 Nikita Pekurin. All rights reserved.
//

import UIKit

class ToastsViewController: UIViewController {

    @IBOutlet weak var handleView: UIView! {
        didSet {
            handleView.roundCorners(top: true, cornerRadius: 30.0)
        }
    }
    
    override func viewDidLoad() {
        self.view.roundCorners(top: true, cornerRadius: 30.0)
    }
    
}
