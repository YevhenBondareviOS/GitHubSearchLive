// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubAPI.Objects {
  /// Audit log entry for a repo.config.unlock_anonymous_git_access event.
  static let RepoConfigUnlockAnonymousGitAccessAuditEntry = ApolloAPI.Object(
    typename: "RepoConfigUnlockAnonymousGitAccessAuditEntry",
    implementedInterfaces: [
      GitHubAPI.Interfaces.AuditEntry.self,
      GitHubAPI.Interfaces.Node.self,
      GitHubAPI.Interfaces.OrganizationAuditEntryData.self,
      GitHubAPI.Interfaces.RepositoryAuditEntryData.self
    ],
    keyFields: nil
  )
}