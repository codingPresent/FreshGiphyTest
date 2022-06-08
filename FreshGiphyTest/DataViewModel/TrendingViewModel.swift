//
//  TrendingViewModel.swift
//  FreshGiphyTest
//
//  Created by Naveen Kumawat on 08/06/22.
//

import SwiftUI
import Combine

@MainActor class TrendingViewModel: ObservableObject {
    
    @Published var searchQuery = ""
    @Published var searchQueryExecited = false
    var searchCancellable: AnyCancellable? = nil

    @Published var fetchedTrendingGIFs: [InfoDict] = []
    @Published var fetchedSerchedGIFs: [InfoDict]? = nil

    @Published var offset: Int = 0
    
    private let limit = 5
    private let API_KEY = "Rpm9fIMaf8FoKjARMX2VCt8Nmw2r4TEZ"
    init() {
        print("8055: \(self.searchQuery)")
        self.searchCancellable = self.$searchQuery
            .removeDuplicates()
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { str in
                if str == "" {
                    print("Search query: fetchTrendingGIFs")
                    DispatchQueue.main.async {
                        self.searchQueryExecited = false
                        self.fetchedSerchedGIFs = nil
                    }
                    self.fetchTrendingGIFs()
                } else {
                    print("Search query: searchGIFs")
                    DispatchQueue.main.async {
                        self.searchQueryExecited = true
                        self.fetchedTrendingGIFs = []
                    }
                    self.searchGIFs()
                }
            })
    }
    
    func fetchTrendingGIFs() {
        let url = "https://api.giphy.com/v1/gifs/trending?api_key=\(API_KEY)&limit=\(limit)&rating=r&offset=\(offset)"

        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { data, _, err in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            guard let APIData = data else { return }
            do {
                let giphData = try JSONDecoder().decode(GIF.self, from: APIData)
//                print("giphData: \(giphData)")
                DispatchQueue.main.async {
                    self.fetchedTrendingGIFs.append(contentsOf: giphData.data ?? [])
                }
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
        }
        .resume()
    }

    func searchGIFs() {
        print("Search query: searchGIFs called - \(searchQuery)")
        self.fetchedSerchedGIFs?.removeAll()
        let originalQuery = searchQuery.replacingOccurrences(of: " ", with: "%20")
        let url = "https://api.giphy.com/v1/gifs/search?api_key=\(API_KEY)&q=\(originalQuery)&limit=\(limit+5)&offset=\(offset)&rating=r&lang=en"

        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!) { data, _, err in
            if let error = err {
                print("Search query: \(error.localizedDescription)")
                return
            }
            guard let APIData = data else {
                print("Search query: APIData nil")
                return
            }
            
            do {
                let gifsData = try JSONDecoder().decode(GIF.self, from: APIData)
                print("Search query gifsData: \(gifsData)")
                DispatchQueue.main.async {
                    if let giphData = gifsData.data{
                        if giphData.isEmpty{
                            self.fetchedSerchedGIFs = nil
                        }else{
                            self.fetchedSerchedGIFs = gifsData.data
                        }
                    }else{
                        self.fetchedSerchedGIFs = nil
                    }
                }
            } catch {
                print("Search query Catch: \(error.localizedDescription)")
            }
        }
        .resume()
    }
}

