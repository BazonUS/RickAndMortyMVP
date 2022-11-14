//
//  UITableViewCell.swift
//  RickAndMorty
//
//  Created by Aleksei Omelchenko on 10/13/22.
//

import Foundation
import UIKit

class CharacterCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifire = "TableViewCell"
    
    //MARK: - Views
    private lazy var characterView: CharacterView = {
        let view = CharacterView()
        return view
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setupLayout() {
        contentView.addSubview(characterView)
        characterView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }
    }
    
    public func configureCell(model: CharacterModel) {
        characterView.configureCharacterView(model: model)
    }
}



