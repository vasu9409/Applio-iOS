//
//  CollectionView+Extention.swift
//  Notebook
//
//  Created by VASU SAVALIYA on 06/06/23.
//

import UIKit

extension UICollectionView {
    
    public func registerNib(for name: String) {
        let nib = UINib(nibName: name, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: name)
    }
}
