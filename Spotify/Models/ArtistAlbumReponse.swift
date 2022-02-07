import UIKit

struct ArtistAlbumResponse: Codable {
    
    let href: String
    
    let items : [ArtistAlbumItems]
}
struct ArtistAlbumItems: Codable {
    let artists: [ArtistAlbumItemsArtists]
    let href: String
    let id: String
    let images: [APIImage]
    let  release_date: String
    let name : String
    let uri : String
}
struct ArtistAlbumItemsArtists: Codable {
    let id : String
    let name: String
    let uri: String
}
