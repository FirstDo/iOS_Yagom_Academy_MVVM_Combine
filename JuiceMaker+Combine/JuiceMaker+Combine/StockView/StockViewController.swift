//
//  StockViewController.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/07.
//

import UIKit
import SnapKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        setView()
        setLayout()
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
}
