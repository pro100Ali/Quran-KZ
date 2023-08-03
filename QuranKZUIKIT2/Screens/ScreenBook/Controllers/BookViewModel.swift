////
////  VideoViewModel.swift
////  QuranKZUIKIT2
////
////  Created by Али  on 03.08.2023.
////
//
//import Foundation
//import FirebaseStorage
//import WebKit
//
//
//class BookViewModel: NSObject {
//        
//    var books: [Book] = []
//
//    private(set) var empData : [Book]! {
//           didSet {
//               self.bindViewModelToController()
//           }
//       }
//    
//    var bindViewModelToController: () -> () = {}
//
//    
//    var reference : StorageReference {
//        return Storage.storage().reference()
//    }
//    
//    override init() {
//        super.init()
//    }
//    
//    
//    
//    func getAll(completion: @escaping (Result<[Book], Error>) -> Void) {
//        
//        let bookReference = reference.child("books")
//        
//  
//            
//            bookReference.listAll { (result, error) in
//                
//                for item in result!.items {
//                    
////                    self.books.append(Book(name: item.name, pages: "604", url: URL(string: "asdas")!))
//                }
//                do {
//                    self.empData = self.books
//                    completion(.success(self.empData))
//                    
//                } catch let error {
//                    print("Error was \(error)")
//                    completion(.failure(error))
//                }
//            }
//        
//    }
//    
//    func getBookUrl(books: [Book], index: Int, completion: @escaping (Result<Book, Error>) -> Void) {
//        
//        let bookReference = reference.child("books")
//        
//        bookReference.child(books[index].name).downloadURL { url, error in
//            
//            guard let videoPath = url else { return }
//            
//            books[index].url = videoPath
//            
//            completion(.success(books.first(where: { res in
//                res.url == url!
//            })!))
//            
//            if let error = error {
//                // Handle any errors
//                completion(.failure(error))
//            } else {
//                // Get the download URL for 'images/stars.jpg'
//            }
//
//        }
//        
//    }
//    
////    func getDescription(completion: @escaping (Result<[Book], Error>) -> Void) {
////        
////        let bookReference = reference.child("books")
////        var books: [Book] = []
////        
////        bookReference.downloadURL { url, error in
////            guard let videoPath = url else { return }
////            
////            
////            if let error = error {
////                // Handle any errors
////                
////            } else {
////                // Get the download URL for 'images/stars.jpg'
////            }
////            
////            
////            bookReference.listAll { (result, error) in
////                if let error = error {
////                    // ...
////                }
////                
////                for item in result!.items {
////                    // The items under storageReference.
////                    books.append(Book(name: item.name, pages: "604", url: url))
////                    print(item.name)
////                }
////                do {
////                    self.empData = books
////                    completion(.success(self.empData))
////                    
////                } catch let error {
////                    print("Error was \(error)")
////                    completion(.failure(error))
////                }
////            }
////        }
////    }
//    
//    
//    
////    func getBooks(bookName: String, completion: @escaping Result<URL, Error> ) {
////        let fileName = bookName + ".pdf"
////        let downloadRef = bookReference.child(fileName)
////        downloadRef.downloadURL { url, error in
////            guard let videoPath = url else { return }
////
////            webView.load(URLRequest(url: videoPath))
////
////          if let error = error {
////            // Handle any errors
////
////          } else {
////            // Get the download URL for 'images/stars.jpg'
////          }
////        }
////
////    }
//    
//    
//    
//    func downloadBook(bookName: String) {
//        // Create a reference to the file you want to download
//        let islandRef = reference.child("Ali.pdf")
//
//        islandRef.downloadURL { url, error in
//            guard let videoPath = url else { return }
//           
////            FileDownloader.loadFileAsync(url: videoPath) { (path, error) in
////                print("PDF File downloaded to : \(path!)")
////            }
//
//
//        }
//        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
//        
//    }
//    
//    
//}
//
//
////
////class FileDownloader {
////
////    static func loadFileSync(url: URL, completion: @escaping (String?, Error?) -> Void)
////    {
////        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
////
////        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
////
////        if FileManager().fileExists(atPath: destinationUrl.path)
////        {
////            print("File already exists [\(destinationUrl.path)]")
////            completion(destinationUrl.path, nil)
////        }
////        else if let dataFromURL = NSData(contentsOf: url)
////        {
////            if dataFromURL.write(to: destinationUrl, atomically: true)
////            {
////                print("file saved [\(destinationUrl.path)]")
////                completion(destinationUrl.path, nil)
////            }
////            else
////            {
////                print("error saving file")
////                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
////                completion(destinationUrl.path, error)
////            }
////        }
////        else
////        {
////            let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
////            completion(destinationUrl.path, error)
////        }
////    }
////
////    static func loadFileAsync(url: URL, completion: @escaping (String?, Error?) -> Void)
////    {
////        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
////
////        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
////
////        if FileManager().fileExists(atPath: destinationUrl.path)
////        {
////            print("File already exists [\(destinationUrl.path)]")
////            completion(destinationUrl.path, nil)
////        }
////        else
////        {
////            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
////            var request = URLRequest(url: url)
////            request.httpMethod = "GET"
////            let task = session.dataTask(with: request, completionHandler:
////            {
////                data, response, error in
////                if error == nil
////                {
////                    if let response = response as? HTTPURLResponse
////                    {
////                        if response.statusCode == 200
////                        {
////                            if let data = data
////                            {
////                                if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
////                                {
////                                    completion(destinationUrl.path, error)
////                                }
////                                else
////                                {
////                                    completion(destinationUrl.path, error)
////                                }
////                            }
////                            else
////                            {
////                                completion(destinationUrl.path, error)
////                            }
////                        }
////                    }
////                }
////                else
////                {
////                    completion(destinationUrl.path, error)
////                }
////            })
////            task.resume()
////        }
////    }
////}
