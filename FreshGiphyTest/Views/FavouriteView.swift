//
//  FavouriteView.swift
//  FreshGiphyTest
//
//  Created by Naveen Kumawat on 07/06/22.
//

import SwiftUI

struct FavouriteView: View {
    @FetchRequest(sortDescriptors: []) var gifs: FetchedResults<GiphData>
    
    @State var divident: CGFloat = 3
    @State var selected: String = "Grid"
    var body: some View {
        
        GeometryReader { geometry in
            VStack{
                HStack{
                    Button{
                        divident = 3
                        selected = "Grid"
                    }label: {
                        Text("Grid")
                            .font(.title2)
                            .foregroundColor(selected == "Grid" ? .blue:.gray)
                    }.frame(width: geometry.size.width/2)
                    
                    Button{
                        divident = 2
                        selected = "List"
                    }label: {
                        Text("List")
                            .font(.title2)
                            .foregroundColor(selected != "Grid" ? .blue:.gray)
                    }.frame(width: geometry.size.width/2)
                }.frame(width: geometry.size.width)
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: geometry.size.width/divident))]) {
                        ForEach(gifs, id: \.id) { gif in
                            GiphImageView(gifData: gif, image: "heart.fill", fav: true)
                                .frame(height: 350, alignment: .center)
                                .background(Color("Moonlight"))
                                .cornerRadius(10)
                        }
                    }
                })
            }
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
