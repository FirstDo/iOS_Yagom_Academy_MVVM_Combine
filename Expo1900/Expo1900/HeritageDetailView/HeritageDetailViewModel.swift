//
//  HeritageDetailViewModel.swift
//  Expo1900
//
//  Created by 김도연 on 2022/06/12.
//

import Combine

final class HeritageDetailViewModel: ViewModelType {
  struct Input {
    let heritage: Heritage
  }
  
  struct Output {
    let heritageData: Just<Heritage>
  }
  
  func transform(input: Input) -> Output {
    return Output(heritageData: Just(input.heritage))
  }
}
