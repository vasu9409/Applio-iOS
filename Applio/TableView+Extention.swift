//
//  TableVoew+Extention.swift
//  VideoDownloader
//
//  Created by VASU SAVALIYA on 24/06/23.
//

import UIKit

extension UITableView {
    
    public func registerNib(for name: String) {
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forCellReuseIdentifier: name)
    }
}
