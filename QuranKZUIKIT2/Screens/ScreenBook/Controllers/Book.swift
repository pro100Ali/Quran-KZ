//
//  Book.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 02.08.2023.
//

import Foundation

class Book {
    let name: String
    let pages: String
    var url: URL
    var image: String
    
    init(name: String, pages: String, url: URL, image: String) {
        self.name = name
        self.pages = pages
        self.url = url
        self.image = image
    }
}
