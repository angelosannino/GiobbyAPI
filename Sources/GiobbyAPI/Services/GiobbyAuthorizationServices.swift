import Foundation

enum networkError: Error {
    case badResponse
}

class GiobbyAuthorizationService: AuthorizationServiceProtocol {
    
    var jwtDecoder: JWTDecoderProtocol
    
    func getLoginDetails() async -> LoginDetails? {
        nil
    }
    
    func getAccessToken() async -> String {
        guard let url = URL(string: Constants.AccessDetails.URL.token) else { return "" }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        /*
        var components = URLComponents()
        
        var queryItems = [URLQueryItem]()
        
        for (key, value) in Constants.AccessDetails.tokenRequestBody {
            let queryItem = URLQueryItem(name: key, value: String(describing: value))
            queryItems.append(queryItem)
        }
        
        components.queryItems = queryItems
        
        let queryItemData = components.query?.data(using: .utf8)
        
        request.httpBody = queryItemData
        */
        request.setBody(from: Constants.AccessDetails.tokenRequestBody)

        let response = try? await URLSession.shared.getAPIResponse(from: request, expecting: GiobbyAPIAccessTokenResponse.self)
        let result = response.flatMap { $0.accessToken }
        return result.notNil
    }
    
    init(decoder: JWTDecoderProtocol = JWTDecoder()) {
        self.jwtDecoder = decoder
    }

}

struct LoginDetails {
    let prova: String? = nil
    func unwrapped() -> String {
        prova.notNil
    }
}

public extension URLRequest {
    mutating func setBody(from json: [String: String]) {
        self.httpBody = json
            .map { URLQueryItem(name: $0.key, value: $0.value) }
            .reduce(into: URLComponents()) {
                $0.queryItems?.append($1)
            }
            .query?.data(using: .utf8)
    }
}

public extension URLSession {
    func getAPIResponse<T: Decodable>(from request: URLRequest, expecting: T.Type) async throws -> T {
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(expecting, from: data)
        } catch {
            debugPrint(error.localizedDescription)
            throw error
        }
    }
}

public extension Swift.Optional where Wrapped == String {
    var notNil: String {
        self.map { return $0 }
        return Constants.CommonStrings.emptyString
    }
}
