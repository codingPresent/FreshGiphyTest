//
//  UIGiphyImage.swift
//  FreshGiphyTest
//
//  Created by Naveen Kumawat on 08/06/22.
//

import UIKit

class UIGiphymage: UIView {
    private let imageView = UIImageView()
    private var url: String?
    private var data: Data?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(url: String) {
        self.init()
        self.url = url
        initView()
    }
    
    convenience init(data: Data) {
        self.init()
        self.data = data
        initView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        self.addSubview(imageView)
    }
    
    func updateGIF(giphURL: String) {
        imageView.image = UIImage.gifImageWithURL(giphURL)
    }
    
    func updateGIF(giphData: Data) {
        imageView.image = UIImage.gifImageWithData(giphData)
    }
    
    private func initView() {
        imageView.contentMode = .scaleAspectFill
    }
}
