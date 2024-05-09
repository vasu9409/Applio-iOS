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
    
    
    public func showNodataView(msg: String = "No data found.",
                        font: UIFont = .systemFont(ofSize: 16),
                        textColor: UIColor = .black) {
        let label = UILabel(frame: self.frame)
        label.text = msg
        label.font = font
        label.textColor = textColor
        label.backgroundColor = .clear
        self.backgroundView = label
    }
    
    public func removeNoDataView() {
        self.backgroundView = nil
    }
}
