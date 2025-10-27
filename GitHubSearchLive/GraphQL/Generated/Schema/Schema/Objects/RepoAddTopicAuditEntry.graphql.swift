// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubAPI.Objects {
  /// Audit log entry for a repo.add_topic event.
  static let RepoAddTopicAuditEntry = ApolloAPI.Object(
    typename: "RepoAddTopicAuditEntry",
    implementedInterfaces: [
      GitHubAPI.Interfaces.AuditEntry.self,
      GitHubAPI.Interfaces.Node.self,
      GitHubAPI.Interfaces.OrganizationAuditEntryData.self,
      GitHubAPI.Interfaces.RepositoryAuditEntryData.self,
      GitHubAPI.Interfaces.TopicAuditEntryData.self
    ],
    keyFields: nil
  )
}