//
//  HeritageViewModel.swift
//  Expo1900
//
//  Created by 김도연 on 2022/06/12.
//

import UIKit
import Combine

final class HeritageViewModel: ViewModelType {
  private let items = "items"
  
  struct Input {
    // emtpy
  }
  
  struct Output {
    let heritageData: AnyPublisher<[Heritage], Error>
  }
  
  func transform(input: Input) -> Output {
    let heritage = Just(items)
      .tryMap { name in
        guard let data = NSDataAsset(name: name)?.data else {
          throw ParseError.invalidName
        }
        
        return data
      }
      .decode(type: [Heritage].self, decoder: JSONDecoder())
      .eraseToAnyPublisher()
    
    return Output(heritageData: heritage)
  }
}

