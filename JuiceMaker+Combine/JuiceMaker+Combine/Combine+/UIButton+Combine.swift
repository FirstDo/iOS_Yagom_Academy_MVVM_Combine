//
//  UIButton+Combine.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/11.
//

import UIKit
import Combine

extension UIButton {
    var publisher: AnyPublisher<UIButton, Never> {
        return controlPublisher(for: .touchUpInside)
            .map { $0 as! UIButton }
            .eraseToAnyPublisher()
    }
}
