//
//  ViewController.swift
//  Proof Of Concept
//
//  Created by Raghu on 21/12/20.
//

import UIKit

class ViewController: UIViewController {

    let welcomeTableView = UITableView()
    var safeArea: UILayoutGuide!
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        setupTableView()
      }
    
    func setupTableView() {
        view.addSubview(welcomeTableView)
        welcomeTableView.translatesAutoresizingMaskIntoConstraints = false
        welcomeTableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        welcomeTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        welcomeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        welcomeTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }


}

