//
//  BookFireStore.swift
//  QuranKZUIKIT2
//
//  Created by Али  on 03.08.2023.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

class BookFireStore {
    
    let db = Firestore.firestore()
    var books: [Book] = []
    
    func getBook(completion: @escaping (Result<[Book], Error>) -> Void) -> [Book] {
        let bookRef = self.db.collection("books")
        
        bookRef.getDocuments { document, error in
            guard let documents = document?.documents else {
                print("No Documents")
                return
            }
            var fetchedBooks: [Book] = []
            
            for i in documents {
                
                let data = i.data()
                let name = data["name"] as? String ?? ""
                let pages = data["pages"] as? String ?? ""
                let url = data["url"] as? String ?? ""
                let image = data["image"] as? String ?? ""
                fetchedBooks.append(Book(name: name, pages: pages, url: (URL(string: url) ?? URL(string: "asdsa"))!, image: image))
                
            }
            self.books = fetchedBooks
            completion(.success(self.books))
            
            if let error = error {
                completion(.failure(error))
            }
        }
        return books

    }
}
