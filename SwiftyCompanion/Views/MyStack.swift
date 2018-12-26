//
//  myStack.swift
//  SwiftyCompanion
//
//  Created by Ruslan on 09.11.2018.
//  Copyright © 2018 Ruslan NAUMENKO. All rights reserved.
//

import UIKit

class MyStack: UIStackView {
    
    /// Create a vertical stack which contains all user's skills, presented as horizontal stacks consisting of label and slider which, in turn, represent the skill name and its level accordingly
    ///
    /// - Parameter array: skills array
    init(array: NSArray) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        self.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        self.isLayoutMarginsRelativeArrangement = true
        self.axis = .vertical
        self.distribution = .fillEqually
        self.spacing = 16
        self.alignment = .fill
        self.translatesAutoresizingMaskIntoConstraints = false
        
        for i in 0..<array.count {
            let skill = UIStackView()
            let label = UILabel()
            let slider = MyUISlider(height: 10)
            
            skill.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            skill.isLayoutMarginsRelativeArrangement = true
            skill.axis = .horizontal
            skill.distribution = .fillEqually
            skill.alignment = .center
            skill.spacing = 8
            
            label.textColor = .black
            label.text = (array[i] as! NSDictionary)["name"] as? String
            label.textAlignment = .right
            label.adjustsFontSizeToFitWidth = true
            
            skill.addArrangedSubview(label)
            
            slider.minimumValue = 0.0
            slider.maximumValue = 20.0
            slider.isEnabled = false
            slider.value = ((array[i] as! NSDictionary)["level"] as! NSNumber).floatValue
            slider.tintColor = UIColor.green
            slider.setThumbImage(UIImage(), for: UIControl.State.normal)
            
            skill.addArrangedSubview(slider)
            
            self.addArrangedSubview(skill)
        }
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
