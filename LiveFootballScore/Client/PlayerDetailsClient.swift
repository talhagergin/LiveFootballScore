//
//  PlayersDetailsClient.swift
//  LiveFootballScoreTurkish
//
//  Created by Talha Gergin on 8.01.2025.
//

import Foundation

struct PlayerDetailsClient {
    func getPlayerDetailsByPlayerID(playerID: Int) async throws -> [Detail] {
        let playerDetailsURL = APIEndpoint.playersDetailsURL+"\(playerID)"
        print("playerDetailsURL:")
        print(playerDetailsURL)
        guard let url = URL(string: playerDetailsURL) else {
            throw NetworkError.badUrl
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = APIEndpoint.headers

        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw NetworkError.badRequest
        }
        
        do {
            let apiResponse = try JSONDecoder().decode(APIResponsePlayerDetails.self, from: data)
            return apiResponse.response.detail
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
