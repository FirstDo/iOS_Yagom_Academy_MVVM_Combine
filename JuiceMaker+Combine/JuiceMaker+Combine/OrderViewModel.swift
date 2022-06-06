//
//  OrderViewModel.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/07.
//

import Combine

final class OrderViewModel {
    let juiceMaker = JuiceMaker()
    
    func orderButtonTapped(Juice: Juice) {
        
    }
    
    var publishFruitStock: AnyPublisher<[Fruit: Int], Never> {
        return juiceMaker.fruitStore.$stocks.eraseToAnyPublisher()
    }
}
