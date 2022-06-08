//
//  TrendingView.swift
//  FreshGiphyTest
//
//  Created by Naveen Kumawat on 07/06/22.
//

import SwiftUI

struct TrendingView: View {
    @EnvironmentObject var trendingViewModel: TrendingViewModel
    @EnvironmentObject var favViewModel: FavViewModel
    
    var body: some View {
        let searchTextBinding = Binding<String>(get: {
            self.trendingViewModel.searchQuery
        }, set: {
            self.trendingViewModel.searchQuery = $0
        })
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(spacing: 15) {
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search for GIFs", text: searchTextBinding)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
            }
            .padding()
            
            if let gifs = trendingViewModel.fetchedSerchedGIFs {
                if gifs.isEmpty {
                    Text("No GIFs Found")
                        .padding(.top, 20)
                } else {
                    ForEach(gifs) { gif in
                        GiphImageView(gif: gif)
                            .frame(width: 400, height: 350, alignment: .center)
                            .background(Color("Moonlight"))
                            .environmentObject(favViewModel)
                        
                    }
                }
            } else {
                if trendingViewModel.searchQueryExecited {
                    ProgressView()
                        .padding(.top, 20)
                }else{
                    if trendingViewModel.fetchedTrendingGIFs.isEmpty {
                        ProgressView()
                            .padding(.top, 30)
                    } else {
                        VStack(spacing: 15) {
                            ForEach(trendingViewModel.fetchedTrendingGIFs) { gif in
                                GiphImageView(gif: gif)
                                    .frame(width: 400, height: 350, alignment: .center)
                                    .background(Color("Moonlight"))
                                    .cornerRadius(10)
                                    .environmentObject(favViewModel)
                            }
                            
                            if trendingViewModel.offset == trendingViewModel.fetchedTrendingGIFs.count {
                                ProgressView()
                                    .padding(.vertical)
                                    .onAppear(perform: {
                                        print("fetch new gifs...\(trendingViewModel.fetchedTrendingGIFs.count)")
                                        trendingViewModel.fetchTrendingGIFs()
                                    })
                            } else {
                                GeometryReader { geometry -> Color in
                                    let minY = geometry.frame(in: .global).minY
                                    
                                    let height = UIScreen.main.bounds.height / 1.3
                                    
                                    if !trendingViewModel.fetchedTrendingGIFs.isEmpty && minY < height {
                                        DispatchQueue.main.async {
                                            trendingViewModel.offset = trendingViewModel.fetchedTrendingGIFs.count
                                        }
                                    }
                                    return Color.clear
                                }
                                .frame(width: 20, height: 20)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
        })
    }
}

struct TrendingView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingView()
    }
}
