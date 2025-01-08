import Foundation

// MARK: - APIResponsePlayerDetails
struct APIResponsePlayerDetails: Codable {
    let status: String
    let response: PlayerDetailsResponse
}

// MARK: - PlayerDetailsResponse
struct PlayerDetailsResponse: Codable {
    let detail: [Detail]
}

// MARK: - Detail
struct Detail: Codable, Identifiable {
    let id = UUID()
    let value: Value
    let title: String
    let translationKey: String
    let icon: Icon?
    let countryCode: String?
}

// MARK: - Icon
struct Icon: Codable {
    let type: String
    let id: String
}

// MARK: - Value
struct Value: Codable {
    let numberValue: Double?
    let options: Options?
    let key: String?
    let fallback: StringOrNumber?
}

// MARK: - StringOrNumber
enum StringOrNumber: Codable {
    case string(String)
    case number(Double)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else if let numberValue = try? container.decode(Double.self) {
            self = .number(numberValue)
        } else {
            throw DecodingError.typeMismatch(
                StringOrNumber.self,
                DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Value is not a String or Number")
            )
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let stringValue):
            try container.encode(stringValue)
        case .number(let numberValue):
            try container.encode(numberValue)
        }
    }
}

// MARK: - Options
struct Options: Codable {
    let style: String?
    let unit: String?
    let unitDisplay: String?
    let currency: String?
    let notation: String?
    let compactDisplay: String?
    let maximumFractionDigits: Int?
    let minimumFractionDigits: Int?
    let trailingZeroDisplay: String?
}
