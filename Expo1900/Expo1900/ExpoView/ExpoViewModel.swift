//
//  ExpoViewModel.swift
//  Expo1900
//
//  Created by 김도연 on 2022/06/12.
//

import Combine
import UIKit

final class ExpoViewModel: ViewModelType {
  private let fileName = "exposition_universelle_1900"
  
  struct Input {
      // empty
  }
  
  struct Output {
    let expoData: AnyPublisher<Expo, Error>
  }
  
  func transform(input: Input) -> Output {
    let expo = Just("exposition_universelle_1900")
      .tryMap { name in
        guard let data = NSDataAsset(name: name)?.data else {
          throw ParseError.invalidName
        }
        
        return data
      }
      .decode(type: Expo.self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
    
    return Output(expoData: expo)
  }
}
