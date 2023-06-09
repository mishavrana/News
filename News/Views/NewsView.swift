//
//  TopNewsView.swift
//  News
//
//  Created by Misha Vrana on 09.06.2023.
//

import SwiftUI

struct NewsView: View {
    @EnvironmentObject var weatherResponseAPIHandler: WeatherAPIResponseHandler
    
    @State private var sortPickerisPresented: Bool = false
    @State private var datePickerisPresented: Bool = false
    @State private var query: String = ""
    
    var body: some View {
        NavigationView {
            if weatherResponseAPIHandler.isLoading {
                ProgressView()
            } else {
                List {
                    ForEach(weatherResponseAPIHandler.articles) { article in
                        NavigationLink {
                            DetailedArticleView(article: article)
                        } label: {
                            ArticlePreview(article: article)
                        }
                    }
                }
                .searchable(text: $query)
                .navigationTitle(weatherResponseAPIHandler.query.isEmpty ? "News" : "\(weatherResponseAPIHandler.query)")
                .navigationBarItems(leading: reset, trailing: sortAndDate)
            }
            
        }
        .onSubmit(of: .search) {
            search()
        }
    }
    
    func search() {
        weatherResponseAPIHandler.search(query: query)
        query = ""
    }
    
    
    var sortAndDate: some View {
        HStack {
            Button("sort") {
                sortPickerisPresented = true
            }
            .popover(isPresented: self.$sortPickerisPresented) {
                SortPickerView(isPresented: self.$sortPickerisPresented, sortOption: weatherResponseAPIHandler.sortedBy)
            }
            
            if weatherResponseAPIHandler.isShowingSearchAndSort {
                Button {
                    datePickerisPresented = true
                } label: {
                    Image(systemName: "calendar")
                        .popover(isPresented: self.$datePickerisPresented) {
                            DatePickerView(isPresented: self.$datePickerisPresented)
                        }
                }
            }
        }
    }
    
    var reset: some View {
        Button {
            weatherResponseAPIHandler.reset()
        } label: {
            Image(systemName: "gobackward")
        }
    }
}

struct TopNewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
