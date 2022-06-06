//
//  CustomInitalizer.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/06.
//

import UIKit

extension UILabel {
    convenience init(alignment: NSTextAlignment = .left, text: String? = nil) {
        self.init()
        self.textAlignment = alignment
        self.text = text
    }
}

extension UIButton {
    convenience init(title: String? = nil) {
        self.init()
        self.setTitle(title, for: .normal)
    }
}

extension UIStackView {
    convenience init(arrangedSubviews : [UIView], axis: NSLayoutConstraint.Axis) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
    }
}
