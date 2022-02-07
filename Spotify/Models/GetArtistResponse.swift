import UIKit

class GetArtistResponse : Codable {

    let name: String
    let popularity: Int
    let id: String
    let images : [APIImage]
}
