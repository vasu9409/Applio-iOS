//
//  TableVoew+Extention.swift
//  Applio
//
//  Created by VASU SAVALIYA on 24/06/23.
//

import UIKit

extension UITableView {

    /* Register table view cell
     Just you need to pass UITableViewCell class name and that will be register
     */
    public func registerNib(for name: String) {
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forCellReuseIdentifier: name)
    }
    
    public func registerHeaderFooterNib(for name: String) {
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: name)
    }
}
