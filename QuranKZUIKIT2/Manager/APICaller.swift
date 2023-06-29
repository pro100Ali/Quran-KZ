//
//  APICaller.swift
//  StrongTeam
//
//  Created by Али  on 17.05.2023.
//

import Foundation


class APICaller {
    
    static let shared = APICaller()

    func getAllChapters(completion: @escaping (Result<[Surah], Error>) -> Void) {
        
        let urlString = "https://api.quran.com/api/v4/chapters?language=ru"
        
        let url = URL(string: urlString)
        
        let request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let articles = try decoder.decode(Welcome.self, from: data)
                    
//                    print(articles)
                    completion(.success(articles.chapters))
                    
                } catch let error {
                    print("Error was \(error)")
                    completion(.failure(error))
                }
            }
            
            if let error = error {
                print("ERRRRROOR \(error)")
            }
            
        }
        task.resume()
        
    }
    
    
    func getInfoChapters(with id: Int, completion: @escaping (Result<SurahInfo, Error>) -> Void) {
        
        let urlString = "http://api.quran.com/api/v3/chapters/\(id)/info"
        
        let url = URL(string: urlString)
        
        let request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let articles = try decoder.decode(SurahDict.self, from: data)
                    
//                    print(articles)
                    completion(.success(articles.chapter_info!))
                    
                } catch let error {
                    print("Error was \(error)")
                    completion(.failure(error))
                }
            }
            
            if let error = error {
                print("ERRRRROOR \(error)")
            }
            
        }
        task.resume()
        
    }
    
    
    func getTimePray(completion: @escaping (Result<[Time], Error>) -> Void) {
        
        let urlString = "https://namaz.muftyat.kz/kk/api/times/2023/50.3/57.166667"
        
        let url = URL(string: urlString)
        
        let request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let articles = try decoder.decode(SurahTime.self, from: data)
                    
//                    print(articles)
                    completion(.success(articles.result))
                    
                } catch let error {
                    print("Error was \(error)")
                    completion(.failure(error))
                }
            }
            
            if let error = error {
                print("ERRRRROOR \(error)")
            }
            
        }
        task.resume()
        
    }
}
