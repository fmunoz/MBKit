//
//  UITableViewCell.swift
//  MBKit
//
//  Created by Franklin Munoz on 9/29/18.
//  Copyright © 2018 Magic Box Software Solutions LLC. All rights reserved.
//

import UIKit

public extension UITableViewCell {
    public func setDisclosureIndicatorColor(color: UIColor) {
        for view in self.subviews {
            if let disclosureView = view as? UIButton {
                var image = disclosureView.backgroundImage(for: .normal)
                image = image?.withRenderingMode(.alwaysTemplate)
                disclosureView.tintColor = color
                disclosureView.setBackgroundImage(image, for: .normal)
                break
            }
        }
    }
}
