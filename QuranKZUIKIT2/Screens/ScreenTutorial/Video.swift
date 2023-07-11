//
//  Video.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 11.07.2023.
//

import Foundation

struct Video {
    
    let name: String
    let videoFileName: String
    let image: String
    let desc: String
    
    static func fetchVideos() -> [Video] {
        let v1 = Video(name: "Таң", videoFileName: "v1", image: "tan", desc: "Ерлерге арналған Ханафи мәзһабы бойынша таң (фәжр) намазының 2 ракәғат парызы.")
        let v2 = Video(name: "Бесін", videoFileName: "v2", image: "besin", desc: "Ерлерге арналған Ханафи мәзһабы бойынша бесін (зуһр) намазының 4 ракәғат парызы.")
        let v3 = Video(name: "Екінті", videoFileName: "v3", image: "ekinti", desc: "Ерлерге арналған Ханафи мәзһабы бойынша екінті ('аср) намазының 4 ракәғат парызы.")
        let v4 = Video(name: "Ақшам", videoFileName: "v4", image: "aksham", desc: "Ерлерге арналған Ханафи мәзһабы бойынша ақшам (мағриб) намазының 3 рәкағат парызы.")
        let v5 = Video(name: "Үтір уәжіп", videoFileName: "v5", image: "utir", desc: "Ерлерге арналған Ханафи мәзһабы бойынша үтір намазының 3 ракәғат уәжібі.")
        let v6 = Video(name: "Құптан", videoFileName: "v6", image: "kuptan", desc: "Ерлерге арналған Ханафи мәзһабы бойынша құптан ('иша) намазының 4 ракәғат парызы.")
        let videoArr: [Video] = [v1, v2, v3, v4, v5, v6]
        
        return videoArr
    }
}
