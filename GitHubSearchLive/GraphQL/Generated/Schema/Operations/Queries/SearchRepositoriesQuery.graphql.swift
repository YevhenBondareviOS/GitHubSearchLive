// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

extension GitHubAPI {
  struct SearchRepositoriesQuery: GraphQLQuery {
    static let operationName: String = "SearchRepositories"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query SearchRepositories($query: String!, $first: Int = 200, $after: String) { search(query: $query, type: REPOSITORY, first: $first, after: $after) { __typename repositoryCount pageInfo { __typename endCursor hasNextPage } edges { __typename node { __typename ... on Repository { id name nameWithOwner owner { __typename login avatarUrl(size: 64) } description url homepageUrl isPrivate isFork stargazerCount forkCount watchers { __typename totalCount } issues { __typename totalCount } pullRequests { __typename totalCount } licenseInfo { __typename name spdxId } primaryLanguage { __typename name color } languages(first: 10) { __typename nodes { __typename name } } repositoryTopics(first: 10) { __typename nodes { __typename topic { __typename name } } } defaultBranchRef { __typename name target { __typename ... on Commit { history(first: 1) { __typename edges { __typename node { __typename committedDate } } } } } } createdAt updatedAt } } } } }"#
      ))

    public var query: String
    public var first: GraphQLNullable<Int32>
    public var after: GraphQLNullable<String>

    public init(
      query: String,
      first: GraphQLNullable<Int32> = 200,
      after: GraphQLNullable<String>
    ) {
      self.query = query
      self.first = first
      self.after = after
    }

    @_spi(Unsafe) public var __variables: Variables? { [
      "query": query,
      "first": first,
      "after": after
    ] }

    struct Data: GitHubAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("search", Search.self, arguments: [
          "query": .variable("query"),
          "type": "REPOSITORY",
          "first": .variable("first"),
          "after": .variable("after")
        ]),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        SearchRepositoriesQuery.Data.self
      ] }

      /// Perform a search across resources, returning a maximum of 1,000 results.
      var search: Search { __data["search"] }

      /// Search
      ///
      /// Parent Type: `SearchResultItemConnection`
      struct Search: GitHubAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Objects.SearchResultItemConnection }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("repositoryCount", Int.self),
          .field("pageInfo", PageInfo.self),
          .field("edges", [Edge?]?.self),
        ] }
        static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          SearchRepositoriesQuery.Data.Search.self
        ] }

        /// The total number of repositories that matched the search query. Regardless of
        /// the total number of matches, a maximum of 1,000 results will be available
        /// across all types.
        var repositoryCount: Int { __data["repositoryCount"] }
        /// Information to aid in pagination.
        var pageInfo: PageInfo { __data["pageInfo"] }
        /// A list of edges.
        var edges: [Edge?]? { __data["edges"] }

        /// Search.PageInfo
        ///
        /// Parent Type: `PageInfo`
        struct PageInfo: GitHubAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Objects.PageInfo }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("endCursor", String?.self),
            .field("hasNextPage", Bool.self),
          ] }
          static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
            SearchRepositoriesQuery.Data.Search.PageInfo.self
          ] }

          /// When paginating forwards, the cursor to continue.
          var endCursor: String? { __data["endCursor"] }
          /// When paginating forwards, are there more items?
          var hasNextPage: Bool { __data["hasNextPage"] }
        }

        /// Search.Edge
        ///
        /// Parent Type: `SearchResultItemEdge`
        struct Edge: GitHubAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Objects.SearchResultItemEdge }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("node", Node?.self),
          ] }
          static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
            SearchRepositoriesQuery.Data.Search.Edge.self
          ] }

          /// The item at the end of the edge.
          var node: Node? { __data["node"] }

          /// Search.Edge.Node
          ///
          /// Parent Type: `SearchResultItem`
          struct Node: GitHubAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Unions.SearchResultItem }
            static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .inlineFragment(AsRepository.self),
            ] }
            static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
              SearchRepositoriesQuery.Data.Search.Edge.Node.self
            ] }

            var asRepository: AsRepository? { _asInlineFragment() }

            /// Search.Edge.Node.AsRepository
            ///
            /// Parent Type: `Repository`
            struct AsRepository: GitHubAPI.InlineFragment {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              typealias RootEntityType = SearchRepositoriesQuery.Data.Search.Edge.Node
              static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Objects.Repository }
              static var __selections: [ApolloAPI.Selection] { [
                .field("id", GitHubAPI.ID.self),
                .field("name", String.self),
                .field("nameWithOwner", String.self),
                .field("owner", Owner.self),
                .field("description", String?.self),
                .field("url", GitHubAPI.URI.self),
                .field("homepageUrl", GitHubAPI.URI?.self),
                .field("isPrivate", Bool.self),
                .field("isFork", Bool.self),
                .field("stargazerCount", Int.self),
                .field("forkCount", Int.self),
                .field("watchers", Watchers.self),
                .field("issues", Issues.self),
                .field("pullRequests", PullRequests.self),
                .field("licenseInfo", LicenseInfo?.self),
                .field("primaryLanguage", PrimaryLanguage?.self),
                .field("languages", Languages?.self, arguments: ["first": 10]),
                .field("repositoryTopics", RepositoryTopics.self, arguments: ["first": 10]),
                .field("defaultBranchRef", DefaultBranchRef?.self),
                .field("createdAt", GitHubAPI.DateTime.self),
                .field("updatedAt", GitHubAPI.DateTime.self),
              ] }
              static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                SearchRepositoriesQuery.Data.Search.Edge.Node.self,
                SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository.self
              ] }

              /// The Node ID of the Repository object
              var id: GitHubAPI.ID { __data["id"] }
              /// The name of the repository.
              var name: String { __data["name"] }
              /// The repository's name with owner.
              var nameWithOwner: String { __data["nameWithOwner"] }
              /// The User owner of the repository.
              var owner: Owner { __data["owner"] }
              /// The description of the repository.
              var description: String? { __data["description"] }
              /// The HTTP URL for this repository
              var url: GitHubAPI.URI { __data["url"] }
              /// The repository's URL.
              var homepageUrl: GitHubAPI.URI? { __data["homepageUrl"] }
              /// Identifies if the repository is private or internal.
              var isPrivate: Bool { __data["isPrivate"] }
              /// Identifies if the repository is a fork.
              var isFork: Bool { __data["isFork"] }
              /// Returns a count of how many stargazers there are on this object
              var stargazerCount: Int { __data["stargazerCount"] }
              /// Returns how many forks there are of this repository in the whole network.
              var forkCount: Int { __data["forkCount"] }
              /// A list of users watching the repository.
              var watchers: Watchers { __data["watchers"] }
              /// A list of issues that have been opened in the repository.
              var issues: Issues { __data["issues"] }
              /// A list of pull requests that have been opened in the repository.
              var pullRequests: PullRequests { __data["pullRequests"] }
              /// The license associated with the repository
              var licenseInfo: LicenseInfo? { __data["licenseInfo"] }
              /// The primary language of the repository's code.
              var primaryLanguage: PrimaryLanguage? { __data["primaryLanguage"] }
              /// A list containing a breakdown of the language composition of the repository.
              var languages: Languages? { __data["languages"] }
              /// A list of applied repository-topic associations for this repository.
              var repositoryTopics: RepositoryTopics { __data["repositoryTopics"] }
              /// The Ref associated with the repository's default branch.
              var defaultBranchRef: DefaultBranchRef? { __data["defaultBranchRef"] }
              /// Identifies the date and time when the object was created.
              var createdAt: GitHubAPI.DateTime { __data["createdAt"] }
              /// Identifies the date and time when the object was last updated.
              var updatedAt: GitHubAPI.DateTime { __data["updatedAt"] }

              /// Search.Edge.Node.AsRepository.Owner
              ///
              /// Parent Type: `RepositoryOwner`
              struct Owner: GitHubAPI.SelectionSet {
                let __data: DataDict
                init(_dataDict: DataDict) { __data = _dataDict }

                static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Interfaces.RepositoryOwner }
                static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("login", String.self),
                  .field("avatarUrl", GitHubAPI.URI.self, arguments: ["size": 64]),
                ] }
                static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                  SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository.Owner.self
                ] }

                /// The username used to login.
                var login: String { __data["login"] }
                /// A URL pointing to the owner's public avatar.
                var avatarUrl: GitHubAPI.URI { __data["avatarUrl"] }
              }

              /// Search.Edge.Node.AsRepository.Watchers
              ///
              /// Parent Type: `UserConnection`
              struct Watchers: GitHubAPI.SelectionSet {
                let __data: DataDict
                init(_dataDict: DataDict) { __data = _dataDict }

                static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Objects.UserConnection }
                static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("totalCount", Int.self),
                ] }
                static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                  SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository.Watchers.self
                ] }

                /// Identifies the total count of items in the connection.
                var totalCount: Int { __data["totalCount"] }
              }

              /// Search.Edge.Node.AsRepository.Issues
              ///
              /// Parent Type: `IssueConnection`
              struct Issues: GitHubAPI.SelectionSet {
                let __data: DataDict
                init(_dataDict: DataDict) { __data = _dataDict }

                static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Objects.IssueConnection }
                static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("totalCount", Int.self),
                ] }
                static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                  SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository.Issues.self
                ] }

                /// Identifies the total count of items in the connection.
                var totalCount: Int { __data["totalCount"] }
              }

              /// Search.Edge.Node.AsRepository.PullRequests
              ///
              /// Parent Type: `PullRequestConnection`
              struct PullRequests: GitHubAPI.SelectionSet {
                let __data: DataDict
                init(_dataDict: DataDict) { __data = _dataDict }

                static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Objects.PullRequestConnection }
                static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("totalCount", Int.self),
                ] }
                static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                  SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository.PullRequests.self
                ] }

                /// Identifies the total count of items in the connection.
                var totalCount: Int { __data["totalCount"] }
              }

              /// Search.Edge.Node.AsRepository.LicenseInfo
              ///
              /// Parent Type: `License`
              struct LicenseInfo: GitHubAPI.SelectionSet {
                let __data: DataDict
                init(_dataDict: DataDict) { __data = _dataDict }

                static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Objects.License }
                static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("name", String.self),
                  .field("spdxId", String?.self),
                ] }
                static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                  SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository.LicenseInfo.self
                ] }

                /// The license full name specified by <https://spdx.org/licenses>
                var name: String { __data["name"] }
                /// Short identifier specified by <https://spdx.org/licenses>
                var spdxId: String? { __data["spdxId"] }
              }

              /// Search.Edge.Node.AsRepository.PrimaryLanguage
              ///
              /// Parent Type: `Language`
              struct PrimaryLanguage: GitHubAPI.SelectionSet {
                let __data: DataDict
                init(_dataDict: DataDict) { __data = _dataDict }

                static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Objects.Language }
                static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("name", String.self),
                  .field("color", String?.self),
                ] }
                static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                  SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository.PrimaryLanguage.self
                ] }

                /// The name of the current language.
                var name: String { __data["name"] }
                /// The color defined for the current language.
                var color: String? { __data["color"] }
              }

              /// Search.Edge.Node.AsRepository.Languages
              ///
              /// Parent Type: `LanguageConnection`
              struct Languages: GitHubAPI.SelectionSet {
                let __data: DataDict
                init(_dataDict: DataDict) { __data = _dataDict }

                static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Objects.LanguageConnection }
                static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("nodes", [Node?]?.self),
                ] }
                static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                  SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository.Languages.self
                ] }

                /// A list of nodes.
                var nodes: [Node?]? { __data["nodes"] }

                /// Search.Edge.Node.AsRepository.Languages.Node
                ///
                /// Parent Type: `Language`
                struct Node: GitHubAPI.SelectionSet {
                  let __data: DataDict
                  init(_dataDict: DataDict) { __data = _dataDict }

                  static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Objects.Language }
                  static var __selections: [ApolloAPI.Selection] { [
                    .field("__typename", String.self),
                    .field("name", String.self),
                  ] }
                  static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                    SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository.Languages.Node.self
                  ] }

                  /// The name of the current language.
                  var name: String { __data["name"] }
                }
              }

              /// Search.Edge.Node.AsRepository.RepositoryTopics
              ///
              /// Parent Type: `RepositoryTopicConnection`
              struct RepositoryTopics: GitHubAPI.SelectionSet {
                let __data: DataDict
                init(_dataDict: DataDict) { __data = _dataDict }

                static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Objects.RepositoryTopicConnection }
                static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("nodes", [Node?]?.self),
                ] }
                static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                  SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository.RepositoryTopics.self
                ] }

                /// A list of nodes.
                var nodes: [Node?]? { __data["nodes"] }

                /// Search.Edge.Node.AsRepository.RepositoryTopics.Node
                ///
                /// Parent Type: `RepositoryTopic`
                struct Node: GitHubAPI.SelectionSet {
                  let __data: DataDict
                  init(_dataDict: DataDict) { __data = _dataDict }

                  static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Objects.RepositoryTopic }
                  static var __selections: [ApolloAPI.Selection] { [
                    .field("__typename", String.self),
                    .field("topic", Topic.self),
                  ] }
                  static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                    SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository.RepositoryTopics.Node.self
                  ] }

                  /// The topic.
                  var topic: Topic { __data["topic"] }

                  /// Search.Edge.Node.AsRepository.RepositoryTopics.Node.Topic
                  ///
                  /// Parent Type: `Topic`
                  struct Topic: GitHubAPI.SelectionSet {
                    let __data: DataDict
                    init(_dataDict: DataDict) { __data = _dataDict }

                    static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Objects.Topic }
                    static var __selections: [ApolloAPI.Selection] { [
                      .field("__typename", String.self),
                      .field("name", String.self),
                    ] }
                    static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                      SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository.RepositoryTopics.Node.Topic.self
                    ] }

                    /// The topic's name.
                    var name: String { __data["name"] }
                  }
                }
              }

              /// Search.Edge.Node.AsRepository.DefaultBranchRef
              ///
              /// Parent Type: `Ref`
              struct DefaultBranchRef: GitHubAPI.SelectionSet {
                let __data: DataDict
                init(_dataDict: DataDict) { __data = _dataDict }

                static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Objects.Ref }
                static var __selections: [ApolloAPI.Selection] { [
                  .field("__typename", String.self),
                  .field("name", String.self),
                  .field("target", Target?.self),
                ] }
                static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                  SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository.DefaultBranchRef.self
                ] }

                /// The ref name.
                var name: String { __data["name"] }
                /// The object the ref points to. Returns null when object does not exist.
                var target: Target? { __data["target"] }

                /// Search.Edge.Node.AsRepository.DefaultBranchRef.Target
                ///
                /// Parent Type: `GitObject`
                struct Target: GitHubAPI.SelectionSet {
                  let __data: DataDict
                  init(_dataDict: DataDict) { __data = _dataDict }

                  static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Interfaces.GitObject }
                  static var __selections: [ApolloAPI.Selection] { [
                    .field("__typename", String.self),
                    .inlineFragment(AsCommit.self),
                  ] }
                  static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                    SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository.DefaultBranchRef.Target.self
                  ] }

                  var asCommit: AsCommit? { _asInlineFragment() }

                  /// Search.Edge.Node.AsRepository.DefaultBranchRef.Target.AsCommit
                  ///
                  /// Parent Type: `Commit`
                  struct AsCommit: GitHubAPI.InlineFragment {
                    let __data: DataDict
                    init(_dataDict: DataDict) { __data = _dataDict }

                    typealias RootEntityType = SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository.DefaultBranchRef.Target
                    static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Objects.Commit }
                    static var __selections: [ApolloAPI.Selection] { [
                      .field("history", History.self, arguments: ["first": 1]),
                    ] }
                    static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                      SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository.DefaultBranchRef.Target.self,
                      SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository.DefaultBranchRef.Target.AsCommit.self
                    ] }

                    /// The linear commit history starting from (and including) this commit, in the same order as `git log`.
                    var history: History { __data["history"] }

                    /// Search.Edge.Node.AsRepository.DefaultBranchRef.Target.AsCommit.History
                    ///
                    /// Parent Type: `CommitHistoryConnection`
                    struct History: GitHubAPI.SelectionSet {
                      let __data: DataDict
                      init(_dataDict: DataDict) { __data = _dataDict }

                      static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Objects.CommitHistoryConnection }
                      static var __selections: [ApolloAPI.Selection] { [
                        .field("__typename", String.self),
                        .field("edges", [Edge?]?.self),
                      ] }
                      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                        SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository.DefaultBranchRef.Target.AsCommit.History.self
                      ] }

                      /// A list of edges.
                      var edges: [Edge?]? { __data["edges"] }

                      /// Search.Edge.Node.AsRepository.DefaultBranchRef.Target.AsCommit.History.Edge
                      ///
                      /// Parent Type: `CommitEdge`
                      struct Edge: GitHubAPI.SelectionSet {
                        let __data: DataDict
                        init(_dataDict: DataDict) { __data = _dataDict }

                        static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Objects.CommitEdge }
                        static var __selections: [ApolloAPI.Selection] { [
                          .field("__typename", String.self),
                          .field("node", Node?.self),
                        ] }
                        static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                          SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository.DefaultBranchRef.Target.AsCommit.History.Edge.self
                        ] }

                        /// The item at the end of the edge.
                        var node: Node? { __data["node"] }

                        /// Search.Edge.Node.AsRepository.DefaultBranchRef.Target.AsCommit.History.Edge.Node
                        ///
                        /// Parent Type: `Commit`
                        struct Node: GitHubAPI.SelectionSet {
                          let __data: DataDict
                          init(_dataDict: DataDict) { __data = _dataDict }

                          static var __parentType: any ApolloAPI.ParentType { GitHubAPI.Objects.Commit }
                          static var __selections: [ApolloAPI.Selection] { [
                            .field("__typename", String.self),
                            .field("committedDate", GitHubAPI.DateTime.self),
                          ] }
                          static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                            SearchRepositoriesQuery.Data.Search.Edge.Node.AsRepository.DefaultBranchRef.Target.AsCommit.History.Edge.Node.self
                          ] }

                          /// The datetime when this commit was committed.
                          var committedDate: GitHubAPI.DateTime { __data["committedDate"] }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

}