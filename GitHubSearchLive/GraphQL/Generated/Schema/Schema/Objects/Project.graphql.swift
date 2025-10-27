// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubAPI.Objects {
  /// Projects manage issues, pull requests and notes within a project owner.
  static let Project = ApolloAPI.Object(
    typename: "Project",
    implementedInterfaces: [
      GitHubAPI.Interfaces.Closable.self,
      GitHubAPI.Interfaces.Node.self,
      GitHubAPI.Interfaces.Updatable.self
    ],
    keyFields: nil
  )
}