import Foundation

struct JournalEntry: Codable {
    var id: Int?
    var userId: Int
    var content: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case content
    }
}
