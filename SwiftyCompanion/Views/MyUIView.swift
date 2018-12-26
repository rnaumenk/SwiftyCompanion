//
//  myImageView.swift
//  SwiftyCompanion
//
//  Created by Ruslan on 08.11.2018.
//  Copyright © 2018 Ruslan NAUMENKO. All rights reserved.
//

import UIKit

/// MyUIView is created in order to provide shadow for the container even if its clipsToBounds == true
class MyUIView: UIView {

    private var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.fillColor = UIColor.white.cgColor
            
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
            
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 25).cgPath
        
    }

}
