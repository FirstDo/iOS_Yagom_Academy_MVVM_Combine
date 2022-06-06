//
//  FruitStore.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/06.
//

import Combine

class FruitStore {
    static let shared = FruitStore(count: 10)
    
    @Published var stocks: [Fruit: Int]
    
    private init(count: Int) {
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
    
    func changeStock(of fruit: Fruit, by amount: Int) {
        guard let fruitCount = stocks[fruit] else { return }
        
        stocks[fruit] = fruitCount - amount
    }
    
    func changeStock(of fruit: Fruit, to amount: Int) {
        guard amount >= 0 else { return }
        
        stocks[fruit] = amount
    }
}


