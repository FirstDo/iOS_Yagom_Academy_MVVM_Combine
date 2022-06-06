//
//  FruitStore.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/06.
//

struct FruitStore {
    private(set) var stocks: [Fruit: Int]
    
    init(count: Int) {
        stocks = [:]
        
        Fruit.allCases.forEach { fruit in
            stocks[fruit] = count
        }
    }
    
    mutating func changeStock(of fruit: Fruit, by count: Int, isAdd: Bool = true) throws {
        guard let fruitCount = stocks[fruit] else {
            return
        }
        
        if isAdd {
            stocks[fruit] = fruitCount + count
        } else {
            guard fruitCount - count >= 0 else {
                throw StockError.notEnoughFruit
            }
            
            stocks[fruit] = fruitCount - count
        }
    }
}


