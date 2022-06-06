//
//  CalculatorViewController.swift
//  Calculator+Combine
//
//  Created by 김도연 on 2022/06/07.
//

import UIKit
import SnapKit

extension UIColor {
    static let number = UIColor.systemGray
    static let `operator` = UIColor.systemOrange
    static let function = UIColor.systemGray6
}

final class CalculatorViewController: UIViewController {
    private let logScrollView: UIScrollView = {
        let scrollview = UIScrollView()
        
        return scrollview
    }()
    
    private let logStackView: UIStackView = {
        let stackview = UIStackView()
        
        return stackview
    }()
    
    private lazy var inputStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [operatorLabel, numberLabel])
        
        return stackview
    }()
    
    private let operatorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        
        return label
    }()
    
    private lazy var touchPadStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [
            firstNumberStackView,
            secondNumberStackView,
            thirdNumberStackView,
            fourthNumberStackView,
            fifthNumberStackView
        ])
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        stackview.spacing = 8
        
        return stackview
    }()
    
    private lazy var firstNumberStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [acButton, ceButton, signButton, divideButton])
        stackview.distribution = .fillEqually
        stackview.spacing = 8
        
        return stackview
    }()
    
    private lazy var secondNumberStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [sevenButton, eightButton, nineButton, multiplyButton])
        stackview.distribution = .fillEqually
        stackview.spacing = 8
        
        return stackview
    }()
    
    private lazy var thirdNumberStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [fourButton, fiveButton, sixButton, substractButton])
        stackview.distribution = .fillEqually
        stackview.spacing = 8
        
        return stackview
    }()
    
    private lazy var fourthNumberStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [oneButton, twoButton, threeButton, plusButton])
        stackview.distribution = .fillEqually
        stackview.spacing = 8
        
        return stackview
    }()
    
    private lazy var fifthNumberStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [zeroButton, twoZeroButton, dotButton, equalButton])
        stackview.distribution = .fillEqually
        stackview.spacing = 8
        
        return stackview
    }()
    
    private let acButton: UIButton = {
        let button = UIButton()
        button.setTitle("AC", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .function
        
        return button
    }()
    
    private let ceButton: UIButton = {
        let button = UIButton()
        button.setTitle("CE", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .function
        
        return button
    }()
    
    private let signButton: UIButton = {
        let button = UIButton()
        button.setTitle("⁺⁄₋", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .function
        
        return button
    }()
    
    private let divideButton: UIButton = {
        let button = UIButton()
        button.setTitle("÷", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .operator
        
        return button
    }()
    
    private let multiplyButton: UIButton = {
        let button = UIButton()
        button.setTitle("×", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .operator
        
        return button
    }()
    
    private let substractButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .operator
        
        return button
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .operator
        
        return button
    }()
    
    private let equalButton: UIButton = {
        let button = UIButton()
        button.setTitle("=", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .operator
        
        return button
    }()
    
    private let oneButton: UIButton = {
        let button = UIButton()
        button.setTitle("1", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .number
        
        return button
    }()
    
    private let twoButton: UIButton = {
        let button = UIButton()
        button.setTitle("2", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .number
        
        return button
    }()
    
    private let threeButton: UIButton = {
        let button = UIButton()
        button.setTitle("3", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .number
        
        return button
    }()
    
    private let fourButton: UIButton = {
        let button = UIButton()
        button.setTitle("4", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .number
        
        return button
    }()
    
    private let fiveButton: UIButton = {
        let button = UIButton()
        button.setTitle("5", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .number
        
        return button
    }()
    
    private let sixButton: UIButton = {
        let button = UIButton()
        button.setTitle("6", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .number
        
        return button
    }()
    
    private let sevenButton: UIButton = {
        let button = UIButton()
        button.setTitle("7", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .number
        
        return button
    }()
    
    private let eightButton: UIButton = {
        let button = UIButton()
        button.setTitle("8", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .number
        
        return button
    }()
    
    private let nineButton: UIButton = {
        let button = UIButton()
        button.setTitle("9", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .number
        
        return button
    }()
    
    private let zeroButton: UIButton = {
        let button = UIButton()
        button.setTitle("0", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .number
        return button
    }()
    
    private let twoZeroButton: UIButton = {
        let button = UIButton()
        button.setTitle("00", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .number
        
        return button
    }()
    
    private let dotButton: UIButton = {
        let button = UIButton()
        button.setTitle(".", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .number
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        setView()
        setLayout()
    }
    
    private func setView() {
        view.backgroundColor = .black
    }
    
    private func setLayout() {
        view.addSubview(logScrollView)
        logScrollView.addSubview(logStackView)
        view.addSubview(inputStackView)
        view.addSubview(touchPadStackView)
        
        logScrollView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        logStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        inputStackView.snp.makeConstraints {
            $0.top.equalTo(logStackView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(logScrollView)
        }
        
        acButton.snp.makeConstraints {
            $0.width.equalTo(acButton.snp.height)
        }
        
        touchPadStackView.snp.makeConstraints {
            $0.top.equalTo(inputStackView.snp.bottom).offset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.leading.trailing.equalTo(logScrollView)
        }
    }
}

