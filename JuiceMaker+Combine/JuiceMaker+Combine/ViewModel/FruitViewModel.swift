//
//  FruitViewModel.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/07.
//

import Combine

final class FruitViewModel {
    private(set) var juiceMaker = JuiceMaker()

    func orderButtonTapped(juice: Juice) -> AnyPublisher<String, StockError> {
        return Future<String, StockError> { [weak self] promise in
            do {
                try self?.juiceMaker.make(juice: juice)
                promise(.success(juice.rawValue))
            } catch {
                promise(.failure(.notEnoughFruit))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func fruitStepperTapped(fruit: Fruit, amount: Int) {
        juiceMaker.fruitStore.changeStock(of: fruit, to: amount)
    }
    
    var publishFruitStock: AnyPublisher<[Fruit: Int], Never> {
        return juiceMaker.fruitStore.$stocks.eraseToAnyPublisher()
    }
}
