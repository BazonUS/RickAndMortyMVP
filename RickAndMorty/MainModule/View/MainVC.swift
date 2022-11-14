//
//  MainVC.swift
//  RickAndMorty
//
//  Created by Aleksei Omelchenko on 10/13/22.
//

import UIKit
import SnapKit

class MainVC: UIViewController {
    
    //MARK: - Properties
    enum Section: CaseIterable {
        case main
    }
    
    var presenter: MainViewPresenterProtocol!
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.identifire)
        tableView.delegate = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var dataSource = UITableViewDiffableDataSource<Section, CharacterModel>(tableView: tableView) { [weak self] tableView, indexPath, item in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifire , for: indexPath) as? CharacterCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        if let characters = self?.presenter?.characters {
            cell.configureCell(model: characters[indexPath.row])
        }
        return cell
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configurationUI()
    }
    
    //MARK: - Methods
    private func configurationUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
    
    func updateTable(withVariants variants: [CharacterModel]) {
        debugLog(object: self)
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, CharacterModel>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(variants)
        self.dataSource.applySnapshotUsingReloadData(snapshot)
    }
}

//MARK: - UITableViewDataSource
extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.characters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let count = presenter.characters?.count, count > 1 {
            let lastElement = count - 1
            if indexPath.row == lastElement {
                presenter.requestData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let description = presenter.characters?[indexPath.row]
        presenter.tapOnTheCharacter(character: description)
    }
}

//MARK: - MainViewProtocol
extension MainVC: MainViewProtocol {
    
    func success(with characters: [CharacterModel]) {
        updateTable(withVariants: characters)
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
