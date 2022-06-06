//
//  StockViewController.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/07.
//

import UIKit

final class StockViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        setView()
    }
    
    private func setView() {
        view.backgroundColor = .systemBackground
    }
}
