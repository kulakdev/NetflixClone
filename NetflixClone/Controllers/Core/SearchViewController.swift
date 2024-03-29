//
//  SearchViewController.swift
//  NetflixClone
//
//  Created by Macbook Pro on 27.01.2024.
//

import UIKit

class SearchViewController: UIViewController {
    private var titles = [Movie]()
    
    private let discoverTable: UITableView = {
        let table = UITableView()
        table.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultViewController())
        controller.searchBar.placeholder = "Search for a Movie or a TV show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
        view.addSubview(discoverTable)
        
        
        discoverTable.delegate = self
        discoverTable.dataSource = self
        
        fetchDiscoverMovies()
        searchController.searchResultsUpdater = self
    }
    
    private func fetchDiscoverMovies() {
        APICaller.shared.getUpcomingMovies { movie in
            switch movie {
            case .success(let success):
                self.titles = success
                DispatchQueue.main.async {
                    self.discoverTable.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        let model = MovieTitleViewModel(titleName: title.originalTitle ?? "error unknown name", posterURL: title.backdropPath ?? "")
        cell.configure(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultrsController = searchController.searchResultsController as? SearchResultViewController else {
                return
            }
        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    resultrsController.titles = titles
                    resultrsController.searchResultsCollectionView.reloadData()
                case .failure(let failure):
                    print(failure)
                }
            }
        }
    }
}
