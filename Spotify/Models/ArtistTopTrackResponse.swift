import Foundation

struct ArtistTopTracksReponse : Codable {
    
    let tracks: [ArtistTopTracks]
    
}
struct ArtistTopTracks : Codable {
    
    let album: ArtistTopTracksAlbum
    let artists: [ArtistTopTracksArtists]
    let disc_number : Int
    let duration_ms : Int
    let href: String
    let id: String
    let name : String
    let popularity : Int
    let preview_url: String
    let uri : String
}
struct ArtistTopTracksAlbum : Codable {
    let href: String
    let images : [APIImage]
    let name: String
    let release_date : String
    let total_tracks: Int
    let uri: String
    
}
struct ArtistTopTracksArtists : Codable {
    let name : String
    let id: String
    
}
