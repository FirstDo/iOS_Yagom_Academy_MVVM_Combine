//
//  JuiceMaker.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/06.
//

struct JuiceMaker {
    private var fruitStore = FruitStore(count: 10)
    
    mutating func make(juice: Juice) throws {
        try canMake(juice)
        deleteStock(for: juice)
    }
    
    mutating func canMake(_ juice: Juice) throws {
        for (fruit, amount) in juice.recipe {
            try fruitStore.checkStock(of: fruit, amount: amount)
        }
    }
    
    mutating func deleteStock(for juice: Juice) {
        for (fruit, amount) in juice.recipe {
            fruitStore.changeStock(of: fruit, by: amount, isAdd: false)
        }
    }
}
