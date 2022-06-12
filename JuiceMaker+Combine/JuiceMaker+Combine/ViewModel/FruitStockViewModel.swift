//
//  FruitStockViewModel.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/11.
//

import Combine

final class FruitStockViewModel: ViewModelType {
    private var cancellables = Set<AnyCancellable>()
    
    struct Input {
        let fruitStepperValueChanged: AnyPublisher<(Fruit, Int), Never>
    }
    
    struct Output {
        let fruitStock = FruitStore.shared.$stocks
    }
    
    func transform(input: Input) -> Output {
        input
            .fruitStepperValueChanged
            .sink { (fruit, value) in
                FruitStore.shared.changeStock(of: fruit, to: value)
            }
            .store(in: &cancellables)

        return Output()
    }
}
