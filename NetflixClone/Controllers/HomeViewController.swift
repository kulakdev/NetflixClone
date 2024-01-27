//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by Macbook Pro on 27.01.2024.
//

/// - NOTE: This controller controls what's being displayed on the home screen
///
import UIKit

class HomeViewController: UIViewController {
    
    private let homeFeedTable: UITableView = {
        /// Initialize the table view which is an instance of UITableView
        let table = UITableView(frame: .zero, style: .grouped)
        
        /// Register CollectionViewTableViewCell as a cell, reuse identifier is specified inside CollectionViewTableViewCell
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        
        /// Return the created table
        return table
    }()
    
    override func viewDidLoad() {
        /// Signal to the super class that the view finished loading
        super.viewDidLoad()
        
        /// Give our view a background color of UIColor.systemBackground
        view.backgroundColor = .systemBackground
        
        /// Add the table to this view controller
        view.addSubview(homeFeedTable)
        
        /// Next two lines allow us to create cells and assign data from an extension at the bottom of this file
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        homeFeedTable.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
    }
    
    
    override func viewDidLayoutSubviews() {
        /// Signals to the superview that it finialized laying out it's subviews
        super.viewDidLayoutSubviews()
        /// Stretch to bounds
        homeFeedTable.frame = view.bounds
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    /// Assigns number of sections in our table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 20
    }
    /// Assigns amount of rows in our table view section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    /// Creates the cell that will be used in each row inside our table view section
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    /// Defines the height for each cell we create
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    /// Defines height for the header of the section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
