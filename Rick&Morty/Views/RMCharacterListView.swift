//
//  CharacterListView.swift
//  Rick&Morty
//
//  Created by sofia on 15.08.2023.
//

import UIKit

//      provides a way for the RMCharacterListView to communicate back to it's delegate when a specific character cell is tapped by the user
protocol RMCharacterListViewDelegate: AnyObject {
    func rmCharacterListView(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter)
}

/// View that handles showing list of characters, loader animation, etc.
final class RMCharacterListView: UIView {
    
    public weak var delegate: RMCharacterListViewDelegate?
        
    private let viewModel = RMCharacterListViewViewModel()
    
//    create spinner indicator when opening the Characters View and data is loading
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
//    create collection view with cells which will be populated with characters data
    private let collectionView: UICollectionView = {
//        define layout for collection view to control scroll direction and inset section layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        make collection view hidden by default to not be shown along with spinner while data is not fetched yet
        collectionView.isHidden = false
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        register a cell in a collection view
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier )
//        register footer loader view
        collectionView.register(RMFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "RMFooterLoadingCollectionReusableView")
        return collectionView
    }()
    
//    MARK: - Init
    
//    initialize Characters List View
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(collectionView, spinner)
        addConstraints()
        spinner.startAnimating()
//        sets up communication link between the viewModel and RMCharacterListViewViewModel to enable viewModel to notify RMCharacterListViewViewModel when data needs to be updated
        viewModel.delegate = self
        viewModel.fetchCharacters()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
//            spinner constraints
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
//            collection view constraints
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
//    MARK: - show Characters when data is loaded
    
    private func setUpCollectionView() {
//    define data source for collection view which is Characters ViewModel to make cells being able to display actual data
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }

}

//      tells collectionView to reload the data when data proccessing is ready
extension RMCharacterListView: RMCharacterListViewViewModelDelegate {
    func didSelectCharacter(_ character: RMCharacter) {
        delegate?.rmCharacterListView(self, didSelectCharacter: character)
    }
    
    func didLoadInialCharacters() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData() // Initial fetch
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
}
