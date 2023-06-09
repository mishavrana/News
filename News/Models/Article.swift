//
//  Article.swift
//  News
//
//  Created by Misha Vrana on 08.06.2023.
//

import Foundation

struct Article: Codable, Equatable, Identifiable {
    
    var id: UUID {
        UUID()
    }
    
    let source: Source
    
    let title: String
    let url: String
    let publishedAt: String
    
    let author: String?
    let description: String?
    let urlToImage: String?
    
    var authorUnwraped: String {
        author ?? ""
    }
    
    var descriptionUnwraped: String {
        description ?? ""
    }
    
    var articleURL: URL? {
        URL(string: url)
    }
    
    var imageURL: URL? {
        guard let urlToImage = urlToImage else { return nil }
        return URL(string: urlToImage)
        
    }
    
}

struct Source: Codable, Equatable {
    let name: String
}
