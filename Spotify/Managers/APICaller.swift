//
//  APICaller.swift
//  Spotify
//
//  Created by Tate Wrigley on 16/01/2022.
//

import Foundation
final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    enum APIError : Error {
        case failedToGetData
    }
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void ) {
        createRequest(with: URL(string: "\(Constants.baseAPIURL)" + "/me"), type: .GET, completion: { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest, completionHandler: { data, _ , error in
                guard let data = data , error == nil else  {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
//                    //print(result)
                    
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                    print("Failed getCurrentUserProfile")
                }
                
            })
            task.resume()
        })
       
    }
    public func getRecommendedGenres(completion: @escaping ((Result<RecommendedGenres , Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"), type: .GET, completion: { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecommendedGenres.self, from: data)
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
//                    //print(result)
                    completion(.success(result))
                } catch {
                    print("Failed getRecommendedGenres")
                }
            })
            task.resume()
        })
    }
    public func getTrackInfo(id: String, completion: @escaping ((Result<AudioTrack , Error>)) -> Void) {
       print(id)
        createRequest(with: URL(string: Constants.baseAPIURL + "/tracks/\(id)"), type: .GET, completion: { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
                    let result = try JSONDecoder().decode(AudioTrack.self, from: data)
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
                    //print(result)
                    completion(.success(result))
                } catch {
                    print("Failed getTrackInfo")
                }
                do {
//                    let result = try JSONDecoder().decode(AudioTrack.self, from: data)
                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
                    //print(result)
//                    completion(.success(result))
                } catch {
                    print("Failed getArtist")
                }
            })
            task.resume()
        })
    }
    public func getMyPlaylists(completion: @escaping ((Result<MyPlaylistResponse , Error>)) -> Void) {
       
        createRequest(with: URL(string: Constants.baseAPIURL + "/me/playlists"), type: .GET, completion: { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
                    let result = try JSONDecoder().decode(MyPlaylistResponse.self, from: data)
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
//                    //print(result)
                    completion(.success(result))
                } catch {
                    print("Failed getMyPlaylists")
                }
                do {
//                    let result = try JSONDecoder().decode(MyPlaylistResponse.self, from: data)
                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
//                    //print(result)
//                    completion(.success(result))
                } catch {
                    print("Failed getMyPlaylists")
                }
            })
            task.resume()
        })
    }
    public func getTopArtists(completion: @escaping ((Result<String , Error>)) -> Void) {
       
        createRequest(with: URL(string: Constants.baseAPIURL + "/me/top/artists"), type: .GET, completion: { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
//                    let result = try JSONDecoder().decode(GetArtistResponse.self, from: data)
                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
                    //print(result)
//                    completion(.success(result))
                } catch {
                    print("Failed getTopArtists")
                }
            })
            task.resume()
        })
    }
    public func getArtist(id: String,completion: @escaping ((Result<GetArtistResponse , Error>)) -> Void) {
       
        createRequest(with: URL(string: Constants.baseAPIURL + "/artists/\(id)"), type: .GET, completion: { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
                    let result = try JSONDecoder().decode(GetArtistResponse.self, from: data)
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
//                    //print(result)
                    completion(.success(result))
                } catch {
                    print("Failed getArtist")
                }
            })
            task.resume()
        })
    }
    public func getPlaylist(id: String,completion: @escaping ((Result<PlaylistPressedResponse , Error>)) -> Void) {
       
        createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/\(id)"), type: .GET, completion: { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
                    let result = try JSONDecoder().decode(PlaylistPressedResponse.self, from: data)
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
                    //print(result)
                    completion(.success(result))
                } catch {
                    print("Failed getPlaylist")
                }
            })
            task.resume()
        })
    }
    public func getCategoryPlaylists(id: String,completion: @escaping ((Result<CategoryPlaylistResponse , Error>)) -> Void) {
       
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/categories/\(id)/playlists"), type: .GET, completion: { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
                    let result = try JSONDecoder().decode(CategoryPlaylistResponse.self, from: data)
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
                    //print(result)
                    completion(.success(result))
                } catch {
                    print("Failed getCategoryPlaylists")
                }
                do {
//                    let result = try JSONDecoder().decode(String.self, from: data)
                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
//                    //print(result)
//                    completion(.success(result))
                } catch {
                    print("Failed getCategoryPlaylists")
                }
            })
            task.resume()
        })
    }
    
    public func getArtistTopTracks(id: String,completion: @escaping ((Result<ArtistTopTracksReponse , Error>)) -> Void) {
       
        createRequest(with: URL(string: Constants.baseAPIURL + "/artists/\(id)/top-tracks?market=US"), type: .GET, completion: { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
                    let result = try JSONDecoder().decode(ArtistTopTracksReponse.self, from: data)
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
                    //print(result)
                    completion(.success(result))
                } catch {
                    print("Failed getArtistAlbums")
                }
                do {
//                    let result = try JSONDecoder().decode(String.self, from: data)
                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
//                    //print(result)
//                    completion(.success(result))
                } catch {
                    print("Failed getArtistAlbums")
                }
            })
            task.resume()
        })
    }
    public func getArtistAlbums(id: String,completion: @escaping ((Result<ArtistAlbumResponse , Error>)) -> Void) {
       
        createRequest(with: URL(string: Constants.baseAPIURL + "/artists/\(id)/albums"), type: .GET, completion: { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
                    let result = try JSONDecoder().decode(ArtistAlbumResponse.self, from: data)
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
//                    //print(result)
                    completion(.success(result))
                } catch {
                    print("Failed getArtistAlbums")
                }
                do {
//                    let result = try JSONDecoder().decode(String.self, from: data)
                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
                    //print(result)
//                    completion(.success(result))
                } catch {
                    print("Failed getArtistAlbums")
                }
            })
            task.resume()
        })
    }
    public func getArtistRelatedArtists(id: String,completion: @escaping ((Result<ArtistRelatedArtistResponse , Error>)) -> Void) {
       
        createRequest(with: URL(string: Constants.baseAPIURL + "/artists/\(id)/related-artists"), type: .GET, completion: { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
                    let result = try JSONDecoder().decode(ArtistRelatedArtistResponse.self, from: data)
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
                    //print(result)
                    completion(.success(result))
                } catch {
                    print("Failed getArtistRelatedArtists")
                }
                do {
//                    let result = try JSONDecoder().decode(String.self, from: data)
                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
//                    //print(result)
//                    completion(.success(result))
                } catch {
                    print("Failed getArtistAlbums")
                }
            })
            task.resume()
        })
    }
    public func getAlbum(id: String,completion: @escaping ((Result<AlbumResponse_get , Error>)) -> Void) {
       
        createRequest(with: URL(string: Constants.baseAPIURL + "/albums/\(id)"), type: .GET, completion: { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
//                    let result = try JSONDecoder().decode(PlaylistPressedResponse.self, from: data)
                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
                    //print(result)
//                    completion(.success(result))
                } catch {
                    print("Failed getAlbum")
                }
                do {
                    let result = try JSONDecoder().decode(AlbumResponse_get.self, from: data)
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
                    //print(result)
                    completion(.success(result))
                } catch {
                    print("Failed getAlbum")
                }
            })
            task.resume()
        })
    }
    public func getCurrentPlayingTrack(completion: @escaping ((Result<GetCurrentlyPlayingResponse , Error>)) -> Void) {
       print(search)
        createRequest(with: URL(string: Constants.baseAPIURL + "/me/player/currently-playing"), type: .GET, completion: { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
                    let result = try JSONDecoder().decode(GetCurrentlyPlayingResponse.self, from: data)
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
//                    //print(result)
                    completion(.success(result))
                } catch {
                    print("Failed getCurrentPlayingTrack")
                    
                }
                do {
//                    let result = try JSONDecoder().decode(GetCurrentlyPlayingResponse.self, from: data)
                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
//                    //print(result)
//                    completion(.success(result))
                } catch {
                    print("Failed getCurrentPlayingTrack")
                    
                }
               
            })
            task.resume()
        })
    }
    public func search(search: String,completion: @escaping ((Result<[SearchResult] , Error>)) -> Void) {
       print(search)
        createRequest(with: URL(string: Constants.baseAPIURL + "/search?limit=10&type=album,artist,playlist,track&q=\(search)"), type: .GET, completion: { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
//                    let result = try JSONDecoder().decode(PlaylistPressedResponse.self, from: data)
                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
//                    //print(result)
//                    completion(.success(result))
                } catch {
                    print("Failed search")
                }
                do {
                    let result = try JSONDecoder().decode(SearchResponse.self, from: data)
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    var searchResults: [SearchResult] = []
                    searchResults.append(contentsOf: result.tracks.items.compactMap({.track(model: $0)}))
                    searchResults.append(contentsOf: result.albums.items.compactMap({.album(model: $0)}))
                    searchResults.append(contentsOf: result.artists.items.compactMap({.artist(model: $0)}))
                    searchResults.append(contentsOf: result.playlists.items.compactMap({.playlist(model: $0)}))
//                    //print(result)
                    completion(.success(searchResults))
                } catch {
                    print("Failed search")
                }
            })
            task.resume()
        })
    }
    public func getListOfCategories( completion: @escaping ((Result<Categories , Error>)) -> Void) {
       
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/categories?limit=50"), type: .GET, completion: { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
                    let result = try JSONDecoder().decode(CategoriesReponses.self, from: data)
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
//                    //print(result)
//                    print(result2)
                    completion(.success(result.categories))
                } catch {
                    print("Failed getListOfCategories")
                }
                do {
//                    let result2 = try JSONDecoder().decode(CategoriesReponses.self, from: data)
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
//                    //print(result)
//                    print(result2)
//                    completion(.success(result2))
                } catch {
                    print("Failed getListOfCategories")
                }
            })
            task.resume()
        })
    }
    public func getRecommendations(genres: Set<String>, completion: @escaping ((Result<ReccomendationsResponse , Error>)) -> Void) {
        let seeds  = genres.joined(separator: ",")
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations?limit=50&seed_genres=\(seeds)"), type: .GET, completion: { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
                    let result = try JSONDecoder().decode(ReccomendationsResponse.self, from: data)
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
//                    //print(result)
                    completion(.success(result))
                } catch {
                    print("Failed getRecommendations")
                }
            })
            task.resume()
        })
    }
    
    public func getParticularPlaylist(category: String,completion: @escaping ((Result<FeaturedPlaylistResponse , Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/categories/\(category)/playlists"), type: .GET, completion: { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
//                    print(data)
                    let result = try JSONDecoder().decode(FeaturedPlaylistResponse.self, from: data)
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
//                    //print(result)
                    completion(.success(result))
                } catch {
                    print("Failed getParticularPlaylist")
                }
            })
            task.resume()
        })
    }
    public func getFeaturedPlaylists(completion: @escaping ((Result<FeaturedPlaylistResponse , Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists"), type: .GET, completion: { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
//                    print(data)
                    let result = try JSONDecoder().decode(FeaturedPlaylistResponse.self, from: data)
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
//                    //print(result)
                    completion(.success(result))
                } catch {
                    print("Failed getFeaturedPlaylists")
                }
            })
            task.resume()
        })
    }
    public func getRecentlyPlayed(limit: Int,completion: @escaping ((Result<RecentlyPlayedResonse , Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me/player/recently-played?limit=\(limit)"), type: .GET, completion: { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
//                    print(data)
                    let result = try JSONDecoder().decode(RecentlyPlayedResonse.self, from: data)
//                    let result_2 = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
//                    //print(result)
//                    print(result_2)
                    completion(.success(result))
                } catch {
                
                    print("Failed getRecentlyPlayed")
                }
            })
            task.resume()
        })
    }
    public func getMyPlaylist(name: String,limit: Int,completion: @escaping ((Result<MyPlaylistResponse , Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/users/\(name)/playlists"), type: .GET, completion: { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
//                    print(data)
                    let result = try JSONDecoder().decode(MyPlaylistResponse.self, from: data)
//                    let result_2 = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    
//                    //print(result)
//                    print(result_2)
                    completion(.success(result))
                } catch {
                
                    print("Failed getMyPlaylist")
                }
            })
            task.resume()
        })
    }
    public func getNewReleases(completion: @escaping ((Result<NewReleaseResponse , Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=50"), type: .GET, completion: { request in
            let task = URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
                guard let data = data , error == nil else {
                    return
                }
                do {
                    let result = try JSONDecoder().decode(NewReleaseResponse.self, from: data)
                    
//                    //print(result)
                    completion(.success(result))
                } catch {
                    print("Failed getNewReleases")
                }
            })
            task.resume()
        })
    }
    
    enum HTTPMethod : String{
        case GET
        case POST
    }
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping(URLRequest) -> Void) {
        AuthManager.shared.withValidToken(completion: { token in
            guard let apiURL = url else {
                return
            }
            var  request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
    completion(request)
        })
    
    }
}
