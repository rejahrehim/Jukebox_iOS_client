//
//  ArrayExtensions.swift
//  DemocraticJukebox
//
//  Created by Thahir Maheen on 30/05/15.
//  Copyright (c) 2015 Jukebox. All rights reserved.
//

import Foundation

extension NSMutableArray {
    
    func addUtilityButton(backGroundColor: UIColor? = nil, titleColor: UIColor? = nil, title: String) {
        let button = UIButton.buttonWithType(.Custom) as! UIButton
        button.backgroundColor = backGroundColor ?? UIColor.clearColor()
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(titleColor ?? UIColor.blackColor(), forState: .Normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        addObject(button)
    }
}