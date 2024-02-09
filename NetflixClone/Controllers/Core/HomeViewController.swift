//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by Macbook Pro on 27.01.2024.
//

/// - NOTE: This controller controls what's being displayed on the home screen
///
import UIKit
enum Section: Int {
    case trendingMovies = 0
    case trendingTv = 1
    case popular = 2
    case upcoming = 3
    case topRated = 4
}

class HomeViewController: UIViewController {
    
    let sectionTitles: [String] = ["Trending Movies", "Trending TV", "Popular", "Upcoming Movies", "Top rated"]
    
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
        
        configureNavbar()
//        getTrendingMovies()
//        getTrendingTvs()
//        getUpcomingMovies()
        getPopularMovies()
        getTopRatedMovies()
        
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
    }
    
    
    private func configureNavbar() {
        /// Add image
        let image = UIImage(named: "netflixLogo")
        
        /// REDUNDANT  Make image rendering mode == .alwaysOriginal so that it renders as colored and not accent color
//        image = image?.withRenderingMode(.alwaysOriginal)
        
        /// Create button with an image
        let imageview = UIButton(type: .custom)
        imageview.setImage(image, for: .normal)
        
        /// Create button item
        let buttonItem = UIBarButtonItem(customView: imageview)
        
        /// Assign array to rightBarButtonItems
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil),
        ]
        
        /// Assign buttonItem to leftBarButtonItem
        navigationItem.leftBarButtonItem = buttonItem
        
        /// Style the custom button
        let imageviewConstraints = [
        imageview.widthAnchor.constraint(equalToConstant: 20),
        imageview.heightAnchor.constraint(equalToConstant: 36),
        ]
        
        NSLayoutConstraint.activate(imageviewConstraints)
    }
    
    
    override func viewDidLayoutSubviews() {
        /// Signals to the superview that it finialized laying out it's subviews
        super.viewDidLayoutSubviews()
        /// Stretch to bounds
        homeFeedTable.frame = view.bounds
    }
    
    private func getTrendingMovies() {
        APICaller.shared.getTrendingMovies { results in
            switch results {
            case .success(let movies):
                print(movies)
            case .failure(let error):
                print(error)
            }

        }
        
    }
    
    private func getTrendingTvs() {
        APICaller.shared.getTrandingTvs { results in
            return
        }
    }
    
    private func getUpcomingMovies() {
        APICaller.shared.getUpcomingMovies { results in
            return
        }
    }
    
    private func getPopularMovies() {
        APICaller.shared.getPopularMovies { _ in
            return
        }
    }
    
    private func getTopRatedMovies() {
        APICaller.shared.getTopRatedMovies { _ in
            return
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    /// Assigns number of sections in our table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
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
        switch indexPath.section  {
        case Section.trendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let success):
                    cell.configure(with: success)
                case .failure(let failure):
                    print(failure)
                }
            }
            
        case Section.trendingTv.rawValue:
            APICaller.shared.getTrandingTvs { result in
                switch result {
                case .success(let success):
                    cell.configure(with: success)
                case .failure(let failure):
                    print(failure)
                }
            }
            
        case Section.popular.rawValue:
            APICaller.shared.getPopularMovies { result in
                switch result {
                case .success(let success):
                    cell.configure(with: success)
                case .failure(let failure):
                    print(failure)
                }
            }
            
        case Section.upcoming.rawValue:
            APICaller.shared.getUpcomingMovies { result in
                switch result {
                case .success(let success):
                    cell.configure(with: success)
                case .failure(let failure):
                    print(failure)
                }
            }
            
        case Section.topRated.rawValue:
            APICaller.shared.getTopRatedMovies { result in
                switch result {
                case .success(let success):
                    cell.configure(with: success)
                case .failure(let failure):
                    print(failure)
                }
            }
        default:
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(
            x: header.bounds.origin.x + 20,
            y: header.bounds.origin.y, 
            width: 100,
            height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
}
