// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubAPI.Objects {
  /// Audit log entry for a org.oauth_app_access_denied event.
  static let OrgOauthAppAccessDeniedAuditEntry = ApolloAPI.Object(
    typename: "OrgOauthAppAccessDeniedAuditEntry",
    implementedInterfaces: [
      GitHubAPI.Interfaces.AuditEntry.self,
      GitHubAPI.Interfaces.Node.self,
      GitHubAPI.Interfaces.OauthApplicationAuditEntryData.self,
      GitHubAPI.Interfaces.OrganizationAuditEntryData.self
    ],
    keyFields: nil
  )
}