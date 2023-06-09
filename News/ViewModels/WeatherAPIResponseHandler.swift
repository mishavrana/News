//
//  NewsAPIViewModel.swift
//  News
//
//  Created by Misha Vrana on 09.06.2023.
//

import Foundation
import Combine

class WeatherAPIResponseHandler: ObservableObject {
    
    @Published var isLoading: Bool = true
    
    var myPrivateAPIKey: String = ""
    var articles: [Article] = []
    var sortedBy: String = ""
    var query: String = ""
    var fromDate: String = ""
    var toDate: String = ""
    var cancellables = Set<AnyCancellable>()
    
    var isShowingSearchAndSort: Bool {
        return !query.isEmpty || !fromDate.isEmpty || !toDate.isEmpty
    }
    
    var stringQueryForTopNews: String {
        "https://newsapi.org/v2/top-headlines?" +
        "country=ua" +
        "&sortBy=\(sortedBy)" +
        "&apiKey=\(myPrivateAPIKey)"
    }
        
    var stringQueryForSearchAndSort: String {
        "https://newsapi.org/v2/everything?" +
        "q=\(query)" +
        "&sortBy=\(sortedBy)" +
        "&from=\(fromDate)" +
        "&to=\(toDate)" +
        "&apiKey=\(myPrivateAPIKey)"
    }
    
    var stringQuery: String {
        if isShowingSearchAndSort {
            return stringQueryForSearchAndSort
        } else {
            return stringQueryForTopNews
        }
    }
    
    init() { getArticles() }
    
    func getArticles() {
        
        articles = []
        isLoading = true
        
        guard let url = URL(
            string: stringQuery
        ) else { return }
        
        let cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .sink { [weak self](completion) in
                switch completion {
                case .finished:
                    print("finished")
                    self?.isLoading = false
                case .failure(let error):
                    print(String(describing: error))
                    self?.isLoading = false
                }
            } receiveValue: { [weak self] returnedResponse in
                    for article in returnedResponse.articles! {
                        self?.articles.append(article)
                    }
            }
        
        cancellable.store(in: &cancellables)
    }

    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
    func reset() {
        query = ""
        fromDate = ""
        toDate = ""
        
        getArticles()
    }
    
    func setDateBounds(fromDate: Date?, toDate: Date?) {
        
        if let from = fromDate, let to = toDate {
            self.fromDate = from.convertDate(stringFormat: "y-MM-dd")
            self.toDate = to.convertDate(stringFormat: "y-MM-dd")
        } else {
            self.fromDate = ""
            self.toDate = ""
        } 
    }
    
    func setSortOptions(_ option: String) {
        self.sortedBy = option
        getArticles()
    }
    
    func search(query: String) {
        self.query = query.trimmingCharacters(in: .whitespacesAndNewlines)
        getArticles()
    }
}

