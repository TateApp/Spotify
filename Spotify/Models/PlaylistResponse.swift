import Foundation


struct PlaylistPressedResponse: Codable {
    
    let collaborative : Bool
    let description : String
////    external_urls
////    followers
    let href : String
    let id: String
    let images : [APIImage]
    let name : String
////    let owner
    let tracks : PlaylistTracks
    let uri : String
}
struct PlaylistTracks: Codable {
    let href: String
    let items : [PlaylistItems]
}
struct PlaylistItems: Codable {
    let added_at: String
//    let  added_by: String
    let is_local: Bool
    let track: AudioTrack
//    let video_thumbnail : [String : String]
}
