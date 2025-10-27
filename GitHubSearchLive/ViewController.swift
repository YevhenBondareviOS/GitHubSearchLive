//
//  ViewController.swift
//  GitHubSearchLive
//
//  Created by Evgenii Bondarev on 27.10.2025.
//

import UIKit
import Apollo

class ViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, RepositoryItem>!
    private var searchBar: UISearchBar!
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupCollectionView()
        setupDataSource()
        setupActivityIndicator()
        fetchRepositories()
    }
    
    private func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search repositories..."
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemBlue
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGroupedBackground
        collectionView.delegate = self
        collectionView.register(RepositoryCollectionViewCell.self, forCellWithReuseIdentifier: RepositoryCollectionViewCell.identifier)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, RepositoryItem>(
            collectionView: collectionView
        ) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RepositoryCollectionViewCell.identifier,
                for: indexPath
            ) as! RepositoryCollectionViewCell
            cell.configure(with: item)
            return cell
        }
    }
    
    private func fetchRepositories(searchQuery: String = "test") {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        
        let query = GitHubAPI.SearchRepositoriesQuery(query: searchQuery, first: 40, after: nil)
        Network.shared.fetch(query: query, cachePolicy: .fetchIgnoringCacheCompletely) { result in
          switch result {
          case .success(let graphQLResult):
            if let data = graphQLResult.data {
              let connection = data.search
              let edges = connection.edges?.compactMap { $0?.node?.asRepository }
              let hasNext = connection.pageInfo.hasNextPage
              let endCursor = connection.pageInfo.endCursor

              // Map the data for your UI
              let repos = edges?.map { repo in
                return RepositoryItem(
                  id: repo.id,
                  fullName: repo.nameWithOwner,
                  description: repo.description ?? "",
                  stars: repo.stargazerCount,
                  forks: repo.forkCount,
                  url: repo.url
                )
              } ?? []

              print("Repos:", repos.count)
              print("Has next page:", hasNext, "End cursor:", endCursor ?? "nil")
              
              // Update UI on main thread
              DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.updateCollectionView(with: repos)
              }
            }

            if let errors = graphQLResult.errors {
              print("GraphQL errors:", errors)
              DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.showErrorAlert(message: "GraphQL Error: \(errors.first?.message ?? "Unknown error")")
              }
            }

          case .failure(let error):
            print("Network error:", error)
            DispatchQueue.main.async {
              self.activityIndicator.stopAnimating()
              self.showErrorAlert(message: "Network Error: \(error.localizedDescription)")
            }
          }
        }
    }
    
    private func updateCollectionView(with repositories: [RepositoryItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, RepositoryItem>()
        snapshot.appendSections([0])
        snapshot.appendItems(repositories)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 80)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        performSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    private func performSearch() {
        guard let searchText = searchBar.text, !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            // If search is empty, show default Swift repos
            fetchRepositories()
            return
        }
        
        let userSearchTerm = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Combine user search term with filters and sorting
//        sort:stars-desc         # Sort by stars (descending)
//        sort:stars-asc          # Sort by stars (ascending)
//        sort:forks-desc         # Sort by forks (descending)
//        sort:updated-desc       # Sort by last updated (descending)
//        sort:created-desc       # Sort by creation date (descending)
        let searchQuery = "\(userSearchTerm) language:swift stars:>100 sort:stars-desc"
        
        fetchRepositories(searchQuery: searchQuery)
    }
}

