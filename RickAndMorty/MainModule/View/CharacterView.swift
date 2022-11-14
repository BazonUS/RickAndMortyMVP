//
//  CharacterView.swift
//  RickAndMorty
//
//  Created by Aleksei Omelchenko on 10/13/22.
//

import Foundation
import UIKit
import SnapKit
import Alamofire
import Kingfisher

class CharacterView: UIView{
    
    //MARK: - Properties
    private let characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "camera.metering.unknown")
        return imageView
    }()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private let characterGenderLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let characterStatusView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let characterStatusLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurationUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configurationUI()
    }
    
    //MARK: - Methods
    private func configurationUI() {
        
        addSubview(characterImage)
        characterImage.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(10)
            make.width.height.equalTo(120)
        }
        
        addSubview(characterNameLabel)
        characterNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalTo(characterImage.snp.right).offset(18)
            make.right.equalToSuperview().inset(5)
        }
        
        addSubview(characterGenderLabel)
        characterGenderLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(characterImage.snp.right).offset(18)
            make.right.equalToSuperview().inset(5)
        }
        
        addSubview(characterStatusView)
        characterStatusView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.left.equalTo(characterImage.snp.right).offset(18)
            make.height.equalTo(25)
            make.width.equalTo(125)
        }
        
        characterStatusView.addSubview(characterStatusLabel)
        characterStatusLabel.snp.makeConstraints { make in
            make.center.equalTo(characterStatusView)
        }
    }
    
    public func configureCharacterView(model: CharacterModel) {
        let url = URL(string: model.image)
        let processor = RoundCornerImageProcessor(cornerRadius: 92)
        characterImage.kf.setImage(with: url, options: [.processor(processor)])
        characterNameLabel.text = model.name
        characterGenderLabel.text = "\(model.species), \(model.gender.lowercased())"
        switch model.status {
        case "Alive" : characterStatusView.backgroundColor = Constants.backgroundGreen
            characterStatusLabel.textColor = Constants.textGreen
        case "Dead" : characterStatusView.backgroundColor = Constants.backgroundRed
            characterStatusLabel.textColor = Constants.textRed
        case "unknown" : characterStatusView.backgroundColor = Constants.backgroundGray
            characterStatusLabel.textColor = Constants.textGray
        default:  characterStatusView.backgroundColor = Constants.backgroundGray
            characterStatusLabel.textColor = Constants.textGray

        }
        characterStatusLabel.text = model.status.uppercased()

        }
}

