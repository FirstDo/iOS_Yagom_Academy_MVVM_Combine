//
//  MainViewController.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/06.
//

import UIKit

enum Const {
    enum Fruit {
        static let strawberry = "🍓"
        static let banana = "🍌"
        static let pineapple = "🍍"
        static let kiwi = "🥝"
        static let mango = "🥭"
    }
}

final class OrderViewController: UIViewController {
    private let strawberryLabel = UILabel(alignment: .center, text: Const.Fruit.strawberry)
    private let bananaLabel = UILabel(alignment: .center, text: Const.Fruit.banana)
    private let pineappleLabel = UILabel(alignment: .center, text: Const.Fruit.pineapple)
    private let kiwiLabel = UILabel(alignment: .center, text: Const.Fruit.kiwi)
    private let mangoLabel = UILabel(alignment: .center, text: Const.Fruit.mango)
    
    private let strawberryStockLabel = UILabel(alignment: .center)
    private let bananaStockLabel = UILabel(alignment: .center)
    private let pineappleStockLabel = UILabel(alignment: .center)
    private let kiwiStockLabel = UILabel(alignment: .center)
    private let mangoStockLabel = UILabel(alignment: .center)
    
    private let strawberryBananaButton = UIButton(title: "딸기쥬스 주문")
    private let mangoKiwiButton = UIButton(title: "망키쥬스 주문")
    private let strawberryButton = UIButton(title: "딸기쥬스 주문")
    private let bananaButton = UIButton(title: "바나나쥬스 주문")
    private let pineappleButton = UIButton(title: "파인애플쥬스 주문")
    private let kiwiButton = UIButton(title: "키위쥬스 주문")
    private let mangoButton = UIButton(title: "망고쥬스 주문")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UILabel {
    convenience init(alignment: NSTextAlignment = .left, text: String? = nil) {
        self.init()
        self.textAlignment = alignment
        self.text = text
    }
}

extension UIButton {
    convenience init(title: String? = nil) {
        self.init()
        self.setTitle(title, for: .normal)
    }
}
