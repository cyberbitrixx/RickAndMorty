//
//  RMCharacterCollectionViewCell.swift
//  Rick&Morty
//
//  Created by sofia on 15.08.2023.
//

import UIKit


/// Single cell for a character
final class RMCharacterCollectionViewCell: UICollectionViewCell {
    
//    create let for cell identifier String for convenience to register a cell further
    static let cellIdentifier = "RMCharacterCollectionViewCell"
    
//    imageView for actual character's image in a cell
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
//    label for character's status data from RMCharacterStatus Model
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    label for character's name
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
//        adding subViews here instead of doing it directly because contentView takes care of safe area for CollectionViews
        contentView.addSubViews(imageView, nameLabel, statusLabel)
        addConstraints()
        setUpLayer()
    }
    
    required init?(coder: NSCoder){
        fatalError("Unsupported")
    }
    
    //        set the radius for rounded cells and shadow
    private func setUpLayer() {
                contentView.layer.cornerRadius = 8
                contentView.layer.shadowColor = UIColor.label.cgColor
                contentView.layer.cornerRadius = 8
                contentView.layer.shadowOffset = CGSize(width: -4, height: 3)
                contentView.layer.shadowOpacity = 0.4
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            statusLabel.heightAnchor.constraint(equalToConstant: 35),
            nameLabel.heightAnchor.constraint(equalToConstant: 35),
            
            statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3),


        ])

    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer()
    }
    
//    get rid of image, status and name data to prepare a cell for reusing
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
//    configure a cell with cell ViewModel
    public func configure(with viewModeel: RMCharacterCollectionViewCellViewModel) {
        nameLabel.text = viewModeel.characterName
        statusLabel.text = viewModeel.charaterStatusText
        viewModeel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
