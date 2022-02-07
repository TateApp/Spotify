struct MyPlaylistResponse : Codable {
    
//    let href : String
    let items: [MyPlaylistItem]
//    let limit: Int
//    let next : String
}
struct MyPlaylistItem : Codable {
    
    let collaborative : Bool
    
    let description: String
    
//    let external_urls: [String: String]
    let href : String
    let id : String
    let images: [APIImage]
    let name: String
    let owner : MyPlaylistItemOwner
    let tracks: MyPlaylistTrack
}
struct MyPlaylistTrack : Codable {
    let href : String
   let  total : Int
}
struct MyPlaylistItemOwner: Codable {
    let display_name : String
    let id : String
    let uri  : String
}
//{
//    href = "https://api.spotify.com/v1/users/mrepicsheep/playlists?offset=0&limit=1";
//    items =     (
//                {
//            collaborative = 0;
//            description = "";
//            "external_urls" =             {
//                spotify = "https://open.spotify.com/playlist/2hlFOyiSCIPQyLqaRfckk6";
//            };
//            href = "https://api.spotify.com/v1/playlists/2hlFOyiSCIPQyLqaRfckk6";
//            id = 2hlFOyiSCIPQyLqaRfckk6;
//            images =             (
//                                {
//                    height = 640;
//                    url = "https://i.scdn.co/image/ab67616d0000b2737208629bd6aaa721319511e9";
//                    width = 640;
//                }
//            );
//            name = "Bugzy Malone \U2013 King Of The North";
//            owner =             {
//                "display_name" = mrepicsheep;
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/user/mrepicsheep";
//                };
//                href = "https://api.spotify.com/v1/users/mrepicsheep";
//                id = mrepicsheep;
//                type = user;
//                uri = "spotify:user:mrepicsheep";
//            };
//            "primary_color" = "<null>";
//            public = 1;
//            "snapshot_id" = Myw3MjA5N2Q3MGRkMjEzZTZiMzIxOTY3ZWY4ZDkzZTg1MTczYjgxM2I3;
//            tracks =             {
//                href = "https://api.spotify.com/v1/playlists/2hlFOyiSCIPQyLqaRfckk6/tracks";
//                total = 22;
//            };
//            type = playlist;
//            uri = "spotify:playlist:2hlFOyiSCIPQyLqaRfckk6";
//        }
//    );
//    limit = 1;
//    next = "https://api.spotify.com/v1/users/mrepicsheep/playlists?offset=1&limit=1";
//    offset = 0;
//    previous = "<null>";
//    total = 17;
//}
