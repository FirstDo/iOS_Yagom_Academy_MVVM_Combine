//
//  FruitStore.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/06.
//

class FruitStore {
    static let shared = FruitStore(count: 10)
    
    private var stocks: [Fruit: Int]
    
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
    
    func changeStock(of fruit: Fruit, by amount: Int, isAdd: Bool = true) {
        guard let fruitCount = stocks[fruit] else { return }
        
        if isAdd {
            stocks[fruit] = fruitCount + amount
        } else {
            stocks[fruit] = fruitCount - amount
        }
    }
}


