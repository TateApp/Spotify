import Foundation
//MARK: -
struct SearchResponse: Codable {
    let albums: SearchAlbumResponse
    let artists: SearchArtistResponse
    let playlists: SearchPlaylistResponse
    let tracks: SearchTrackResponse
}
struct SearchAlbumResponse: Codable {
    let href: String
    let items : [SearchAlbumItems]
}
struct SearchAlbumItems : Codable {
    let artists : [SearchAlbumArtist]
    let external_urls : [String : String]
    let href: String
    let id: String
    let images : [APIImage]
    let name : String
    let release_date : String
    let total_tracks : Int
    let uri : String
}

struct SearchAlbumArtist : Codable {
    let external_urls : [String : String]
    let href : String
    let name : String
    let type : StringLiteralType
    let uri : String
    
    
}
//MARK: -
struct SearchArtistResponse: Codable {
    let href : String
    let items: [SearchArtistItems]
}
struct SearchArtistItems: Codable {
    let external_urls : [String : String]
//    let followers : [String: Int]
//    let genres : [String : String]
    let id: String
    let href: String
    let name : String
    let popularity : Int
    let type : String
    let images: [APIImage]
    let uri : String
}
//MARK: -
struct SearchPlaylistResponse: Codable {
    let href: String
    let items : [SearchPlaylistItems]
    
}
struct SearchPlaylistItems : Codable {
    let description: String
    let collaborative : Bool
    let href: String
    let id: String
    let external_urls: [String : String]
    let images : [APIImage]
    let name : String
//    let owner : [String : String]
    let snapshot_id : String
 
}
//MARK: -
struct SearchTrackResponse: Codable {
    let href: String
    let items: [SearchTrackItems]
    
}
struct SearchTrackItems : Codable {
    let album: SearchTrackItemsAlbum
    let artists : [SearchTrackItemsArtists]
    let disc_number : Int
    let duration_ms : Int
    let explicit : Bool
    let external_urls : [String : String]
    let href: String
    let id : String
//    let is_local: Bool
    let name : String
    let popularity: Int
//    let preview_url: String
    let track_number: Int
    let uri: String
}
struct SearchTrackItemsAlbum : Codable {
    let artists: [SearchTrackItemsAlbumArtists]
    let href: String
    let id: String
    let images: [APIImage]
    let name : String
    let release_date: String
    let total_tracks: Int
    let uri : String
}
struct SearchTrackItemsAlbumArtists : Codable {
    let external_urls : [String : String]
    let href: String
    let id: String
    let name : String
    let uri: String
}
struct SearchTrackItemsArtists : Codable {
    let external_urls : [String : String]
    let href: String
    let id : String
    let name: String
    let uri: String
}
