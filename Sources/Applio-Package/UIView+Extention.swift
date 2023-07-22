//
//  UIView+Extention.swift
//  Applio
//
//  Created by VASU SAVALIYA on 30/11/22.
//

import Foundation
import UIKit

extension UIView {
    
    /*
     Create circle Layout of view
     */
    @IBInspectable
    var isCircleOn: Bool {
        get {
            return self.isCircleOn
        } set {
            if newValue {
                layer.cornerRadius = self.frame.height / 2
            }
        }
    }
    
    /*
     Set corner radius of UIView
     */
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }
    
    /*
     Set border width of UIView
     */
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        } set {
            layer.borderWidth = newValue
        }
    }
    
    /*
     Set border color of UIView
     */
    @IBInspectable
    var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        } set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    /*
     Set shadow radius of UIView
     */
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        } set {
            layer.shadowRadius = newValue
        }
    }
    
    /*
     Set shadow offset of UIView
     */
    @IBInspectable
    var shadowOffset : CGSize{
        get{
            return layer.shadowOffset
        } set {
            layer.shadowOffset = newValue
        }
    }

    /*
     Set shadow color of UIView
     */
    @IBInspectable
    var shadowColor : UIColor{
        get{
            return UIColor.init(cgColor: layer.shadowColor!)
        } set {
            layer.shadowColor = newValue.cgColor
        }
    }
    
    /*
     Set shadow opacity of UIView
     */
    @IBInspectable
    var shadowOpacity : Float {
        get{
            return layer.shadowOpacity
        } set {
            layer.shadowOpacity = newValue
        }
    }
    
    /*
     Drop shadow of UIView
     */
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
