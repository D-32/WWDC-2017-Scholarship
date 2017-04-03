import Foundation

public struct DataSource {

    /// Array of all people in the JSON file.
    public static var people: [Person] = {
        var collection = [Person]()
        if let filePath = Bundle.main.path(forResource: "people", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: [])
                let people = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                if let people = people as? [[String: AnyObject]] {
                    people.forEach { person in
                        let person = Person(dictionary: person)
                        collection.append(person)
                    }
                }
            } catch {}
        }
        return collection
    }()

    /// Retrieve a specific person.
    public static func person(with id: Int) -> Person? {
        return people.filter { $0.id == id }.first
    }
}
