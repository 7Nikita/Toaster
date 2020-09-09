//
//  CircleView.swift
//  Toaster
//
//  Created by Nikita Pekurin on 9/9/20.
//  Copyright © 2020 Nikita Pekurin. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        let newBoundsSize = min(bounds.size.width, bounds.size.height)
        bounds.size.width = newBoundsSize
        bounds.size.height = newBoundsSize
        layer.cornerRadius = newBoundsSize / 2
        layer.masksToBounds = true
    }

}
