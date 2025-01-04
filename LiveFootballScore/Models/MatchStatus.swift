import Foundation

// Maçların durumu için model
struct MatchStatus: Decodable {
    let utcTime: String
    let finished: Bool
    let started: Bool
    let cancelled: Bool
    let awarded: Bool? // Optional yaptık
    let scoreStr: String?  // Optional yaptık
    let reason: Reason? // Optional yaptık
}

// Maç durumunun kısa/uzun açıklama modeli
struct Reason: Decodable {
    let short: String
    let shortKey: String
    let long: String
    let longKey: String
}


// Takım bilgisi için ortak model
struct TeamInfo: Decodable {
    let id: String
    let name: String
    let score: Int
}

// Maç modelimiz
struct Match: Decodable, Identifiable {
    let id: String
    let pageUrl: String
    let opponent: TeamInfo
    let home: TeamInfo
    let away: TeamInfo
    let displayTournament: Bool
    let notStarted: Bool
    let tournament: [String: String]? // tournament nesnesi boş veya dolu olabileceği için dictionary olarak tanımladım.
    let status: MatchStatus
}

// API yanıtı için ana model
struct APIResponseMatches: Decodable {
    let status: String
    let response: MatchResponse
}

// Maçların listesi
struct MatchResponse: Decodable {
    let matches: [Match]
}
