//
//  Juice.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/06.
//

enum Juice: String {
    case strawberry = "딸기쥬스"
    case banana = "바나나쥬스"
    case kiwi = "키위쥬스"
    case pineapple = "파인애플쥬스"
    case strawberryBanana = "딸바쥬스"
    case mango = "망고쥬스"
    case mangoKiwi = "망키쥬스"
    
    var recipe: [Fruit: Int] {
        switch self {
        case .strawberry:
            return [.strawberry: 16]
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
