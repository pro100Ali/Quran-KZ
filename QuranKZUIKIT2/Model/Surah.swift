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

struct SurahDict: Codable {
    let chapter_info: SurahInfo?
}

struct SurahInfo: Codable {
    let chapter_id: Int?
    let language_name: String?
    let short_text: String?
}


