//
//  Video.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 11.07.2023.
//

import Foundation

struct Audio: Codable {
    let id: Int?
    let chapter_id: Int?
    let audio_url: String?
}

struct AudioAPI: Codable {
    let audio_file: Audio
}
