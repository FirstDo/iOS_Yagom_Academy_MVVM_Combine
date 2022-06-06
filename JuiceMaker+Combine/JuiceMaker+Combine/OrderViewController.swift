//
//  MainViewController.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/06.
//

import UIKit
import Combine
import SnapKit

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
    private lazy var fruitStockStackView: UIStackView = {
        let strawBerryStackView = UIStackView(arrangedSubviews: [strawberryLabel, strawberryStockLabel])
        strawBerryStackView.axis = .vertical
        
        let bananaStackView = UIStackView(arrangedSubviews: [bananaLabel, bananaStockLabel])
        bananaStackView.axis = .vertical
        
        let pineappleStackView = UIStackView(arrangedSubviews: [pineappleLabel, pineappleStockLabel])
        pineappleStackView.axis = .vertical
        
        let kiwiStackView = UIStackView(arrangedSubviews: [kiwiLabel, kiwiStockLabel])
        kiwiStackView.axis = .vertical
        
        let mangoStackView = UIStackView(arrangedSubviews: [mangoLabel, mangoStockLabel])
        mangoStackView.axis = .vertical
        
        let stackview = UIStackView(arrangedSubviews: [strawBerryStackView, bananaStackView, pineappleStackView, kiwiStackView, mangoStackView])
        
        stackview.distribution = .fillEqually
        
        return stackview
    }()
    
    private lazy var topButtonStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [strawberryBananaButton, mangoKiwiButton])
        stackview.spacing = 10
        stackview.distribution = .fillEqually
        
        return stackview
    }()
    
    private lazy var bottomButtonStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [strawberryButton, bananaButton, pineappleButton, kiwiButton, mangoButton])
        stackview.spacing = 10
        stackview.distribution = .fillEqually
        
        return stackview
    }()
    
    private let strawberryLabel = UILabel(alignment: .center, text: Const.Fruit.strawberry)
    private let bananaLabel = UILabel(alignment: .center, text: Const.Fruit.banana)
    private let pineappleLabel = UILabel(alignment: .center, text: Const.Fruit.pineapple)
    private let kiwiLabel = UILabel(alignment: .center, text: Const.Fruit.kiwi)
    private let mangoLabel = UILabel(alignment: .center, text: Const.Fruit.mango)
    
    private let strawberryStockLabel = UILabel(alignment: .center, text: "0")
    private let bananaStockLabel = UILabel(alignment: .center, text: "0")
    private let pineappleStockLabel = UILabel(alignment: .center, text: "0")
    private let kiwiStockLabel = UILabel(alignment: .center, text: "0")
    private let mangoStockLabel = UILabel(alignment: .center, text: "0")
    
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
    
    private let viewModel = OrderViewModel()
    private var cancellBag = Set<AnyCancellable>()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bind()
    }
    
    // MARK: - SetUp
    
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
        view.addSubview(fruitStockStackView)
        view.addSubview(topButtonStackView)
        view.addSubview(bottomButtonStackView)
        
        fruitStockStackView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        
        topButtonStackView.snp.makeConstraints{
            $0.top.greaterThanOrEqualTo(fruitStockStackView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(fruitStockStackView)
            $0.height.equalTo(50)
        }
        
        bottomButtonStackView.snp.makeConstraints{
            $0.top.equalTo(topButtonStackView.snp.bottom).offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            $0.leading.trailing.equalTo(fruitStockStackView)
            $0.height.equalTo(50)
        }
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
    
    // MARK: - View, Model Binding
    
    private func bind() {
        viewModel.publishFruitStock.sink { [weak self] stocks in
            for (fruit, amount) in stocks {
                switch fruit {
                case .strawberry:
                    self?.strawberryStockLabel.text = "\(amount)"
                case .mango:
                    self?.mangoStockLabel.text = "\(amount)"
                case .kiwi:
                    self?.kiwiStockLabel.text = "\(amount)"
                case .pineapple:
                    self?.pineappleStockLabel.text = "\(amount)"
                case .banana:
                    self?.bananaStockLabel.text = "\(amount)"
                }
            }
        }
        .store(in: &cancellBag)
    }
    
}
