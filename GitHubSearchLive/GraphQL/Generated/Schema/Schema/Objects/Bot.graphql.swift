// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubAPI.Objects {
  /// A special type of user which takes actions on behalf of GitHub Apps.
  static let Bot = ApolloAPI.Object(
    typename: "Bot",
    implementedInterfaces: [
      GitHubAPI.Interfaces.Actor.self,
      GitHubAPI.Interfaces.Node.self,
      GitHubAPI.Interfaces.UniformResourceLocatable.self
    ],
    keyFields: nil
  )
}