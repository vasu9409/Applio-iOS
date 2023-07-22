//
//  TextField+Extention.swift
//  Applio
//
//  Created by VASU SAVALIYA on 24/06/23.
//

import UIKit

extension UITextField {
    
    /*
     Set textfiled attributed placeholder with color
     */
    public func setPlaceholder(_ placeholder: String, color: UIColor = .white) {
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: color]
        )
    }    
}
