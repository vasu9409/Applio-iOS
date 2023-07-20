//
//  CustomeView.swift
//  Bloodmeter
//
//  Created by VASU SAVALIYA on 30/11/22.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var isCircleOn: Bool {
        get {
            return self.isCircleOn
        }
        set {
            if newValue {
                layer.cornerRadius = self.frame.height / 2
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset : CGSize{

        get{
            return layer.shadowOffset
        }set{

            layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor : UIColor{
        get{
            return UIColor.init(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable
    var shadowOpacity : Float {

        get{
            return layer.shadowOpacity
        }
        set {

            layer.shadowOpacity = newValue

        }
    }
    
    // DROP SHADOW
    func dropShadow(scale: Bool = true, shadow: CGFloat = 10) {
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = shadow

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}

class CustomeView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isCircle {
           layer.cornerRadius = (self.frame.height) / 2
           layer.masksToBounds = true
        }
    }
    
    @IBInspectable var isCircle: Bool = false {
        didSet {
           layoutSubviews()
        }
    }
}
