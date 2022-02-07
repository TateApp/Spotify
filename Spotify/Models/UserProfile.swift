import Foundation

struct UserProfile : Codable {
    let country: String
    let display_name : String
    let email: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
//    let followers: [String: Codable?]
    let id: String
    let product:  String
    let images: [APIImage]
}

//{
//    country = GB;
//    "display_name" = mrepicsheep;
//    email = "milocat101@hotmail.co.uk";
//    "explicit_content" =     {
//        "filter_enabled" = 0;
//        "filter_locked" = 0;
//    };
//    "external_urls" =     {
//        spotify = "https://open.spotify.com/user/mrepicsheep";
//    };
//    followers =     {
//        href = "<null>";
//        total = 1;
//    };
//    href = "https://api.spotify.com/v1/users/mrepicsheep";
//    id = mrepicsheep;
//    images =     (
//                {
//            height = "<null>";
//            url = "https://i.scdn.co/image/ab6775700000ee8564a83dff0f17b78b47a80c3b";
//            width = "<null>";
//        }
//    );
//    product = premium;
//    type = user;
//    uri = "spotify:user:mrepicsheep";
//}
