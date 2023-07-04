import Foundation

struct User: Codable {
    var id: String?
    var username: String
    var email: String
    var password: String
    var firstName: String?
    var lastName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case email
        case password
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
