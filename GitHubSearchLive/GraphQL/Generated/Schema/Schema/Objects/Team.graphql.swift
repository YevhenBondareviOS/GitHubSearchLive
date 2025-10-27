// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubAPI.Objects {
  /// A team of users in an organization.
  static let Team = ApolloAPI.Object(
    typename: "Team",
    implementedInterfaces: [
      GitHubAPI.Interfaces.MemberStatusable.self,
      GitHubAPI.Interfaces.Node.self,
      GitHubAPI.Interfaces.Subscribable.self
    ],
    keyFields: nil
  )
}