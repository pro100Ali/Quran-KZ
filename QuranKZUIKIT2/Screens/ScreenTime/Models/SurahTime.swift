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
    let praytimes: Time
}

struct Time: Codable {
    let bamdat: String?
    let kun: String?
    let ishraq: String?
    let besin: String?
    let ekindi: String?
    let aqsham: String?
    let quptan: String?
}
