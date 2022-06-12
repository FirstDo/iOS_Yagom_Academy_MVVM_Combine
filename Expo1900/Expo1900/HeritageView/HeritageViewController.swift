//
//  HeritageViewController.swift
//  Expo1900
//
//  Created by Taeangel, dudu on 2022/04/13.
//

import UIKit
import Combine

final class HeritageViewController: UIViewController, Alertable {
  private typealias DataSource = UITableViewDiffableDataSource<Int, Heritage>
  private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Heritage>
  
  private var dataSource: DataSource!
  private var snapshot: Snapshot = Snapshot()
  
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  private var cancellables = Set<AnyCancellable>()
  private let viewModel = HeritageViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    layout()
    attribute()
    bind(to: viewModel)
  }
  
  private func layout() {
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
    ])
  }
  
  private func attribute() {
    view.backgroundColor = .systemBackground
    title = "한국의 출품작"
    setTableView()
  }
  
  private func setTableView() {
    tableView.register(HeritageCell.self, forCellReuseIdentifier: HeritageCell.identifier)
    tableView.delegate = self
    
    makeDataSource()
    makeSnapshot()
  }
  
  private func bind(to viewModel: HeritageViewModel) {
    let output = viewModel.transform(input: HeritageViewModel.Input())
    
    output.heritageData.sink { finished in
      print(finished)
    } receiveValue: { [weak self] heritageList in
      self?.applySnapshot(heritageList)
    }
    .store(in: &cancellables)
  }
  
  private func makeDataSource() {
    dataSource = DataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
      let cell = tableView.dequeueReusableCell(withIdentifier: HeritageCell.identifier, for: indexPath) as? HeritageCell
      cell?.update(with: itemIdentifier)
      return cell
    }
  }
  
  private func makeSnapshot() {
    snapshot.appendSections([0])
    dataSource.apply(snapshot)
  }
  
  private func applySnapshot(_ heritages: [Heritage]) {
    snapshot.appendItems(heritages)
    dataSource.apply(snapshot)
  }
}

//MARK: - TableView Delegate

extension HeritageViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    guard let heritage = snapshot.itemIdentifiers[safe: indexPath.row] else { return }
    
    let heritageDetailViewController = HeritageDetailViewController(heritage: heritage)
    navigationController?.pushViewController(heritageDetailViewController, animated: true)
  }
}
