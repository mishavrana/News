//
//  DetailedArticleView.swift
//  News
//
//  Created by Misha Vrana on 09.06.2023.
//

import SwiftUI

struct DetailedArticleView: View {
    
    let article: Article
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    
                    // Image
                    OptionalAsyncImage(imageURL: article.urlToImage)
                    
                    // Title
                    Text(article.title)
                        .font(.title)
                    
                    // Description
                    OptionalText(text: article.description)
                        .font(.subheadline.weight(.semibold))
                    
                    // Author, source, published
                    HStack {
                        OptionalText(text: article.author)
                        Text(article.source.name)
                        TextFromStringISO8001Date(date: article.publishedAt, format: "YY, MMM d, hh:mm")
                    }
                }
                .padding(.horizontal)
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct DetailedArticleView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailedArticleView()
//    }
//}
