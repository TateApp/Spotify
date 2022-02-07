//
//  Artist.swift
//  Spotify
//
//  Created by Tate Wrigley on 16/01/2022.
//

import Foundation
struct Artist : Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String :String]
  
}
