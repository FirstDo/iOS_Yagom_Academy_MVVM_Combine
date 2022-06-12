//
//  ViewModelType.swift
//  Calculator+Combine
//
//  Created by 김도연 on 2022/06/12.
//

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
