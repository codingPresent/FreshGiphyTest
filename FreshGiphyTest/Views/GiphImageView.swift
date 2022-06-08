//
//  GiphImageView.swift
//  FreshGiphyTest
//
//  Created by Naveen Kumawat on 08/06/22.
//

import SwiftUI

struct GiphImageView: View {
//    gif.images.original.url
    var gif: InfoDict?
    var gifData: GiphData?
    @State var image = "heart"
    @State var fav = false
    @EnvironmentObject var favViewModel: FavViewModel
    var body: some View {
        ZStack(alignment: .topTrailing){
            if let gifInfo = gif{
                GiphImageViewRepresentable(url: gifInfo.images.original.url, data: nil)
            }else{
                GiphImageViewRepresentable(url: nil, data: gifData?.data)
            }
            Button {
                fav.toggle()
                print("Deleting \(fav)")
                if fav{
                    image = "heart.fill"
                    if let gifInfo = gif{
                        favViewModel.saveGif(with: gifInfo.id, url: gifInfo.images.original.url)
                    }
                }else{
                    
                    image = "heart"
                    if let gifData = gifData{
                        print("Deleting \(gifData.id!)")
                        favViewModel.removeGif(of: gifData.id!)
                    }
                }
            } label: {
                Image(systemName: image)
            }
            .padding(20)
        }.onAppear(){
            if let gifInfo = gif{
                if favViewModel.flagFav(with: gifInfo.id){
                    image = "heart.fill"
                    fav = true
                }
            }
        }
    }
}



