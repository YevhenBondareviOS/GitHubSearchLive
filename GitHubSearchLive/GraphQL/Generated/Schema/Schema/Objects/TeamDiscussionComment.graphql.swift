// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubAPI.Objects {
  /// A comment on a team discussion.
  static let TeamDiscussionComment = ApolloAPI.Object(
    typename: "TeamDiscussionComment",
    implementedInterfaces: [
      GitHubAPI.Interfaces.Comment.self,
      GitHubAPI.Interfaces.Deletable.self,
      GitHubAPI.Interfaces.Node.self,
      GitHubAPI.Interfaces.Reactable.self,
      GitHubAPI.Interfaces.UniformResourceLocatable.self,
      GitHubAPI.Interfaces.Updatable.self,
      GitHubAPI.Interfaces.UpdatableComment.self
    ],
    keyFields: nil
  )
}