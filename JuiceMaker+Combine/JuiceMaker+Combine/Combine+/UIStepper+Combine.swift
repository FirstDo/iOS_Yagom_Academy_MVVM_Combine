//
//  UIStepper+Combine.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/11.
//

import UIKit
import Combine

extension UIStepper {
    var publisher: AnyPublisher<UIStepper, Never> {
        return controlPublisher(for: .valueChanged)
            .map { $0 as! UIStepper }
            .eraseToAnyPublisher()
    }
}
