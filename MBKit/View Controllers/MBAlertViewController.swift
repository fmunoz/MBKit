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
    public var alertDescription: UITextView!
    var actions: [MBAlertAction] = []
    
    public init(title: String?, description: String?, image: UIImage?, style: Style){
        
        self.alertTitle = UILabel()
        self.alertDescription = UITextView()
        
        if let title = title {
            self.alertTitle.attributedText = NSAttributedString(string: title)
        }
        
        if let description = description {
            self.alertDescription.attributedText = NSAttributedString(string: description)
        }
        
        self.image = image
        self.style = style
        
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.style = .alert
        super.init(coder: aDecoder)
    }
    
    override open func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.black
        self.view = view
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = image {
            let imageView = UIImageView(image: image)
            self.view.addSubview(imageView)
        }
        
        if let alertTitle = alertTitle {
            alertTitle.sizeToFit()
            self.view.addSubview(alertTitle)
        }
        
        if let alertDescription = alertDescription {
            alertDescription.sizeToFit()
            self.view.addSubview(alertDescription)
        }
        
        for action in actions {
            let button = MBButton(frame: CGRect(origin: CGPoint(x:0,y:0), size: CGSize(width:100,height:100)))
            button.showBorders = true
            button.borderColor = UIColor.white
            button.setAttributedTitle(action.title, for: .normal)
            button.isEnabled = true
            button.cornerRadius = 6
            button.addTarget(self, action: #selector(onActionButton), for: UIControlEvents.touchUpInside)
            self.view.addSubview(button)
            
            
        }
        
    }
    
    @objc func onActionButton(sender: UIButton, forEvent event: UIEvent) {
        print("tapped")
    }
    
    public func addAction(_ action:MBAlertAction) {
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
    
    var title: NSAttributedString
    var style: Style
    var action: (()->Void)?
    public init(title: NSAttributedString?, style: Style, action: (()-> Void)?) {
        self.title = title ?? NSAttributedString(string: "")
        self.style = style
        self.action = action
    }
}
