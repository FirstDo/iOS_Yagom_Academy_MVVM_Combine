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
    private lazy var contentStackView: UIStackView = {
        
        let strawBerryStackView = UIStackView(arrangedSubviews: [strawberryLabel, strawberryStockLabel], axis: .vertical)
        let bananaStackView = UIStackView(arrangedSubviews: [bananaLabel, bananaStockLabel], axis: .vertical)
        let pineappleStackView = UIStackView(arrangedSubviews: [pineappleLabel, pineappleStockLabel], axis: .vertical)
        let kiwiStackView = UIStackView(arrangedSubviews: [kiwiLabel, kiwiStockLabel], axis: .vertical)
        let mangoStackView = UIStackView(arrangedSubviews: [mangoLabel, mangoStockLabel], axis: .vertical)
        
        let fruitStockStackView = UIStackView(arrangedSubviews: [strawBerryStackView, bananaStackView, pineappleStackView, kiwiStackView, mangoStackView])
        
        let topStackView = UIStackView(arrangedSubviews: [strawberryBananaButton, mangoKiwiButton])
        let bottomStackView = UIStackView(arrangedSubviews: [strawberryButton, bananaButton, pineappleButton, kiwiButton, mangoButton])
        
        let stackview = UIStackView(arrangedSubviews: [fruitStockStackView, topStackView, bottomStackView], axis: .vertical)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        return stackview
    }()
    
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
    
    private lazy var juiceOrderButtons = [
        strawberryBananaButton,
        mangoKiwiButton,
        strawberryButton,
        bananaButton,
        pineappleButton,
        kiwiButton,
        mangoButton
    ]
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        setView()
        setLayout()
        setNavigation()
        setOrderButton()
    }
    
    private func setView() {
        view.backgroundColor = .systemBackground
        
    }
    
    private func setLayout() {
        view.addSubview(contentStackView)
    }
    
    private func setNavigation() {
        navigationItem.title = "맛있는 쥬스를 만들어 드려요!"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "재고수정", style: .plain, target: self, action: #selector(rightBarButtonTapped))
    }
    
    @objc
    private func rightBarButtonTapped() {
        // MARK: - empty
    }
    
    private func setOrderButton() {
        juiceOrderButtons.forEach { button in
            button.addTarget(self, action: #selector(juiceOrderButtonTapped(sender:)), for: .touchUpInside)
        }
    }
    
    @objc
    private func juiceOrderButtonTapped(sender: UIButton) {
        // MARK: - empty
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

extension UIStackView {
    convenience init(arrangedSubviews : [UIView], axis: NSLayoutConstraint.Axis) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
    }
}
