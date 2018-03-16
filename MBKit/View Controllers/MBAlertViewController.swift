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
    
    //MBAlertViewController(title: "", description: "" image: image, style: .alert)
    
    var image: UIImage?
    var style: Style
    public var alertTitle: UILabel!
    public var alertDescription: UITextView!
    
    public init(title: String?, description: String?, image: UIImage?, style: Style){
        
        if let title = title {
            self.alertTitle = UILabel()
            self.alertTitle.attributedText = NSAttributedString(string: title)
        }
        
        if let description = description {
            self.alertDescription = UITextView()
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
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func addAction(_ action:MBAlertAction) {
    
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
