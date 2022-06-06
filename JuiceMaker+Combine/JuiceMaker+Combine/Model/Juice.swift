//
//  Juice.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/06.
//

enum Juice {
    case strawberry
    case banana
    case kiwi
    case pineapple
    case strawberryBanana
    case mango
    case mangoKiwi
    
    var recipe: [Fruit: Int] {
        switch self {
        case .strawberry:
            return [.strawberry: 6]
        case .banana:
            return [.banana: 2]
        case .kiwi:
            return [.kiwi: 3]
        case .pineapple:
            return [.pineapple: 2]
        case .strawberryBanana:
            return [.strawberry: 10, .banana: 1]
        case .mango:
            return [.mango: 3]
        case .mangoKiwi:
            return [.mango: 2, .kiwi: 1]
        }
    }
}
