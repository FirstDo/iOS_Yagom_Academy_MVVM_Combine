//
//  Expo1900 - ExpoViewController.swift
//  Created by Taeangel, dudu on 2022/04/11.
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit
import Combine

final class ExpoViewController: UIViewController, Alertable {
  
  private let baseScrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  
  private let baseStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 10
    return stackView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .title1)
    label.adjustsFontForContentSizeCategory = true
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.5
    label.numberOfLines = 2
    label.textAlignment = .center
    return label
  }()
  
  private let posterImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "poster"))
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let visitorStackView = UIStackView()
  
  private let visitorLabel : UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .title2)
    label.adjustsFontForContentSizeCategory = true
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.5
    label.text = "방문객 : "
    return label
  }()
  
  private let visitorValueLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .body)
    label.adjustsFontForContentSizeCategory = true
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.5
    return label
  }()
  
  private let locationStackView = UIStackView()
  
  private let locationLabel : UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .title2)
    label.adjustsFontForContentSizeCategory = true
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.5
    label.text = "개최지 : "
    return label
  }()
  
  private let locationValueLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .body)
    label.adjustsFontForContentSizeCategory = true
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.5
    return label
  }()
  
  private let durationStackView = UIStackView()
  
  private let durationLabel : UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .title2)
    label.adjustsFontForContentSizeCategory = true
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.5
    label.text = "개최 기간 : "
    return label
  }()
  
  private let durationValueLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .body)
    label.adjustsFontForContentSizeCategory = true
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.5
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .body)
    label.adjustsFontForContentSizeCategory = true
    label.numberOfLines = .zero
    return label
  }()
  
  private let buttonStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.distribution = .fill
    stackView.spacing = 30
    return stackView
  }()
  
  private let koreaHeritageButton: UIButton = {
    let button = UIButton()
    button.setTitleColor(.systemBlue, for: .normal)
    button.setTitle("한국의 출품작 보러가기", for: .normal)
    button.titleLabel?.adjustsFontForContentSizeCategory = true
    button.titleLabel?.font = .preferredFont(forTextStyle: .subheadline)
    return button
  }()
  
  private let leftFlagImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "flag"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    return imageView
  }()
  
  private let rightFlagImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "flag"))
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    return imageView
  }()
  
  private let viewModel = ExpoViewModel()
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    attribute()
    addSubViews()
    layout()
    bind(to: viewModel)
    router()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.navigationBar.isHidden = false
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }
  
  // MARK: - Layout & Attribute
  
  private func attribute() {
    view.backgroundColor = .systemBackground
    navigationItem.backButtonTitle = "메인"
  }
  
  private func addSubViews() {
    view.addSubview(baseScrollView)
    baseScrollView.addSubview(baseStackView)
    
    visitorStackView.addArrangedSubviews(visitorLabel, visitorValueLabel)
    locationStackView.addArrangedSubviews(locationLabel, locationValueLabel)
    durationStackView.addArrangedSubviews(durationLabel, durationValueLabel)
    buttonStackView.addArrangedSubviews(leftFlagImageView, koreaHeritageButton, rightFlagImageView)
    baseStackView.addArrangedSubviews(titleLabel, posterImageView, visitorStackView, locationStackView, durationStackView, descriptionLabel, buttonStackView)
  }
  
  private func layout() {
    
    //MARK: - baseScrollView
    
    NSLayoutConstraint.activate([
      baseScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
      baseScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
      baseScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      baseScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    
    //MARK: - baseStackView
    
    baseStackView.directionalLayoutMargins = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
    baseStackView.isLayoutMarginsRelativeArrangement = true
    
    NSLayoutConstraint.activate([
      baseStackView.topAnchor.constraint(equalTo: baseScrollView.topAnchor),
      baseStackView.bottomAnchor.constraint(equalTo: baseScrollView.bottomAnchor),
      baseStackView.leadingAnchor.constraint(equalTo: baseScrollView.leadingAnchor),
      baseStackView.trailingAnchor.constraint(equalTo: baseScrollView.trailingAnchor),
      baseStackView.widthAnchor.constraint(equalTo: baseScrollView.widthAnchor)
    ])
  }
  
  private func bind(to viewModel: ExpoViewModel) {
    let input = ExpoViewModel.Input()
    let output = viewModel.transform(input: input)
    
    output
      .expoData.sink { finished in
        print(finished)
      } receiveValue: { [weak self] expo in
        self?.titleLabel.text = expo.title?.divideLine(with: "(")
        self?.visitorValueLabel.text = expo.visitors?.decimalStyleFormat()?.add(text: " 명")
        self?.locationLabel.text = expo.location
        self?.durationLabel.text = expo.duration
        self?.descriptionLabel.text = expo.description
      }.store(in: &cancellables)
  }
  
  private func router() {
    koreaHeritageButton.addTarget(self, action: #selector(didTapKoreaHeritageButton(_:)), for: .touchUpInside)
  }
  
  @objc private func didTapKoreaHeritageButton(_ sender: UIButton) {
    let heritageViewController = HeritageViewController()
    navigationController?.pushViewController(heritageViewController, animated: true)
  }
}

//MARK: - Private Extension

private extension Int {
  
  func decimalStyleFormat() -> String? {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    guard let formattedNumber = numberFormatter.string(for: self) else {
      return "0"
    }
    return formattedNumber
  }
}

private extension String {
  
  func add(text: String) -> String? {
    return self + text
  }
  
  func divideLine(with target: Character) -> String? {
    return self.split(separator: target).joined(separator: "\("\n")\(target)")
  }
}
