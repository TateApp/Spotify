import Foundation



struct AlbumResponse_get : Codable {
    let album_type: String
    let artists : [Artist]
    let href :String
    let id : String
    let images: [APIImage]
    let label : String
    let name : String
    let popularity : Int
    let  release_date: String
//    let totalTracks: Int
    let tracks: AlbumResponse_get_Tracks
//    let
    
}
struct AlbumResponse_get_Tracks: Codable {
let items : [AlbumResponse_get_Items]
}
struct AlbumResponse_get_Items: Codable {
    let artists : [Artist]
    let disc_number : Int
    let explicit : Bool
    let id : String
    let name : String
    let track_number : Int
    
//    let
}
