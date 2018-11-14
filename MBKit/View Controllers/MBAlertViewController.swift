//
//  MBAlertViewController.swift
//  MBKit
//
//  Created by Franklin Munoz on 2/15/18.
//  Copyright © 2018 Magic Box Software Solutions LLC. All rights reserved.
//

import UIKit

open class MBAlertViewController: UIViewController {

    public enum Style {
        case alert
    }

    var image: UIImage?
    var style: Style
    public var alertTitle: UILabel!
    public var alertDescription: UILabel!
    var actions: [MBAlertAction] = []

    public init(title: String?, description: String?, image: UIImage?, style: Style) {

        self.alertTitle = UILabel()
        self.alertDescription = UILabel()

        if let title = title {
            self.alertTitle.attributedText = NSAttributedString(string: title)
        }

        if let description = description {
            self.alertDescription.attributedText = NSAttributedString(string: description)
        }

        self.image = image
        self.style = style

        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
    }

    public required init?(coder aDecoder: NSCoder) {
        self.style = .alert
        super.init(coder: aDecoder)
    }

    override open func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        self.view = view
    }

    //swiftlint:disable function_body_length
    override open func viewDidLoad() {
        super.viewDidLoad()

        var views = [UIView]()

        let alertFrame = self.view.bounds.insetBy(dx: 20, dy: 100)

        if let image = image {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.frame = CGRect(x: 0, y: 0, width: alertFrame.width, height: 200)
            views.append(imageView)
        }

        if let alertTitle = alertTitle {
            alertTitle.frame = CGRect(x: 0, y: 0, width: alertFrame.width, height: 200)
            views.append(alertTitle)
        }

        if let alertDescription = alertDescription {
            alertDescription.sizeToFit()
            views.append(alertDescription)
        }

        var buttonViews = [UIView]()
        for action in actions {
            action.parent = self
            let button = MBButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 60, height: 40)))
            button.backgroundColor = UIColor.gray
            button.showBorders = true
            button.borderColor = UIColor.white
            button.setAttributedTitle(action.title, for: .normal)
            button.isEnabled = true
            button.cornerRadius = 6
            button.addTarget(action, action: #selector(action.onActionTriggered(sender:forEvent:)),
                             for: UIControl.Event.touchUpInside)
            buttonViews.append(button)
        }

        var buttonStack: UIStackView?
        if !buttonViews.isEmpty {
            buttonStack = UIStackView(arrangedSubviews: buttonViews)
            buttonStack?.distribution = .fillEqually
            buttonStack?.axis = .horizontal
        }

        if let buttonStack = buttonStack {
            views.append(buttonStack)
        }

        let stack = UIStackView(arrangedSubviews: views)
        stack.distribution = .equalCentering
        stack.axis = .vertical
        stack.frame = self.view.bounds.insetBy(dx: 20, dy: 100)

        let stackBackgroundView = UIView(frame: stack.frame)
        stackBackgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        self.view.addSubview(stackBackgroundView)
        self.view.addSubview(stack)
    }
    //swiftlint:enable function_body_length

    public func addAction(_ action: MBAlertAction) {
        self.actions.append(action)
    }

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
}

public class MBAlertAction {
    public enum Style {
        case `default`
        case cancel
    }

    fileprivate var parent: MBAlertViewController!
    var title: NSAttributedString
    var style: Style
    var action: (() -> Void)?
    public init(title: NSAttributedString?, style: Style, action: (() -> Void)?) {
        self.title = title ?? NSAttributedString(string: "")
        self.style = style
        self.action = action
    }

    @objc func onActionTriggered(sender: UIButton, forEvent event: UIEvent) {
        parent.dismiss(animated: true, completion: {
            if let action = self.action {
                action()
            }
        })
    }
}
