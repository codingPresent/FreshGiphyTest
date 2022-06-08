//
//  GifImage.swift
//  FreshGiphyTest
//
//  Created by Naveen Kumawat on 08/06/22.
//

import SwiftUI
import UIKit

struct GiphImageViewRepresentable: UIViewRepresentable {
    private let url: String?
    private let data: Data?
    
    init(url: String?, data: Data?) {
        self.url = url
        self.data = data
    }
    
    func makeUIView(context: Context) -> UIGiphymage {
        if let giphyUrl = url{
            return UIGiphymage(url: giphyUrl)
        }else{
            return UIGiphymage(data: data!)
        }
    }
    
    func updateUIView(_ uiView: UIGiphymage, context: Context) {
        if let url = url {
            uiView.updateGIF(giphURL: url)
        }else{
            uiView.updateGIF(giphData: data!)
        }
    }
}
