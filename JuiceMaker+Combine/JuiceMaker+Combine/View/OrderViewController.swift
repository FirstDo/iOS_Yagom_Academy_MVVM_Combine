//
//  MainViewController.swift
//  JuiceMaker+Combine
//
//  Created by κΉλμ° on 2022/06/06.
//

import UIKit
import Combine
import SnapKit

enum Const {
    enum Fruit {
        static let strawberry = "π"
        static let banana = "π"
        static let pineapple = "π"
        static let kiwi = "π₯"
        static let mango = "π₯­"
    }
}

final class OrderViewController: UIViewController, Alertable {
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
    
    private let strawberryBananaButton = UIButton(title: "λΈλ°μ₯¬μ€ μ£Όλ¬Έ")
    private let mangoKiwiButton = UIButton(title: "λ§ν€μ₯¬μ€ μ£Όλ¬Έ")
    private let strawberryButton = UIButton(title: "λΈκΈ°μ₯¬μ€ μ£Όλ¬Έ")
    private let bananaButton = UIButton(title: "λ°λλμ₯¬μ€ μ£Όλ¬Έ")
    private let pineappleButton = UIButton(title: "νμΈμ νμ₯¬μ€ μ£Όλ¬Έ")
    private let kiwiButton = UIButton(title: "ν€μμ₯¬μ€ μ£Όλ¬Έ")
    private let mangoButton = UIButton(title: "λ§κ³ μ₯¬μ€ μ£Όλ¬Έ")
    
    private lazy var buttonAndJuice: [UIButton: Juice] = [
        strawberryBananaButton: .strawberryBanana,
        mangoKiwiButton: .mangoKiwi,
        strawberryButton: .strawberry,
        bananaButton: .banana,
        pineappleButton: .pineapple,
        kiwiButton: .kiwi,
        mangoButton: .mango
    ]
    
    private lazy var fruitAndLabel: [Fruit: UILabel] = [
        .strawberry: strawberryStockLabel,
        .banana: bananaStockLabel,
        .pineapple: pineappleStockLabel,
        .kiwi: kiwiStockLabel,
        .mango: mangoStockLabel
    ]
    
    private let viewModel = JuiceMakerViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bind(to: viewModel)
    }
    
    // MARK: - SetUp
    
    private func setUp() {
        setView()
        setLayout()
        setNavigation()
    }
    
    private func setView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setLayout() {
        view.addSubview(fruitStockStackView)
        view.addSubview(topButtonStackView)
        view.addSubview(bottomButtonStackView)
        
        fruitStockStackView.snp.makeConstraints{
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(50)
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
        navigationItem.title = "λ§μλ μ₯¬μ€λ₯Ό λ§λ€μ΄ λλ €μ!"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "μ¬κ³ μμ ", style: .plain, target: self, action: #selector(rightBarButtonTapped))
    }
    
    @objc
    private func rightBarButtonTapped() {
        present(UINavigationController(rootViewController: StockViewController()), animated: true)
    }
    
    // MARK: - View, Model Binding
    
    func bind(to viewModel: JuiceMakerViewModel) {        
        let juiceButtonTapped = strawberryBananaButton
            .publisher
            .merge(
                with: mangoKiwiButton.publisher,
                strawberryButton.publisher,
                bananaButton.publisher,
                pineappleButton.publisher,
                kiwiButton.publisher,
                mangoButton.publisher
            )
            .map { self.buttonAndJuice[$0]! }
            .eraseToAnyPublisher()

        let input = JuiceMakerViewModel.Input(juiceButtonTapped: juiceButtonTapped)

        let output = viewModel.transform(input: input)

        output.fruitStock.sink { [weak self] stocks in
            stocks.forEach { (fruit, amount) in
                self?.fruitAndLabel[fruit]?.text = "\(amount)"
            }
        }
        .store(in: &cancellables)

        output.juiceOrderResult.sink { result in
            switch result {
            case true:
                self.show(message: "μ₯¬μ€ λμμ΅λλ€! λ§μκ² λμΈμ!", okAction: {})
            case false:
                self.show(message: "μ¬κ³ κ° λͺ¨μλΌμ. μ¬κ³ λ₯Ό μμ ν κΉμ?", okAction: {
                    self.rightBarButtonTapped()
                }, cancelAction: {})
            }
        }
        .store(in: &cancellables)
    }
}
