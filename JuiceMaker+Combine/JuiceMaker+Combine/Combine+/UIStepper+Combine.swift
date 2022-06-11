//
//  UIStepper+Combine.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/11.
//

import UIKit
import Combine

extension UIStepper {
    func valuePublisher() -> AnyPublisher<Double, Never> {
        return controlPublisher(for: .touchUpInside)
            .map { control in
                guard let stepper = control as? UIStepper else { return 0 }
                return stepper.value
            }
            .eraseToAnyPublisher()
    }
}
