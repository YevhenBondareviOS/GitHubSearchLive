//
//  Network.swift
//  GitHubSearchLive
//
//  Created by Evgenii Bondarev on 27.10.2025.
//


import Foundation
import Apollo

enum Network {
  static let shared = makeClient()

  private static func makeClient() -> ApolloClient {
    let url = URL(string: "https://api.github.com/graphql")!

    // 1) Cache / store
    let cache = InMemoryNormalizedCache()
    let store = ApolloStore(cache: cache)

    // 2) URLSession (conforms to ApolloURLSession in v2)
    let urlSession = URLSession(configuration: .default)

    // 3) Interceptors
    //    Use the shared DefaultInterceptorProvider instance
    let interceptorProvider = DefaultInterceptorProvider.shared

    // 4) Transport (v2 signature includes urlSession + store)
    let transport = RequestChainNetworkTransport(
      urlSession: urlSession,
      interceptorProvider: interceptorProvider,
      store: store,
      endpointURL: url,
      additionalHeaders: [
        "Authorization": "Bearer \(ProcessInfo.processInfo.environment["GITHUB_TOKEN"] ?? "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")"
      ]
    )

    // 5) Client
    return ApolloClient(networkTransport: transport, store: store)
  }
}
