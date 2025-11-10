import Foundation

/// Use this class to access the different functions within the SDK. You can instantiate any number of clients with different configuration that will propagate to these functions.
public final class ApiClient: Sendable {
    private let httpClient: HTTPClient

    /// Initialize the client with the specified configuration and a static bearer token.
    ///
    /// - Parameter baseURL: The base URL to use for requests from the client. If not provided, the default base URL will be used.
    /// - Parameter token: Bearer token for authentication. If provided, will be sent as "Bearer {token}" in Authorization header.
    /// - Parameter headers: Additional headers to send with each request.
    /// - Parameter timeout: Request timeout in seconds. Defaults to 60 seconds. Ignored if a custom `urlSession` is provided.
    /// - Parameter maxRetries: Maximum number of retries for failed requests. Defaults to 2.
    /// - Parameter urlSession: Custom `URLSession` to use for requests. If not provided, a default session will be created with the specified timeout.
    public convenience init(
        baseURL: String = ApiEnvironment.default.rawValue,
        token: String? = nil,
        headers: [String: String]? = nil,
        timeout: Int? = nil,
        maxRetries: Int? = nil,
        urlSession: Networking.URLSession? = nil
    ) {
        self.init(
            baseURL: baseURL,
            headerAuth: nil,
            bearerAuth: token.map {
                .init(token: .staticToken($0))
            },
            basicAuth: nil,
            headers: headers,
            timeout: timeout,
            maxRetries: maxRetries,
            urlSession: urlSession
        )
    }

    /// Initialize the client with the specified configuration and an async bearer token provider.
    ///
    /// - Parameter baseURL: The base URL to use for requests from the client. If not provided, the default base URL will be used.
    /// - Parameter token: An async function that returns the bearer token for authentication. If provided, will be sent as "Bearer {token}" in Authorization header.
    /// - Parameter headers: Additional headers to send with each request.
    /// - Parameter timeout: Request timeout in seconds. Defaults to 60 seconds. Ignored if a custom `urlSession` is provided.
    /// - Parameter maxRetries: Maximum number of retries for failed requests. Defaults to 2.
    /// - Parameter urlSession: Custom `URLSession` to use for requests. If not provided, a default session will be created with the specified timeout.
    public convenience init(
        baseURL: String = ApiEnvironment.default.rawValue,
        token: ClientConfig.CredentialProvider? = nil,
        headers: [String: String]? = nil,
        timeout: Int? = nil,
        maxRetries: Int? = nil,
        urlSession: Networking.URLSession? = nil
    ) {
        self.init(
            baseURL: baseURL,
            headerAuth: nil,
            bearerAuth: token.map {
                .init(token: .provider($0))
            },
            basicAuth: nil,
            headers: headers,
            timeout: timeout,
            maxRetries: maxRetries,
            urlSession: urlSession
        )
    }

    init(
        baseURL: String,
        headerAuth: ClientConfig.HeaderAuth? = nil,
        bearerAuth: ClientConfig.BearerAuth? = nil,
        basicAuth: ClientConfig.BasicAuth? = nil,
        headers: [String: String]? = nil,
        timeout: Int? = nil,
        maxRetries: Int? = nil,
        urlSession: Networking.URLSession? = nil
    ) {
        let config = ClientConfig(
            baseURL: baseURL,
            headerAuth: headerAuth,
            bearerAuth: bearerAuth,
            basicAuth: basicAuth,
            headers: headers,
            timeout: timeout,
            maxRetries: maxRetries,
            urlSession: urlSession
        )
        self.httpClient = HTTPClient(config: config)
    }

    /// Discover POIs near a location
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getPois(lat: Double, long: Double, page: Int? = nil, pageSize: Int? = nil, requestOptions: RequestOptions? = nil) async throws -> [GetPoisResponseItem] {
        return try await httpClient.performRequest(
            method: .get,
            path: "/pois",
            queryParams: [
                "lat": .double(lat), 
                "long": .double(long), 
                "page": page.map { .int($0) }, 
                "pageSize": pageSize.map { .int($0) }
            ],
            requestOptions: requestOptions,
            responseType: [GetPoisResponseItem].self
        )
    }

    /// Create a POI and like it as the current user
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func postPois(request: Requests.PostPoisRequest, requestOptions: RequestOptions? = nil) async throws -> PostPoisResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/pois",
            body: request,
            requestOptions: requestOptions,
            responseType: PostPoisResponse.self
        )
    }

    /// Fetch a POI and the friends who liked it
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getPoisId(id: String, requestOptions: RequestOptions? = nil) async throws -> GetPoisIdResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/pois/\(id)",
            requestOptions: requestOptions,
            responseType: GetPoisIdResponse.self
        )
    }

    /// Create a like for a POI
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func postLikes(request: Requests.PostLikesRequest, requestOptions: RequestOptions? = nil) async throws -> PostLikesResponse {
        return try await httpClient.performRequest(
            method: .post,
            path: "/likes",
            body: request,
            requestOptions: requestOptions,
            responseType: PostLikesResponse.self
        )
    }

    /// Fetch likes created by friends that are visible to the user
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getLikesFriends(userId: String, limit: Int? = nil, requestOptions: RequestOptions? = nil) async throws -> [GetLikesFriendsResponseItem] {
        return try await httpClient.performRequest(
            method: .get,
            path: "/likes/friends",
            queryParams: [
                "userId": .string(userId), 
                "limit": limit.map { .int($0) }
            ],
            requestOptions: requestOptions,
            responseType: [GetLikesFriendsResponseItem].self
        )
    }

    /// Fetch likes created by the current user
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getLikesMine(userId: String, limit: Int? = nil, requestOptions: RequestOptions? = nil) async throws -> [GetLikesMineResponseItem] {
        return try await httpClient.performRequest(
            method: .get,
            path: "/likes/mine",
            queryParams: [
                "userId": .string(userId), 
                "limit": limit.map { .int($0) }
            ],
            requestOptions: requestOptions,
            responseType: [GetLikesMineResponseItem].self
        )
    }

    /// Fetch visible friend likes aggregated per POI
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getLikesFriendsAggregate(userId: String, limit: Int? = nil, requestOptions: RequestOptions? = nil) async throws -> [GetLikesFriendsAggregateResponseItem] {
        return try await httpClient.performRequest(
            method: .get,
            path: "/likes/friends/aggregate",
            queryParams: [
                "userId": .string(userId), 
                "limit": limit.map { .int($0) }
            ],
            requestOptions: requestOptions,
            responseType: [GetLikesFriendsAggregateResponseItem].self
        )
    }

    /// Fetch the current user’s likes aggregated per POI
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getLikesMineAggregate(userId: String, limit: Int? = nil, requestOptions: RequestOptions? = nil) async throws -> [GetLikesMineAggregateResponseItem] {
        return try await httpClient.performRequest(
            method: .get,
            path: "/likes/mine/aggregate",
            queryParams: [
                "userId": .string(userId), 
                "limit": limit.map { .int($0) }
            ],
            requestOptions: requestOptions,
            responseType: [GetLikesMineAggregateResponseItem].self
        )
    }

    /// Fetch visible friend likes aggregated per POI sorted by proximity
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getLikesFriendsAggregateNearby(userId: String, lat: Double, lng: Double, limit: Int? = nil, requestOptions: RequestOptions? = nil) async throws -> [GetLikesFriendsAggregateNearbyResponseItem] {
        return try await httpClient.performRequest(
            method: .get,
            path: "/likes/friends/aggregate/nearby",
            queryParams: [
                "userId": .string(userId), 
                "lat": .double(lat), 
                "lng": .double(lng), 
                "limit": limit.map { .int($0) }
            ],
            requestOptions: requestOptions,
            responseType: [GetLikesFriendsAggregateNearbyResponseItem].self
        )
    }

    /// Fetch the current user’s aggregated likes ordered by proximity
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getLikesMineAggregateNearby(userId: String, lat: Double, lng: Double, limit: Int? = nil, requestOptions: RequestOptions? = nil) async throws -> [GetLikesMineAggregateNearbyResponseItem] {
        return try await httpClient.performRequest(
            method: .get,
            path: "/likes/mine/aggregate/nearby",
            queryParams: [
                "userId": .string(userId), 
                "lat": .double(lat), 
                "lng": .double(lng), 
                "limit": limit.map { .int($0) }
            ],
            requestOptions: requestOptions,
            responseType: [GetLikesMineAggregateNearbyResponseItem].self
        )
    }

    /// List approved friends
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getFriends(page: Int? = nil, pageSize: Int? = nil, requestOptions: RequestOptions? = nil) async throws -> GetFriendsResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/friends",
            queryParams: [
                "page": page.map { .int($0) }, 
                "pageSize": pageSize.map { .int($0) }
            ],
            requestOptions: requestOptions,
            responseType: GetFriendsResponse.self
        )
    }

    /// List pending friend requests
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getFriendsPending(requestOptions: RequestOptions? = nil) async throws -> GetFriendsPendingResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/friends/pending",
            requestOptions: requestOptions,
            responseType: GetFriendsPendingResponse.self
        )
    }

    /// Fetch a friend profile and their liked POIs
    ///
    /// - Parameter requestOptions: Additional options for configuring the request, such as custom headers or timeout settings.
    public func getFriendsId(id: String, lat: Double? = nil, long: Double? = nil, requestOptions: RequestOptions? = nil) async throws -> GetFriendsIdResponse {
        return try await httpClient.performRequest(
            method: .get,
            path: "/friends/\(id)",
            queryParams: [
                "lat": lat.map { .double($0) }, 
                "long": long.map { .double($0) }
            ],
            requestOptions: requestOptions,
            responseType: GetFriendsIdResponse.self
        )
    }
}