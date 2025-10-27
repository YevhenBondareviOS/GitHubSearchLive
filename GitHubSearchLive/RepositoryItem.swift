//
//  RepositoryItem.swift
//  GitHubSearchLive
//
//  Created by Evgenii Bondarev on 27.10.2025.
//

import Foundation

struct RepositoryItem: Hashable {
    let id: String
    let fullName: String
    let description: String
    let stars: Int
    let forks: Int
    let url: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: RepositoryItem, rhs: RepositoryItem) -> Bool {
        return lhs.id == rhs.id
    }
}
