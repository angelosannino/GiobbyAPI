import Foundation

struct Constants {
    
    struct CommonStrings {
        static let emptyString = ""
    }
    
    struct AccessDetails {
        
        struct Keys {
            static let grantType = "grant_type"
            static let accessToken = "access_token"
            static let refreshToken = "refresh_token"
            static let clientId = "client_id"
            static let username = "username"
            static let cid = "cid"
            static let password = "password"
            static let idCompany = "idCompany"
            static let endPoint = "GiobbyApiURL"
        }
        
        struct Values {
            static let grantType = "password"
            static let clientId = "VIN20210630-api-vinco"
            static let username = "giobby"
            static let cid = "api-vinco"
            static let password = "testtest"
            static let refreshToken = "refresh_token"
        }
        
        struct URL {
            static let redirectUri = ""
            static let authBase = "https://auth.giobby.com/auth/realms/api-client/protocol/openid-connect/auth"
            static let authFull = "\(authBase)?client_id=\(Constants.AccessDetails.Values.clientId)&redirect_uri=\(redirectUri)&response_mode=fragment&response_type=code&scope=openid"
            static let token = "https://authqa.giobby.com/auth/realms/api-server/protocol/openid-connect/token"
            static let endPoint = "https://qa.giobby.com/GiobbyApiLogin/v1/endpoint?idCompany="
        }
        
        static var tokenRequestBody: [String: String] {
            [
                self.Keys.grantType : self.Values.grantType,
                self.Keys.clientId : self.Values.clientId,
                self.Keys.username : self.Values.username,
                self.Keys.cid : self.Values.cid,
                self.Keys.password : self.Values.password
            ]
        }
        
        static func headers(with token: String) -> [String: String] {
            [
                "Accept" : "application/json",
                "Authorization" : "Bearer \(token)",
                "X-Giobby-Realm" : "api-server"
            ]
        }
        
    }
    
    struct APICalls {
        
        struct GET {
            
            static let purchaseInvoices = "/purchases/invoices"
            static let saleInvoices = "/sales/invoices"
            
        }
        
    }
    
}
