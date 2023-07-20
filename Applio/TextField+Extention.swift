//
//  TextField+Extention.swift
//  VideoDownloader
//
//  Created by VASU SAVALIYA on 24/06/23.
//

import Foundation
import UIKit

extension UITextField {
    
    public func setPlaceholder(_ placeholder: String, color: UIColor = .white) {
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: color]
        )
    }    
}
