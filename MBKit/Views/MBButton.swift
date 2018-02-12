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
    
    @IBInspectable public var titlePrefix : String? {
        didSet {
            applyProperties()
        }
    }
    
    @IBInspectable public var titleSufix : String? {
        didSet {
            applyProperties()
        }
    }
    
    @IBInspectable public var titleModifiersFontSizeRatio : CGFloat = 1.0 {
        didSet {
            applyProperties()
        }
    }
    
    @IBInspectable public var titleModifierMargin: CGFloat = 6.0 {
        didSet {
            applyProperties()
        }
    }
    
    public var customShapePath:CGPath? {
        didSet {
            applyProperties()
        }
    }
    
    private func updateTitle() {
        setNeedsLayout()
    }
    
    private func applyProperties(){
        
        let borderColor = (self.borderColor ?? self.tintColor)?.withAlphaComponent(renderHighlight ? 0.5 : 1)
        self.backgroundColor = self.backgroundColor?.withAlphaComponent(renderHighlight ? 0.5 : 1)
        
        if (hasDecoratedTitle) {
            self._titleLabel.textColor = self.tintColor?.withAlphaComponent(renderHighlight ? 0.5 : 1)
            self._titleLabel.setNeedsDisplay()
            
            self._prefixLabel.textColor = self.tintColor?.withAlphaComponent(renderHighlight ? 0.5 : 1)
            self._sufixLabel.textColor = self.tintColor?.withAlphaComponent(renderHighlight ? 0.5 : 1)
        }
        
        switch type {
        case .normal:
            if showBorders {
                layer.borderColor = borderColor?.cgColor
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
        setNeedsDisplay()
    }
    
    private lazy var blurView:UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        view.isUserInteractionEnabled = false
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var _titleLabel = UILabel()
    private lazy var titleStack = UIStackView()
    private lazy var _prefixLabel = UILabel()
    private lazy var _sufixLabel = UILabel()
    
    private var hasDecoratedTitle : Bool {
        return titlePrefix != nil || titleSufix != nil
    }
    
    override open func didMoveToSuperview() {
        applyProperties()
        
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: .touchUpInside)
        addTarget(self, action: #selector(touchUp), for: .touchUpOutside)
    }
    
    private var renderHighlight = false
    
    @objc private func touchDown(){
        renderHighlight = true
        applyProperties()
    }
    
    @objc private func touchUp(){
        renderHighlight = false
        applyProperties()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        applyProperties()
        if hasDecoratedTitle {
            if !subviews.contains(titleStack){
                titleStack.distribution = .fillProportionally
                titleStack.axis = .horizontal
                titleStack.addArrangedSubview(_prefixLabel)
                titleStack.addArrangedSubview(_titleLabel)
                titleStack.addArrangedSubview(_sufixLabel)
                
                addSubview(titleStack)
            }
            
            guard let titleLabel = titleLabel else {
                return
            }
            
            titleLabel.isHidden = true
            _titleLabel.text = titleLabel.text
            _titleLabel.font = titleLabel.font
            _titleLabel.textAlignment = .center
            
            _prefixLabel.font = titleLabel.font.withSize(titleLabel.font.pointSize * titleModifiersFontSizeRatio)
            _prefixLabel.textAlignment = .left
            _prefixLabel.text = titlePrefix
            
            _sufixLabel.font = titleLabel.font.withSize(titleLabel.font.pointSize * titleModifiersFontSizeRatio)
            _sufixLabel.textAlignment = .right
            _sufixLabel.text = titleSufix
            titleStack.frame = CGRect(x: titleModifierMargin, y: 0, width: frame.width - (titleModifierMargin * 2), height: frame.height)
            titleStack.isUserInteractionEnabled = false
        } else {
            titleStack.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        }
        
    }
    
    
}

@objc public enum MBButtonType :Int{
    case normal = 0
    case elliptical = 1
    case custom = 2
}
