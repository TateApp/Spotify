import Foundation

struct ArtistRelatedArtistResponse : Codable {
    
    let artists : [ArtistRelatedArtist]
}
struct ArtistRelatedArtist: Codable {
    
    let name : String
    let id : String
    let images : [APIImage]
    let uri : String
    
    
}
