//
//  DescriptionVC.swift
//  RickAndMorty
//
//  Created by Aleksei Omelchenko on 10/14/22.
//

import Foundation
import UIKit
import SnapKit
import Alamofire
import Kingfisher

class DescriptionVC: UIViewController{
    
    //MARK: - Properties
    var presenter: DescriptionViewPresenterProtocol!
    
    private let characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "camera.metering.unknown")
        return imageView
    }()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.numberOfLines = 0
        return label
    }()
    
    private let characterGenderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
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
    
    private let characterOriginLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var personalInfoStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [characterNameLabel, characterGenderLabel, characterOriginLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        presenter.setDescription()
        configurationUI()
    }
    
    //MARK: - Private methods
    private func configurationUI() {
        view.backgroundColor = .white
        view.addSubview(characterImage)
        characterImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.height.equalTo(ScreenSize.width - 100)
        }
        
        view.addSubview(characterStatusView)
        characterStatusView.snp.makeConstraints { make in
            make.top.equalTo(characterImage.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(ScreenSize.width - 100)
        }
        
        characterStatusView.addSubview(characterStatusLabel)
        characterStatusLabel.snp.makeConstraints { make in
            make.center.equalTo(characterStatusView)
        }
        
        view.addSubview(personalInfoStack)
        personalInfoStack.snp.makeConstraints { make in
            make.top.equalTo(characterStatusView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(ScreenSize.width - 100)
        }
    }
}

extension DescriptionVC: DescriptionViewProtocol {
    func setDescription(description: CharacterModel?) {
        let url = URL(string: description!.image)
        let processor = RoundCornerImageProcessor(cornerRadius: 92)
        characterImage.kf.setImage(with: url, options: [.processor(processor)])
        characterNameLabel.text = description?.name
        characterGenderLabel.text = "\(description!.species), \(description!.gender.lowercased())"
        characterOriginLabel.text = "📍" + description!.origin.name
        switch description?.status {
        case "Alive" : characterStatusView.backgroundColor = Constants.backgroundGreen
            characterStatusLabel.textColor = Constants.textGreen
        case "Dead" : characterStatusView.backgroundColor = Constants.backgroundRed
            characterStatusLabel.textColor = Constants.textRed
        case "unknown" : characterStatusView.backgroundColor = Constants.backgroundGray
            characterStatusLabel.textColor = Constants.textGray
        default:  characterStatusView.backgroundColor = Constants.backgroundGray
            characterStatusLabel.textColor = Constants.textGray
        }
        characterStatusLabel.text = description?.status.uppercased()
    }
}

