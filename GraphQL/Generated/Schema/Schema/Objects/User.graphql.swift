// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubAPI.Objects {
  /// A user is an individual's account on GitHub that owns repositories and can make new content.
  static let User = ApolloAPI.Object(
    typename: "User",
    implementedInterfaces: [
      GitHubAPI.Interfaces.Actor.self,
      GitHubAPI.Interfaces.Node.self,
      GitHubAPI.Interfaces.PackageOwner.self,
      GitHubAPI.Interfaces.ProfileOwner.self,
      GitHubAPI.Interfaces.ProjectOwner.self,
      GitHubAPI.Interfaces.ProjectV2Owner.self,
      GitHubAPI.Interfaces.ProjectV2Recent.self,
      GitHubAPI.Interfaces.RepositoryDiscussionAuthor.self,
      GitHubAPI.Interfaces.RepositoryDiscussionCommentAuthor.self,
      GitHubAPI.Interfaces.RepositoryOwner.self,
      GitHubAPI.Interfaces.Sponsorable.self,
      GitHubAPI.Interfaces.UniformResourceLocatable.self
    ],
    keyFields: nil
  )
}