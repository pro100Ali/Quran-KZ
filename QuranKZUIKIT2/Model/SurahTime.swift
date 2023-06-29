//
//  SurahTime.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 20.06.2023.
//

import Foundation

struct SurahTime: Codable {
    let longitude: Double?
    let city_name: String?
    let result: [Time]
}

struct Time: Codable {
    let Asr: String?
    let Isha: String?
    let Sunrise: String?
    let Maghrib: String?
    let date: String?
    let Dhuhr: String?
    let Fajr: String?
}
