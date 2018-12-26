//
//  mySlider.swift
//  SwiftyCompanion
//
//  Created by Ruslan on 08.11.2018.
//  Copyright © 2018 Ruslan NAUMENKO. All rights reserved.
//

import UIKit

class MyUISlider: UISlider {
    
    private var height: Float!
    
    init(height: Float) {
        self.height = height
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
    }
    
    ///Change the track thickness
    override func trackRect(forBounds: CGRect) -> CGRect {
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: CGFloat(height)))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
