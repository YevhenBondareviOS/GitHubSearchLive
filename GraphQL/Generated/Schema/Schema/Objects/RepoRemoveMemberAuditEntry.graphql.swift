// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubAPI.Objects {
  /// Audit log entry for a repo.remove_member event.
  static let RepoRemoveMemberAuditEntry = ApolloAPI.Object(
    typename: "RepoRemoveMemberAuditEntry",
    implementedInterfaces: [
      GitHubAPI.Interfaces.AuditEntry.self,
      GitHubAPI.Interfaces.Node.self,
      GitHubAPI.Interfaces.OrganizationAuditEntryData.self,
      GitHubAPI.Interfaces.RepositoryAuditEntryData.self
    ],
    keyFields: nil
  )
}