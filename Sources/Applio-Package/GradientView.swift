//
//  GradientView.swift
//  Applio
//
//  Created by VASU SAVALIYA on 24/06/23.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    /* MARK: - IBInspectable properties
     Renders vertical gradient if true else horizontal
     */
    @IBInspectable public var verticalGradient: Bool = true {
        didSet {
            updateUI()
        }
    }
    
    /*
     Start color of the gradient
     */
    @IBInspectable public var startColor: UIColor = .clear {
        didSet {
            updateUI()
        }
    }
    
    /*
     Mid color of the gradient
     */
    @IBInspectable public var midColor: UIColor = .clear {
        didSet {
            updateUI()
        }
    }
    
    /*
     End color of the gradient
     */
    @IBInspectable public var endColor: UIColor = .clear {
        didSet {
            updateUI()
        }
    }
    
    private var gradientlayer = CAGradientLayer()
    
    // MARK: - init methods
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - Layout
    override public func layoutSubviews() {
        super.layoutSubviews()
        updateFrame()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        gradientlayer = CAGradientLayer()
        updateUI()
        layer.addSublayer(gradientlayer)
        self.layer.insertSublayer(gradientlayer, at: 0)
    }
    
    // MARK: - Update frame
    private func updateFrame() {
        gradientlayer.frame = bounds
    }
    
    // MARK: - Update UI
    private func updateUI() {
        
        if midColor == .clear {
            gradientlayer.colors = [startColor.cgColor, endColor.cgColor]
        } else {
            gradientlayer.colors = [startColor.cgColor, midColor.cgColor, endColor.cgColor]
        }
        
        if verticalGradient {
            gradientlayer.startPoint = CGPoint(x: 0, y: 0)
            gradientlayer.endPoint = CGPoint(x: 0, y: 1)
        } else {
            gradientlayer.startPoint = CGPoint(x: 0, y: 0)
            gradientlayer.endPoint = CGPoint(x: 1, y: 0)
        }
        
        updateFrame()
    }
}
