//
//  Surah.swift
//  QuranKzUIKit
//
//  Created by Али  on 18.06.2023.
//

import Foundation

struct Welcome: Codable {
    let chapters: [Surah]
}

struct Surah: Codable {
    let id: Int?
    let name_simple: String?
    let pages: [Int]
    let name_arabic: String?
    
}



