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
    
    // Filter buttons
    private var languageButton: UIButton!
    private var sortByButton: UIButton!
    private var sortOrderButton: UIButton!
    
    // Filter properties
    private var selectedLanguage: String = "swift"
    private var selectedSortBy: String = "stars"
    private var selectedSortOrder: String = "desc"
    
    private let languages = ["swift", "javascript", "python", "java", "typescript", "go", "rust", "kotlin", "php", "ruby"]
    private let sortOptions = ["stars", "forks", "updated", "created"]
    private let sortOrders = ["desc", "asc"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupFilterButtons()
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
    
    private func setupFilterButtons() {
        // Language button
        languageButton = UIButton(type: .system)
        languageButton.setTitle("Language: Swift", for: .normal)
        languageButton.backgroundColor = .systemBlue
        languageButton.setTitleColor(.white, for: .normal)
        languageButton.layer.cornerRadius = 8
        languageButton.addTarget(self, action: #selector(languageButtonTapped), for: .touchUpInside)
        
        // Sort by button
        sortByButton = UIButton(type: .system)
        sortByButton.setTitle("Sort: Stars", for: .normal)
        sortByButton.backgroundColor = .systemGreen
        sortByButton.setTitleColor(.white, for: .normal)
        sortByButton.layer.cornerRadius = 8
        sortByButton.addTarget(self, action: #selector(sortByButtonTapped), for: .touchUpInside)
        
        // Sort order button
        sortOrderButton = UIButton(type: .system)
        sortOrderButton.setTitle("Order: ↓", for: .normal)
        sortOrderButton.backgroundColor = .systemOrange
        sortOrderButton.setTitleColor(.white, for: .normal)
        sortOrderButton.layer.cornerRadius = 8
        sortOrderButton.addTarget(self, action: #selector(sortOrderButtonTapped), for: .touchUpInside)
        
        // Stack view for buttons
        let stackView = UIStackView(arrangedSubviews: [languageButton, sortByButton, sortOrderButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 40)
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
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 56), // 8 + 40 + 8 spacing
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
    
    private func fetchRepositories(searchQuery: String? = nil) {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        
        let finalQuery = searchQuery ?? buildSearchQuery(userSearchTerm: "")
        let query = GitHubAPI.SearchRepositoriesQuery(query: finalQuery, first: 40, after: nil)
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
            // If search is empty, show default repos with current filters
            fetchRepositories()
            return
        }
        
        let userSearchTerm = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let searchQuery = buildSearchQuery(userSearchTerm: userSearchTerm)
        
        fetchRepositories(searchQuery: searchQuery)
    }
    
    private func buildSearchQuery(userSearchTerm: String) -> String {
        var query = userSearchTerm
        query += " language:\(selectedLanguage)"
        query += " stars:>100"
        query += " sort:\(selectedSortBy)-\(selectedSortOrder)"
        return query
    }
    
    // MARK: - Button Actions
    
    @objc private func languageButtonTapped() {
        let alert = UIAlertController(title: "Select Language", message: nil, preferredStyle: .actionSheet)
        
        for language in languages {
            let action = UIAlertAction(title: language.capitalized, style: .default) { _ in
                self.selectedLanguage = language
                self.languageButton.setTitle("Language: \(language.capitalized)", for: .normal)
                self.performSearch()
            }
            alert.addAction(action)
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // For iPad
        if let popover = alert.popoverPresentationController {
            popover.sourceView = languageButton
            popover.sourceRect = languageButton.bounds
        }
        
        present(alert, animated: true)
    }
    
    @objc private func sortByButtonTapped() {
        let alert = UIAlertController(title: "Sort By", message: nil, preferredStyle: .actionSheet)
        
        for sortOption in sortOptions {
            let action = UIAlertAction(title: sortOption.capitalized, style: .default) { _ in
                self.selectedSortBy = sortOption
                self.sortByButton.setTitle("Sort: \(sortOption.capitalized)", for: .normal)
                self.performSearch()
            }
            alert.addAction(action)
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // For iPad
        if let popover = alert.popoverPresentationController {
            popover.sourceView = sortByButton
            popover.sourceRect = sortByButton.bounds
        }
        
        present(alert, animated: true)
    }
    
    @objc private func sortOrderButtonTapped() {
        let alert = UIAlertController(title: "Sort Order", message: nil, preferredStyle: .actionSheet)
        
        let descAction = UIAlertAction(title: "Descending (↓)", style: .default) { _ in
            self.selectedSortOrder = "desc"
            self.sortOrderButton.setTitle("Order: ↓", for: .normal)
            self.performSearch()
        }
        
        let ascAction = UIAlertAction(title: "Ascending (↑)", style: .default) { _ in
            self.selectedSortOrder = "asc"
            self.sortOrderButton.setTitle("Order: ↑", for: .normal)
            self.performSearch()
        }
        
        alert.addAction(descAction)
        alert.addAction(ascAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        // For iPad
        if let popover = alert.popoverPresentationController {
            popover.sourceView = sortOrderButton
            popover.sourceRect = sortOrderButton.bounds
        }
        
        present(alert, animated: true)
    }
}

