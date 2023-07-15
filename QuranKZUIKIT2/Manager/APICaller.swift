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
    
    
    func getInfoChapters(with pageId: Int, completion: @escaping (Result<[SurahVerses], Error>) -> Void) {
        
        let urlString = "https://api.quran.com/api/v4/verses/by_page/\(pageId)?language=ru&words=true&page=1&per_page=10"
        
        let url = URL(string: urlString)
        
        let request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let articles = try decoder.decode(SurahAyat.self, from: data)
                    
//                    print(articles)
                    completion(.success(articles.verses))
                    
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
    
    
    
    
    func getTimePray(completion: @escaping (Result<Time, Error>) -> Void) {
        
        let urlString = "https://namaztimes.kz/api/praytimes?id=8382&type=json"
        
        let url = URL(string: urlString)
        
        let request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let articles = try decoder.decode(SurahTime.self, from: data)
                    
//                    print(articles)
                    completion(.success(articles.praytimes))
                    
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
    
    
    func getAudioSurah(with id: Int, completion: @escaping (Result<Audio, Error>) -> Void) {
        
        let urlString = "https://api.quran.com/api/v4/chapter_recitations/2/\(id)"
        
        let url = URL(string: urlString)
        
        let request = URLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let articles = try decoder.decode(AudioAPI.self, from: data)
                    
//                    print(articles)
                    completion(.success(articles.audio_file))
                    
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
