//
//  NewSurah.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 15.07.2023.
//

import Foundation

struct SurahAyat: Codable {
    let verses: [SurahVerses]
}

struct SurahVerses: Codable {
    let id: Int?
    let verse_key: String?
    let words: [SurahText]?
    
}

struct SurahText: Codable {
    let text: String?
    let translation: Translation?
    let transliteration: Transliteration?
}

struct Translation: Codable {
    let text: String?
    let language_name: String?
}

struct Transliteration: Codable {
    let text: String?
    let language_name: String?
}
