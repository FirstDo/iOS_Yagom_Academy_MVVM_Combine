//
//  StockViewController.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/07.
//

import UIKit
import SnapKit
import Combine

final class StockViewController: UIViewController {
    private lazy var fruitStockStackView: UIStackView = {
        let strawBerryStackView = UIStackView(arrangedSubviews: [strawberryLabel, strawberryStockLabel, strawberryStepper])
        strawBerryStackView.axis = .vertical
        strawBerryStackView.alignment = .center
        
        let bananaStackView = UIStackView(arrangedSubviews: [bananaLabel, bananaStockLabel, bananaStepper])
        bananaStackView.axis = .vertical
        bananaStackView.alignment = .center
        
        let pineappleStackView = UIStackView(arrangedSubviews: [pineappleLabel, pineappleStockLabel, pineappleStepper])
        pineappleStackView.axis = .vertical
        pineappleStackView.alignment = .center
        
        let kiwiStackView = UIStackView(arrangedSubviews: [kiwiLabel, kiwiStockLabel, kiwiStepper])
        kiwiStackView.axis = .vertical
        kiwiStackView.alignment = .center
        
        let mangoStackView = UIStackView(arrangedSubviews: [mangoLabel, mangoStockLabel, mangoStepper])
        mangoStackView.axis = .vertical
        mangoStackView.alignment = .center
        
        let stackview = UIStackView(arrangedSubviews: [strawBerryStackView, bananaStackView, pineappleStackView, kiwiStackView, mangoStackView])
        stackview.spacing = 20
        
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
    
    private let strawberryStepper = UIStepper()
    private let bananaStepper = UIStepper()
    private let pineappleStepper = UIStepper()
    private let kiwiStepper = UIStepper()
    private let mangoStepper = UIStepper()
    
    private lazy var fruitAndLabel: [Fruit: UILabel] = [
        .strawberry: strawberryStockLabel,
        .banana: bananaStockLabel,
        .pineapple: pineappleStockLabel,
        .kiwi: kiwiStockLabel,
        .mango: mangoStockLabel
    ]
    
    private lazy var stepperAndFruit: [UIStepper: Fruit] = [
        strawberryStepper: .strawberry,
        bananaStepper: .banana,
        pineappleStepper: .pineapple,
        kiwiStepper: .kiwi,
        mangoStepper: .mango
    ]
    
    private lazy var fruitAndStepper: [Fruit: UIStepper] = [
        .strawberry: strawberryStepper,
        .banana: bananaStepper,
        .pineapple: pineappleStepper,
        .kiwi: kiwiStepper,
        .mango: mangoStepper
    ]
    
    private let viewModel = FruitViewModel()
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
        setStepper()
    }
    
    private func setView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setLayout() {
        view.addSubview(fruitStockStackView)
        
        fruitStockStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setNavigation() {
        navigationItem.title = "재고 추가"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeButtonTapped))
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    private func setStepper() {
        stepperAndFruit.keys.forEach { stepper in
            stepper.addTarget(self, action: #selector(stepperDidTapped(sender:)), for: .valueChanged)
        }
    }
    
    @objc private func stepperDidTapped(sender: UIStepper) {
        viewModel
            .fruitStepperTapped(fruit: stepperAndFruit[sender]!, amount: Int(sender.value))
    }
    
    // MARK: - View, Model Binding
    
    private func bind() {
        viewModel
            .publishFruitStock
            .sink { [weak self] stocks in
                for (fruit, amount) in stocks {
                    self?.fruitAndLabel[fruit]?.text = "\(amount)"
                    self?.fruitAndStepper[fruit]?.value = Double(amount)
                }
            }
            .store(in: &cancellBag)
    }
}
