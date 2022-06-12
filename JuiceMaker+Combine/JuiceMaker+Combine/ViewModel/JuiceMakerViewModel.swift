//
//  FruitViewModel.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/07.
//

import Combine

final class JuiceMakerViewModel: ViewModelType {
    private(set) var juiceMaker = JuiceMaker()
    
    struct Input {
        let juiceButtonTapped: AnyPublisher<Juice, Never>
    }
    
    struct Output {
        let juiceOrderResult: AnyPublisher<Bool, Never>
        let fruitStock = FruitStore.shared.$stocks
    }
    
    func transform(input: Input) -> Output {
        let juiceOrderResult = input
            .juiceButtonTapped
            .map { [weak self] juice -> Bool in
                do {
                    try self?.juiceMaker.make(juice: juice)
                    return true
                }
                catch {
                    return false
                }
            }
            .eraseToAnyPublisher()

        return Output(juiceOrderResult: juiceOrderResult)
    }
}
