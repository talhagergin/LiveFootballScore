import Foundation

// Ongoing modelini, maç bilgilerini içerecek şekilde oluşturuyoruz
struct Ongoing: Decodable {
    let id: Int
    let hTeam: String
    let aTeam: String
    let hScore: Int
    let aScore: Int
    let hId: Int
    let aId: Int
    let stage: String
    let time: String
    let status: String
    let sId: Int
    let gs: String
    let extId: String
}

// API yanıtı için ana model
struct APIResponseTeams: Decodable {
    let status: String
    let response: TeamResponse
}

// Takımların listesi
struct TeamResponse: Decodable {
    let list: [Teams]
}

// Takım modelimiz
struct Teams: Decodable, Identifiable {
    let id: Int
    let name: String
    let shortName: String?
    let deduction: Int?
    let ongoing: Ongoing?  // Ongoing alanı opsiyonel hale getirildi
    let played: Int
    let wins: Int
    let draws: Int
    let losses: Int
    let scoreStr: String?
    let goalConDiff: Int?
    let pts: Int
    let idx: Int
    let qualColor: String?
    let logo: String
}
