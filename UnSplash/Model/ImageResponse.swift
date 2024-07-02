//
//  ImageResponse.swift
//  UnSplash
//
//  Created by Aswanth K on 02/07/24.
//

import Foundation

struct ImageResponse: Codable, Identifiable {
    let id: Int?
    let author: String?
    let width: Int?
    let height: Int?
    let url: String?
    let downloadURL: String?
    
    // Coding keys to map the JSON keys to the Swift property names
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case url
        case downloadURL = "download_url"
    }
    
    init(from decoder: Decoder) throws {
         let container = try decoder.container(keyedBy: CodingKeys.self)
         
         // Decode id as String and convert to Int
         let idString = try container.decode(String.self, forKey: .id)
         guard let idInt = Int(idString) else {
             throw DecodingError.dataCorruptedError(forKey: .id, in: container, debugDescription: "ID string could not be converted to Int")
         }
         self.id = idInt
         self.author = try container.decode(String.self, forKey: .author)
         self.width = try container.decode(Int.self, forKey: .width)
         self.height = try container.decode(Int.self, forKey: .height)
         self.url = try container.decode(String.self, forKey: .url)
         self.downloadURL = try container.decode(String.self, forKey: .downloadURL)
     }
}
