//
//  FruitStore.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/06.
//

import Combine

class FruitStore {
    @Published var stocks: [Fruit: Int]
    
    init(count: Int) {
        stocks = [:]
        
        Fruit.allCases.forEach { fruit in
            stocks[fruit] = count
        }
    }
    
    func checkStock(of fruit: Fruit, amount: Int) throws {
        guard let fruitCount = stocks[fruit], fruitCount >= amount else {
            throw StockError.notEnoughFruit
        }
    }
    
    func changeStock(of fruit: Fruit, by amount: Int, isAdd: Bool = true) {
        guard let fruitCount = stocks[fruit] else { return }
        
        if isAdd {
            stocks[fruit] = fruitCount + amount
        } else {
            stocks[fruit] = fruitCount - amount
        }
    }
}


