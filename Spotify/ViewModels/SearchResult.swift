import Foundation

enum SearchResult {
    case artist(model: SearchArtistItems)
    case album(model: SearchAlbumItems)
    case track(model: SearchTrackItems)
    case playlist(model: SearchPlaylistItems)
}
