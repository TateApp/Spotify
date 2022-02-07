import Foundation

struct CategoryPlaylistResponse: Codable {
    
    let playlists : CategoryPlaylist
}
struct CategoryPlaylist: Codable {
    let href: String
    let items: [CategoryPlaylistItems]
}
struct CategoryPlaylistItems: Codable {
    let description: String
    let href: String
    let id : String
    let images : [APIImage]
    let name: String
   
}
