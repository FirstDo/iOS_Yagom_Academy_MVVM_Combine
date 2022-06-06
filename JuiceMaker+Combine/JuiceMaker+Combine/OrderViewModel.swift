//
//  OrderViewModel.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/07.
//

import Combine

final class OrderViewModel {
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
    
    var publishFruitStock: AnyPublisher<[Fruit: Int], Never> {
        return juiceMaker.fruitStore.$stocks.eraseToAnyPublisher()
    }
}
