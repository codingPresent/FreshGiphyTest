//
//  GIF.swift
//  FreshGiphyTest
//
//  Created by Naveen Kumawat on 08/06/22.
//

struct GIF: Codable {
    var data: [InfoDict]?
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([InfoDict].self, forKey: .data)
    }
}

struct InfoDict: Identifiable, Codable {
    var id: String
    var images: OriginalGifData
}

struct OriginalGifData: Codable {
    var original: OriginalGif
}

struct OriginalGif: Codable {
    var url: String
}
