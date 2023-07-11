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
    
    static func fetchVideos() -> [Video] {
        let v1 = Video(name: "Tan", videoFileName: "v1", image: "tan")
        let v2 = Video(name: "Kun", videoFileName: "v2", image: "kun")
        let v3 = Video(name: "Tan", videoFileName: "v1", image: "tan")
        let v4 = Video(name: "Kun", videoFileName: "v2", image: "kun")
        let v5 = Video(name: "Kun", videoFileName: "v2", image: "kun")
        let v6 = Video(name: "Kun", videoFileName: "v2", image: "kun")
        let v7 = Video(name: "Kun", videoFileName: "v2", image: "kun")
        let v8 = Video(name: "Kun", videoFileName: "v2", image: "kun")
        let v9 = Video(name: "Kun", videoFileName: "v2", image: "kun")
        let v10 = Video(name: "Kun", videoFileName: "v2", image: "kun")
        let v11 = Video(name: "Kun", videoFileName: "v2", image: "kun")
        let videoArr: [Video] = [v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11]
        
        return videoArr
    }
}
