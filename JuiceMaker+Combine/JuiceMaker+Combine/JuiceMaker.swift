//
//  JuiceMaker.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/06.
//

struct JuiceMaker {
    private let fruitStore = FruitStore.shared
    
    mutating func make(juice: Juice) throws {
        try canMake(juice)
        deleteStock(for: juice)
    }
    
    mutating private func canMake(_ juice: Juice) throws {
        for (fruit, amount) in juice.recipe {
            try fruitStore.checkStock(of: fruit, amount: amount)
        }
    }
    
    mutating private func deleteStock(for juice: Juice) {
        for (fruit, amount) in juice.recipe {
            fruitStore.changeStock(of: fruit, by: amount, isAdd: false)
        }
    }
}
