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
        
        let request = RMRequest(endpoint: .character, queryParameters: [
        URLQueryItem(name: "name", value: "rick"),
        URLQueryItem(name: "status", value: "alive")
        ])
        print(request.url)
    }

}
