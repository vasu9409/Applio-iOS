//
//  BaseView.swift
//  Applio
//
//  Created by Vasu Savaliya on 09/05/24.
//

import UIKit

class BaseView: UIView {

    // ----------------------------------------------------
    // MARK:
    // MARK: - Variables
    // ----------------------------------------------------
    public var nibName: String {
        return String(describing: Self.self) // defaults to the name of the class implementing this protocol.
    }
    
    var contentView: UIView?

    // ----------------------------------------------------
    // MARK:
    // MARK: - Override Functions
    // ----------------------------------------------------
    override init(frame fem: CGRect) {
        super.init(frame: fem)
        self.setNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setNib()
    }
    
    func setNib() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        contentView = view
    }

    // ----------------------------------------------------
    // MARK:
    // MARK: - Custome Functions
    // ----------------------------------------------------
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
