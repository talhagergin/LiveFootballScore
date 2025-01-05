//
//  TopPlayersClient.swift
//  LiveFootballScore
//
//  Created by Talha Gergin on 5.01.2025.
//
import Foundation

struct PlayersClient {
    func getPlayersByLeagueID(leagueID: Int) async throws -> [Player] {
       
        let playersURL = APIEndpoint.topPlayersGolURL+"\(leagueID)"
        
        print("playersURL")
        print(playersURL)
        
        guard let url = URL(string: playersURL) else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Eger API kullanılıyorsa buraya header eklenebilir.
       request.allHTTPHeaderFields = APIEndpoint.headers

        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw NetworkError.badRequest
        }
        
        do {
            let apiResponse = try JSONDecoder().decode(APIResponsePlayers.self, from: data)
            return apiResponse.response.players
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
    func getAssistPlayersByLeagueID(leagueID: Int) async throws -> [PlayerAssist] {
       
        let playersAssistURL = APIEndpoint.topPlayersAssistURL+"\(leagueID)"
        
        print("playersAssistURL")
        print(playersAssistURL)
        
        guard let url = URL(string: playersAssistURL) else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Eger API kullanılıyorsa buraya header eklenebilir.
       request.allHTTPHeaderFields = APIEndpoint.headers

        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw NetworkError.badRequest
        }
        
        do {
            let apiResponse = try JSONDecoder().decode(APIResponsePlayersAssist.self, from: data)
            return apiResponse.response.players
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
    func getRatingPlayersByLeagueID(leagueID: Int) async throws -> [PlayerRating] {
       
        let ratingsURL = APIEndpoint.topPlayersRatingURL+"\(leagueID)"
        
        print("ratingsURL")
        print(ratingsURL)
        
        guard let url = URL(string: ratingsURL) else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Eger API kullanılıyorsa buraya header eklenebilir.
       request.allHTTPHeaderFields = APIEndpoint.headers

        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
            throw NetworkError.badRequest
        }
        
        do {
            let apiResponse = try JSONDecoder().decode(APIResponsePlayersRating.self, from: data)
            return apiResponse.response.players
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
