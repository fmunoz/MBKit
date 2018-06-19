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
        
        if let alertTitle = alertTitle {
            alertTitle.frame = CGRect(x: 20, y: 20, width: 100, height: 100)
            self.view.addSubview(alertTitle)
            
        }
    }
    
    public func addAction(_ action:MBAlertAction) {
    
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
    public init(title: NSAttributedString?, style: Style, action: (()-> Void)?) {
        
    }
}
