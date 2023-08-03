//
//  VideoViewModel.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 03.08.2023.
//

import Foundation
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore

class VideoViewModel {
    
    var videoReference : StorageReference {
        return Storage.storage().reference()
    }
    
    func getVideo(videoName: String) {
        let fileName = videoName + ".pdf"
        let downloadRef = videoReference.child(fileName)
        downloadRef.downloadURL { url, error in
            guard let videoPath = url else { return }
            print(url)
            let downloadTask = downloadRef.getData(maxSize: (1024 * 1024 * 100)) { (data, error) in
                if let data = data {
//                    videoController.playVideo(path: videoPath) //videoController is just a variable I use to manage playing videos
                print(videoPath)
                    
                }
            }
            
          if let error = error {
            // Handle any errors

          } else {
            // Get the download URL for 'images/stars.jpg'
          }
        }
       
    }
}
