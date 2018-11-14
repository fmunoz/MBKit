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

    var innerType: MBButtonType = .normal {
        didSet {
            applyProperties()
        }
    }

    @IBInspectable public var IBtype: Int {
        get {
            return innerType.rawValue
        } set {
            innerType = MBButtonType.init(rawValue: newValue) ?? MBButtonType.normal
        }
    }

    public var type: MBButtonType {
        get {
        return innerType
        }
        set {
            innerType = newValue
        }
    }

    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            applyProperties()
        }
    }

    @IBInspectable public var showBorders: Bool = false {
        didSet {
            applyProperties()
        }
    }

    @IBInspectable public var blurBackground: Bool = false {
        didSet {
            applyProperties()
        }
    }

    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            applyProperties()
        }
    }

    @IBInspectable public var borderColor: UIColor? {
        didSet {
            applyProperties()
        }
    }

    @IBInspectable public var titlePrefix: String? {
        didSet {
            applyProperties()
        }
    }

    @IBInspectable public var titleSufix: String? {
        didSet {
            applyProperties()
        }
    }

    @IBInspectable public var titleModifiersFontSizeRatio: CGFloat = 1.0 {
        didSet {
            applyProperties()
        }
    }

    @IBInspectable public var titleModifierMargin: CGFloat = 6.0 {
        didSet {
            applyProperties()
        }
    }

    private func updateTitle() {
        setNeedsLayout()
    }

    //swiftlint:disable function_body_length
    private func applyProperties() {

        let borderColor = isEnabled ?
            (self.borderColor ?? self.tintColor)?.withAlphaComponent(renderHighlight ? 0.5 : 1) : UIColor.clear

        self.backgroundColor = isEnabled ?
            self.backgroundColor?.withAlphaComponent(renderHighlight ? 0.5 : 1)
            : self.backgroundColor?.withAlphaComponent(0.25)

        if hasDecoratedTitle {
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
        case .elliptical:
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = UIBezierPath(ovalIn: extractCircleRect(self.bounds)).cgPath

            self.layer.mask = maskLayer

            if showBorders {
                borderLayer.frame = self.bounds
                borderLayer.path = UIBezierPath(ovalIn:
                    extractCircleRect(self.bounds.insetBy(dx: borderWidth, dy: borderWidth))).cgPath
                borderLayer.strokeColor = borderColor?.cgColor
                borderLayer.lineWidth = (borderWidth > 0) ? borderWidth : 1.0
                borderLayer.fillColor = UIColor.clear.cgColor
                if let sublayers = self.layer.sublayers, !sublayers.contains(borderLayer) {
                    self.layer.addSublayer(borderLayer)
                }
            }

        }

        if blurBackground {
            if !subviews.contains(blurView) {
                addSubview(blurView)
            }
            blurView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: frame.size)
            blurView.layer.cornerRadius = layer.cornerRadius
            insertSubview(blurView, at: 0)
        } else {
            if subviews.contains(blurView) {
                blurView.removeFromSuperview()
            }
        }

        setTitleColor(tintColor, for: .normal)
        setNeedsDisplay()
    }
    //swiftlint:enable function_body_length

    private lazy var blurView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.isUserInteractionEnabled = false
        view.clipsToBounds = true
        return view
    }()

    private lazy var _titleLabel = UILabel()
    private lazy var titleStack = UIStackView()
    private lazy var _prefixLabel = UILabel()
    private lazy var _sufixLabel = UILabel()
    private lazy var borderLayer = CAShapeLayer()

    private var hasDecoratedTitle: Bool {
        return titlePrefix != nil || titleSufix != nil
    }

    override open func didMoveToSuperview() {
        applyProperties()

        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: .touchUpInside)
        addTarget(self, action: #selector(touchUp), for: .touchUpOutside)
    }

    private var renderHighlight = false

    @objc private func touchDown() {
        renderHighlight = true
        applyProperties()
    }

    @objc private func touchUp() {
        renderHighlight = false
        applyProperties()
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        applyProperties()
        if hasDecoratedTitle {
            if !subviews.contains(titleStack) {
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
            titleStack.frame = CGRect(x: titleModifierMargin, y: 0,
                                      width: frame.width - (titleModifierMargin * 2),
                                      height: frame.height)
            titleStack.isUserInteractionEnabled = false
        } else {
            titleStack.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        }

    }

    private func extractCircleRect(_ rect: CGRect) -> CGRect {
        let diameter = min(rect.height, rect.width)
        let offset =  CGFloat(fabsf(Float(rect.height - rect.width)))/2.0
        let horizontal = rect.width > rect.height
        let origin = CGPoint(x: rect.origin.x + (horizontal ? offset : 0),
                             y: rect.origin.y + ( horizontal ? 0 : offset))
        return CGRect(origin: origin, size: CGSize(width: diameter, height: diameter))
    }
}

@objc public enum MBButtonType: Int {
    case normal = 0
    case elliptical = 1
}
