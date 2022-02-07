import FileProvider

struct CategoriesReponses: Codable {
//    let href : String
    let categories: Categories
//    let limit : Int
    
}
struct Categories : Codable {

    let items : [CategoriesItem]

}
struct CategoriesItem : Codable {
    let href : String
    let icons : [APIImage]
    let id : String
    let name: String
}

