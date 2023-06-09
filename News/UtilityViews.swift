//
//  UtilityExtensions.swift
//  News
//
//  Created by Misha Vrana on 09.06.2023.
//

import Foundation
import SwiftUI

struct OptionalAsyncImage: View {
    let imageURL: String?
    var body: some View {
        
        if let imageurl = imageURL {
            if let url = URL(string: imageurl) {
                AsyncImage(url: url) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                    
            }
        }
    }
}

struct OptionalText: View {
    let text: String?
    var body: some View {
        if let text = text {
            Text(text)
        }
    }
}

struct TextFromStringISO8001Date: View {
    let date: String
    let format: String
    let formatter = DateFormatter()
    
    var body: some View {
        Text(self.convertDate(stringFormat: format))
    }
    
    func convertDate(stringFormat: String) -> String {
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = formatter.date(from: date)
        if let date = date {
            formatter.dateFormat = stringFormat
            let stringDate = formatter.string(from: date)
            return stringDate
        }
        return ""
    }
}

extension Date {
    func convertDate(stringFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        formatter.dateFormat = stringFormat
        let stringDate = formatter.string(from: self)
        return stringDate
    }
}


