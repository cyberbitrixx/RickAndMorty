//
//  RMCharacterViewController.swift
//  Rick&Morty
//
//  Created by sofia on 24.07.2023.
//

import UIKit


/// Controller to show and browse Characters
final class RMCharacterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
    }
    
//          Set up Characeters List View with constraints
        private func setUpView() {
            characterListView.delegate = self
            view.addSubview(characterListView)
            NSLayoutConstraint.activate([
                characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
        }
        
        
}
