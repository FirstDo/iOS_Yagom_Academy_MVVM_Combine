//
//  Alertable.swift
//  JuiceMaker+Combine
//
//  Created by 김도연 on 2022/06/07.
//

import UIKit

protocol Alertable: UIViewController {
    // MARK: Empty
}

extension Alertable {
    func show(
        title: String? = nil,
        message: String? = nil,
        okAction: (() -> Void)? = nil,
        cancelAction: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let okAction = okAction {
            let okAlert = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
                okAction()
            }
            alert.addAction(okAlert)
        }
        
        if let cancelAction = cancelAction {
            let cancelAlert = UIAlertAction(title: "취소", style: .default) { [weak self] _ in
                cancelAction()
            }
            alert.addAction(cancelAlert)
        }
        
        present(alert, animated: true)
    }
}
