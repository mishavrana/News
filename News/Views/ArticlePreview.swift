//
//  ArticlePreview.swift
//  News
//
//  Created by Misha Vrana on 09.06.2023.
//

import SwiftUI

struct ArticlePreview: View {
    let article: Article
    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title)
                .font(.title3)
                .padding(.bottom)
            OptionalText(text: article.description)
                .font(.subheadline)
        }
        .frame(alignment: .leading)
    }
}

//struct ArticlePreview_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticlePreview()
//    }
//}
