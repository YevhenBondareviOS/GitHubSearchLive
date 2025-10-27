// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubAPI.Objects {
  /// A review object for a given pull request.
  static let PullRequestReview = ApolloAPI.Object(
    typename: "PullRequestReview",
    implementedInterfaces: [
      GitHubAPI.Interfaces.Comment.self,
      GitHubAPI.Interfaces.Deletable.self,
      GitHubAPI.Interfaces.Minimizable.self,
      GitHubAPI.Interfaces.Node.self,
      GitHubAPI.Interfaces.Reactable.self,
      GitHubAPI.Interfaces.RepositoryNode.self,
      GitHubAPI.Interfaces.Updatable.self,
      GitHubAPI.Interfaces.UpdatableComment.self
    ],
    keyFields: nil
  )
}