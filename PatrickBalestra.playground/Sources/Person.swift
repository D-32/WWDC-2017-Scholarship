import Foundation

public struct Person {
    let id: Int
    let name: String
    let twitter: String
    let birthCountry: String
    let year: Int
    let event: String
    let location: String
    let city: String
    var description: String?
}

extension Person {

    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["id"] as! Int
        self.name = dictionary["name"] as! String
        self.twitter = dictionary["twitter"] as! String
        self.birthCountry = dictionary["birthCountry"] as! String
        self.year = dictionary["year"] as! Int
        self.event = dictionary["event"] as! String
        self.location = dictionary["location"] as! String
        self.city = dictionary["city"] as! String
        self.description = dictionary["description"] as? String
    }
}
