import Foundation

struct NewReleaseResponse: Codable {
    let albums: AlbumResponse
    
}
struct AlbumResponse: Codable {
    let items : [Album]
}


