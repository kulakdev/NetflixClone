//
//  APICaller.swift
//  NetflixClone
//
//  Created by Macbook Pro on 28.01.2024.
//

import Foundation

struct Constants {
    let API_KEY: String
    let GOOGLE_API_KEY: String
    static let baseURL = "https://api.themoviedb.org"
    
    init() {
        if let movies = Bundle.main.path(forResource: "api_key", ofType: "txt"),
           let youtube = Bundle.main.path(forResource: "google_api", ofType: "txt") {
            do {
                let api_key = try String(contentsOfFile: movies)
                let google_key = try String(contentsOfFile: youtube)
                self.API_KEY =  api_key
                self.GOOGLE_API_KEY = google_key
                print("successfully read \(api_key) api key")
                return
            } catch {
                print("Error reading contents of file")
                self.API_KEY = ""
                self.GOOGLE_API_KEY = ""
                return
            }
        }
        print("failed to open file")
        self.API_KEY = ""
        self.GOOGLE_API_KEY = ""
    }
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
//    var apikey = Constants().API_KEY
    let apikey = "0fc49102fee40af9f0688815d6557f6b"
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(apikey)") else { return }
        print("\(url) url")
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                //                print(results)
                
                let decodedRes = try decoder.decode(TrendingMoviesResponse.self, from: data)
                print(decodedRes)
                completion(.success(decodedRes.results))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getTrandingTvs(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(apikey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedRes = try decoder.decode(TrendingMoviesResponse.self, from: data)
                print(decodedRes)
                completion(.success(decodedRes.results))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void)  {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(apikey)&language=en&page=1") else { return }
        print("\(url) url")
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedRes = try decoder.decode(TrendingMoviesResponse.self, from: data)
                print(decodedRes)
                completion(.success(decodedRes.results))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void)  {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(apikey)&language=en&page=1") else { return }
        print("\(url) url")
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedRes = try decoder.decode(TrendingMoviesResponse.self, from: data)
                print(decodedRes)
                completion(.success(decodedRes.results))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Movie], Error>) -> Void)  {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(apikey)&language=en&page=1") else { return }
        print("\(url) url")
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedRes = try decoder.decode(TrendingMoviesResponse.self, from: data)
                print(decodedRes)
                completion(.success(decodedRes.results))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Movie], Error>) -> Void)  {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(apikey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else { return }
        print("\(url) url")
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedRes = try decoder.decode(TrendingMoviesResponse.self, from: data)
                print(decodedRes)
                completion(.success(decodedRes.results))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Movie], Error>) -> Void)  {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(apikey)&query=\(query)") else { return }
        print("\(url) url")
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let decodedRes = try decoder.decode(TrendingMoviesResponse.self, from: data)
                print(decodedRes)
                completion(.success(decodedRes.results))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

