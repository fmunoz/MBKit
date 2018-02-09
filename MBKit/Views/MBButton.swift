//
//  MBButton.swift
//  MBKit
//
//  Created by Franklin Munoz on 2/7/18.
//  Copyright © 2018 Magic Box Software Solutions LLC. All rights reserved.
//

import UIKit
/**
 UIButton Subclass with support for the following:
 - Rectangular buttons with optional round corners
 - Elliptical buttons
 */
@IBDesignable
open class MBButton: UIButton {
    
    var _type: MBButtonType = .normal {
        didSet {
            applyProperties()
        }
    }
    
    @IBInspectable public var IBtype : Int {
        get {
            return _type.rawValue
        } set {
            _type = MBButtonType.init(rawValue: newValue) ?? MBButtonType.normal
        }
    }
    
    
    public var type : MBButtonType {
        get {
        return _type
        }
        set {
            _type = newValue
        }
    }
    

    @IBInspectable public var cornerRadius : CGFloat = 0.0 {
        didSet{
            applyProperties()
        }
    }
    
    
    
    @IBInspectable public var showBorders : Bool = false {
        didSet {
            applyProperties()
        }
    }
    
    @IBInspectable public var blurBackground : Bool = false {
        didSet {
            applyProperties()
        }
    }
    
    @IBInspectable public var borderWidth : CGFloat = 0.0 {
        didSet {
            applyProperties()
        }
    }
    
    @IBInspectable public var borderColor : UIColor? {
        didSet {
            applyProperties()
        }
    }
    
    public var customShapePath:CGPath? {
        didSet {
            applyProperties()
        }
    }
    
    private func applyProperties(){
        switch type {
            
        case .normal:
            if showBorders {
                layer.borderColor = borderColor?.cgColor ?? tintColor?.cgColor
                layer.borderWidth = (borderWidth > 0) ? borderWidth : 1.0
                layer.cornerRadius = cornerRadius
            }
            break
        case .elliptical:
            break
        case .custom:
            break
        }
        
        if subviews.contains(blurView) {
            blurView.removeFromSuperview()
        }
        
        if blurBackground {
            blurView.frame = CGRect(origin: CGPoint(x:0, y:0), size: frame.size)
            blurView.layer.cornerRadius = layer.cornerRadius
            insertSubview(blurView, at: 0)
        }
        
        setTitleColor(tintColor, for: .normal)
    }
    
    private lazy var blurView:UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        view.isUserInteractionEnabled = false
        view.clipsToBounds = true
        return view
    }()
    
}

@objc public enum MBButtonType :Int{
    case normal = 0
    case elliptical = 1
    case custom = 2
}
