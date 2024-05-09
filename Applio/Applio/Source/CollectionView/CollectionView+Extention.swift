//
//  CollectionView+Extention.swift
//  Applio
//
//  Created by VASU SAVALIYA on 06/06/23.
//

import UIKit

extension UICollectionView {
    
    /* Register collection view cell
     Just you need to pass UICollectionViewCell class name and that will be register
     */
    public func registerNib(for name: String) {
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: name)
    }
    
    public func registerHederNib(for name: String) {
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: name)
    }
    
    public func registerHederFooterNib(for name: String) {
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: name)
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
