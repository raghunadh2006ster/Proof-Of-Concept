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
    private var welcomeViewModel : WelcomeViewModel!
    private var dataSource : WelcomeTableViewDataSource<TableViewCell,Row>!
    
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
        welcomeTableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate(){
        self.welcomeViewModel =  WelcomeViewModel()
        self.welcomeViewModel.bindWelcomeViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        self.dataSource = WelcomeTableViewDataSource(cellIdentifier: "TableViewCell", items: self.welcomeViewModel.welcomeData.rows, configureCell: { (cell, wvm) in
            let title = (wvm.title != nil && wvm.title!.count > 0) ? wvm.title : "No title avialable"
            cell.titleLabel.text = title
            let description = (wvm.rowDescription != nil && wvm.rowDescription!.count > 0) ? wvm.rowDescription : "No description avialable"
            cell.descriptionLabel.text = description
            if (wvm.imageHref != nil && wvm.imageHref!.count > 0) {
                let imgUrl = wvm.imageHref!.removingPercentEncoding
                APIService.getImage(imgUrl!, 1) {(img, e, url) in
                    if (img == nil) {return}
                    cell.img.image = img;
                }
            }
        })
        
        DispatchQueue.main.async {
            self.welcomeTableView.rowHeight = UITableView.automaticDimension
            self.welcomeTableView.dataSource = self.dataSource
            self.welcomeTableView.reloadData()
        }
    }
}

