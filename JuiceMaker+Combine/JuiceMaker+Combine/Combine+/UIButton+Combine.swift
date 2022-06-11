//
//  UIButton+Combine.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/11.
//

import UIKit
import Combine

extension UIButton {
    func tapPublisher() -> AnyPublisher<Void, Never> {
        return controlPublisher(for: .touchUpInside)
            .map { _ in }
            .eraseToAnyPublisher()
    }
}
