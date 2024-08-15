import OpenAPIRuntime
import Foundation
import HTTPTypes

/// A client middleware that injects a value into the `Authorization` header field of the request.
package struct AuthenticationMiddleware {

    /// The value for the `Authorization` header field.
    private let value: String

    /// Creates a new middleware.
    /// - Parameter value: The value for the `Authorization` header field.
    package init(authorizationHeaderFieldValue value: String) { self.value = value }
}

extension AuthenticationMiddleware: ClientMiddleware {
    package func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        request.headerFields[.authorization] = value
        return try await next(request, body, baseURL)
    }
}

extension Client {
    public init(
        serverURL: Foundation.URL,
        authorizationHeader: String,
        configuration: Configuration = .init(),
        transport: any ClientTransport,
        middlewares: [any ClientMiddleware] = []
    ) {
        var clientMiddlewares = middlewares
        clientMiddlewares.append(
            AuthenticationMiddleware(
                authorizationHeaderFieldValue: authorizationHeader
            )
        )
        self.init(
            serverURL: serverURL,
            configuration: configuration,
            transport: transport,
            middlewares: clientMiddlewares
        )
    }
}
