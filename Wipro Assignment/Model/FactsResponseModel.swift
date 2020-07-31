//
//  FactsResponseModel.swift
//  Wipro Assignment
//
//  Created by SAMBIT DASH on 30/07/20.
//  Copyright © 2020 SAMBIT DASH. All rights reserved.
//

import Foundation

struct FactsResponseModel: Decodable {
    let title: String
    let facts: [FactModel]
    
    enum CodingKeys: String, CodingKey {
        case title, facts = "rows"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        facts = try container.decodeIfPresent([FactModel].self, forKey: .facts) ?? [FactModel]()
    }
}

struct FactModel: Decodable {
    let title: String
    let detail: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case title, detail = "description", image = "imageHref"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        detail = try container.decodeIfPresent(String.self, forKey: .detail) ?? ""
        image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
    }
}
