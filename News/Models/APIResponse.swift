//
//  APIResponse.swift
//  News
//
//  Created by Misha Vrana on 09.06.2023.
//

import Foundation

struct APIResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]?
    
    let code: String?
    let message: String?
}
