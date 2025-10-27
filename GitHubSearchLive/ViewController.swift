//
//  ViewController.swift
//  GitHubSearchLive
//
//  Created by Evgenii Bondarev on 27.10.2025.
//

import UIKit
import Apollo

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Example: search Swift repos with lots of stars, first page
        let searchString = "language:swift stars:>1000 sort:stars-desc"

        let query = GitHubAPI.SearchRepositoriesQuery(query: searchString, first: 20, after: nil)
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
                return [
                  "id": repo.id,
                  "fullName": repo.nameWithOwner,
                  "description": repo.description ?? "",
                  "stars": repo.stargazerCount,
                  "forks": repo.forkCount,
                  "url": repo.url
                ] as [String : Any]
              } ?? []

              print("Repos:", repos)
              print("Has next page:", hasNext, "End cursor:", endCursor ?? "nil")
            }

            if let errors = graphQLResult.errors {
              print("GraphQL errors:", errors)
            }

          case .failure(let error):
            print("Network error:", error)
          }
        }
    }


}

