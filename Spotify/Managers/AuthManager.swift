import Foundation


final class AuthManager {
    static let shared = AuthManager()
    
    private init() {
        
    }
    struct Constants {
        static let clientID = "221b702aebea423e8c603f87f0959eed"
        static let clientSecret = "e9833309f06b4c158bf2682209063e6b"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
static let scope = "ugc-image-upload%20user-read-playback-state%20user-modify-playback-state%20user-read-currently-playing%20user-read-private%20user-read-email%20user-follow-modify%20user-follow-read%20user-library-modify%20user-library-read%20streaming%20app-remote-control%20user-read-playback-position%20user-top-read%20user-read-recently-played%20playlist-modify-private%20playlist-read-collaborative%20playlist-read-private%20playlist-modify-public"
        static let redirectURI = "https://developerdocsuk.wordpress.com"
    }
    
    var isSignedIn : Bool {
        
        return accessToken != nil
    }
    public var signInURL : URL? {
       

        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scope)&redirect_uri=\(Constants.redirectURI)&show_dialog=TRUE"
        
        return URL(string: string)
    }
    private var accessToken: String? {
        
        return UserDefaults.standard.string(forKey: "access_token")
    }
    private var refreshToken : String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    private var tokenExpirationDate : Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    private var shouldRefreshToken : Bool {
    let expirationDate = tokenExpirationDate 
        let currentDate = Date()
        
        return currentDate.addingTimeInterval(300) >= expirationDate!
    }
    public func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void) ) {
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
        }
        var component = URLComponents()
        component.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: "https://developerdocsuk.wordpress.com"),
          
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody =  component.query?.data(using: .utf8)
     
        let basicToken = Constants.clientID + ":" + Constants.clientSecret
        
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            completion(false)
            print("Failure to grt base64")
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        let task =  URLSession.shared.dataTask(with: request, completionHandler: { data, _ , error in
           guard let data = data, error == nil else {
               completion(false)
               return
           }
           do {
               let result  = try JSONDecoder().decode(AuthResponse.self, from: data)
               self.cacheToken(result: result)
//               print("Success \(json)")
               completion(true)
              
           } catch {
               print(error.localizedDescription)
           }
          
           
        })
        task.resume()
    }
    private var onRefreshBlocks = [((String) -> Void)]()
    //Supplies valid token to be used with APi Calls
    public func withValidToken(completion: @escaping(String) -> Void) {
        guard !refreshingToken else {
        // Append the completion
            onRefreshBlocks.append(completion)
            return
        }
        
        if shouldRefreshToken {
            //Refresh
            refreshAccessToken(completion: { [weak self] success in
                if let token = self?.accessToken, success {
                    completion(token)
                }
            })
        } else if let token = accessToken {
            completion(token)
        }
    }
    private var refreshingToken = false
    public func refreshAccessToken(completion: @escaping (Bool) -> Void) {
        guard !refreshingToken else {
            return
        }
        guard shouldRefreshToken else {
            completion(true)
            return
        }
        guard let refreshToken = self.refreshToken else {
            return
        }
        //Refresh the token
        guard let url = URL(string: Constants.tokenAPIURL) else {
            return
        }
        refreshingToken = true
        
        var component = URLComponents()
        component.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
      
            URLQueryItem(name: "refresh_token", value: refreshToken),
          
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody =  component.query?.data(using: .utf8)
     
        let basicToken = Constants.clientID + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            completion(false)
            print("Failure to grt base64")
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        let task =  URLSession.shared.dataTask(with: request, completionHandler: { data, _ , error in
            self.refreshingToken = false
            
           guard let data = data, error == nil else {
               completion(false)
               return
           }
           do {
               let result  = try JSONDecoder().decode(AuthResponse.self, from: data)
               self.onRefreshBlocks.forEach({$0(result.access_token)})
               print("Successfully Refreshed")
               self.cacheToken(result: result)
//               print("Success \(json)")
               completion(true)
              
           } catch {
               print(error.localizedDescription)
           }
          
           
        })
        task.resume()
    }
    private func cacheToken(result : AuthResponse) {
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        if let refresh_token = result.refresh_token {
            UserDefaults.standard.setValue(refresh_token, forKey: "refresh_token")
        }
      
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
        
    }
    
    public func signOut(completion:  @escaping (Bool) -> Void) {
        
        
        
        UserDefaults.standard.setValue(nil, forKey: "access_token")
        UserDefaults.standard.setValue(nil, forKey: "refresh_token")
        UserDefaults.standard.setValue(nil, forKey: "expirationDate")
        completion(true)

    }
}
