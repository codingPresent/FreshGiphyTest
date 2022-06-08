//
//  FavouriteView.swift
//  FreshGiphyTest
//
//  Created by Naveen Kumawat on 07/06/22.
//

import SwiftUI

struct FavouriteView: View {
    @FetchRequest(sortDescriptors: []) var gifs: FetchedResults<GiphData>
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(spacing: 15) {
                ForEach(gifs) { gif in
                    GiphImageView(gifData: gif, image: "heart.fill", fav: true)
                        .frame(width: 400, height: 350, alignment: .center)
                        .background(Color("Moonlight"))
                        .cornerRadius(10)
                }
            }
        })
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
