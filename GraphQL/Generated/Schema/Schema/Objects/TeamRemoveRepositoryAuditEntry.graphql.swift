// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubAPI.Objects {
  /// Audit log entry for a team.remove_repository event.
  static let TeamRemoveRepositoryAuditEntry = ApolloAPI.Object(
    typename: "TeamRemoveRepositoryAuditEntry",
    implementedInterfaces: [
      GitHubAPI.Interfaces.AuditEntry.self,
      GitHubAPI.Interfaces.Node.self,
      GitHubAPI.Interfaces.OrganizationAuditEntryData.self,
      GitHubAPI.Interfaces.RepositoryAuditEntryData.self,
      GitHubAPI.Interfaces.TeamAuditEntryData.self
    ],
    keyFields: nil
  )
}