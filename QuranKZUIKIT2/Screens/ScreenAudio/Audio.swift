//
//  Video.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 11.07.2023.
//

import Foundation

struct Audio {
    
    let name: String
    let audioFileName: String
    let image: String
    let desc: String
    
    static func fetchAudio() -> [Audio] {
        let v1 = Audio(name: "Al fatiha", audioFileName: "a1", image: "compass", desc: "Ерлерге арналған Ханафи мәзһабы бойынша таң (фәжр) намазының 2 ракәғат парызы.")
        let v2 = Audio(name: "Al Ihlas", audioFileName: "a2", image: "compass", desc: "Ерлерге арналған Ханафи мәзһабы бойынша таң (фәжр) намазының 2 ракәғат парызы.")
       
        let videoArr: [Audio] = [v1, v2]
        
        return videoArr
    }
}
