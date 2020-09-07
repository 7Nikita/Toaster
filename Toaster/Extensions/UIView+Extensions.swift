//
//  UIView+Extensions.swift
//  Toaster
//
//  Created by Nikita Pekurin on 9/2/20.
//  Copyright © 2020 Nikita Pekurin. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundCorners(top: Bool, cornerRadius: CGFloat) {
        let corners: UIRectCorner = top ? [.topLeft, .topRight] : [.bottomLeft, .bottomRight]
        roundCorners(corners: corners, cornerRadius: cornerRadius)
    }
    
    func roundAllCorners(cornerRadius: CGFloat) {
        let corners: UIRectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
        roundCorners(corners: corners, cornerRadius: cornerRadius)
    }
    
    private func roundCorners(corners: UIRectCorner, cornerRadius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
}
