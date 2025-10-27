// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubAPI.Objects {
  /// Audit log entry for a repository_visibility_change.enable event.
  static let RepositoryVisibilityChangeEnableAuditEntry = ApolloAPI.Object(
    typename: "RepositoryVisibilityChangeEnableAuditEntry",
    implementedInterfaces: [
      GitHubAPI.Interfaces.AuditEntry.self,
      GitHubAPI.Interfaces.EnterpriseAuditEntryData.self,
      GitHubAPI.Interfaces.Node.self,
      GitHubAPI.Interfaces.OrganizationAuditEntryData.self
    ],
    keyFields: nil
  )
}