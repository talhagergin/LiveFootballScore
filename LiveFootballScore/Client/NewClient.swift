//
//  NewClient.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 5.01.2025.
//

import Foundation

struct NewsClient {
    func getNews() async throws -> [News] {
        
        let newsURL = APIEndpoint.newsURL
        
        print("newsURL")
        print(newsURL)
        
        guard let url = URL(string: newsURL) else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
       //Eğer bir API kullanılıyorsa buraya header eklenebilir.
       request.allHTTPHeaderFields = APIEndpoint.headers
        

        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw NetworkError.badRequest
        }
        
        do {
            let apiResponse = try JSONDecoder().decode(APIResponseNews.self, from: data)
            return apiResponse.response.news
        } catch let error as DecodingError {
            switch error {
            case .typeMismatch(let type, let context):
                print("Type mismatch error: \(type), \(context)")
            case .valueNotFound(let value, let context):
                print("Value not found error: \(value), \(context)")
            case .keyNotFound(let key, let context):
                print("Key not found error: \(key), \(context)")
            case .dataCorrupted(let context):
                print("Data corrupted error: \(context)")
            @unknown default:
                print("Unknown decoding error: \(error)")
            }
            throw error
        } catch {
            print("Hata oluştu: \(error.localizedDescription)")
            throw error
        }
    }
}
