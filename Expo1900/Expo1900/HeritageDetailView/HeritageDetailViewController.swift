//
//  HeritageDetailViewController.swift
//  Expo1900
//
//  Created by Taeangel, dudu on 2022/04/13.
//

import UIKit
import Combine

//MARK: - ViewController

final class HeritageDetailViewController: UIViewController {
  
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
  
  private lazy var heritageImageView: UIImageView = {
    let imageView = UIImageView()
    let width = 0.3 * self.view.bounds.width
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .preferredFont(forTextStyle: .body)
    label.adjustsFontForContentSizeCategory = true
    label.numberOfLines = .zero
    return label
  }()
  
  private let heritage: Heritage
  private let viewModel = HeritageDetailViewModel()
  private var cancellables = Set<AnyCancellable>()
  
  init(heritage: Heritage) {
    self.heritage = heritage
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addSubViews()
    layout()
    attribute()
    bind(to: viewModel)
  }
  
  //MARK: - Layout
  
  private func addSubViews() {
    view.addSubviews(baseScrollView)
    baseScrollView.addSubviews(baseStackView)
    baseStackView.addArrangedSubviews(heritageImageView, descriptionLabel)
  }
  
  private func layout() {
    //MARK: - baseScrollView
    
    NSLayoutConstraint.activate([
      baseScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      baseScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      baseScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      baseScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
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
  
  private func attribute() {
    view.backgroundColor = .systemBackground
  }
  
  private func bind(to viewModel: HeritageDetailViewModel) {
    let input = HeritageDetailViewModel.Input(heritage: heritage)
    let output = viewModel.transform(input: input)
    
    output
      .heritageData
      .sink { [weak self] heritage in
        self?.title = heritage.name
        self?.descriptionLabel.text = heritage.description
        self?.heritageImageView.image = UIImage(named: heritage.imageName!)
      }.store(in: &cancellables)
  }
}
