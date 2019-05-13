//
//  ShowModel.swift
//  MagineTest
//
//  Created by Saoirse on 5/12/19.
//  Copyright © 2019 Gaia Inc. All rights reserved.
//

import Foundation

// MARK:- Search Result ListItem
struct ListItem: Decodable {
    let score: Double
    var show: Show
}

enum DownloadStatus {
    case todo
    case inProgress
    case done
    case error
}

// MARK:- Show -
struct Show: Decodable {
    let id: Int
    let name: String
    let type: String
    let language: String

    
    struct Image: Decodable {
        var medium: String?
        var original: String?
    }
    
    var image: Image?
    var imageData: Data? = nil
    var downloadStatus: DownloadStatus = .todo
    private enum CodingKeys: String, CodingKey {
        case id         = "id"
        case name       = "name"
        case type       = "type"
        case language   = "language"
        case image      = "image"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
        language = try container.decode(String.self, forKey: .language)
        image = try container.decodeIfPresent(Image.self, forKey: .image)
        imageData = nil
        downloadStatus = .todo
    }
}
