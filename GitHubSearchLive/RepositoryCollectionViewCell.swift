//
//  RepositoryCollectionViewCell.swift
//  GitHubSearchLive
//
//  Created by Evgenii Bondarev on 27.10.2025.
//

import UIKit

class RepositoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "RepositoryCollectionViewCell"
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let starsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemOrange
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray5.cgColor
        
        [fullNameLabel, starsLabel, descriptionLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            fullNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            fullNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: starsLabel.leadingAnchor, constant: -8),
            
            starsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            starsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            starsLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60),
            
            descriptionLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with repository: RepositoryItem) {
        fullNameLabel.text = repository.fullName
        starsLabel.text = "⭐ \(repository.stars)"
        descriptionLabel.text = repository.description.isEmpty ? "No description available" : repository.description
    }
}
