import AppKit

extension NSAttributedString {

    class var centerStyle: NSParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return paragraphStyle
    }

    class var headerAttributes: [String: Any] {
        return [NSForegroundColorAttributeName: NSColor.darkGray, NSParagraphStyleAttributeName: centerStyle, NSFontAttributeName: NSFont.systemFont(ofSize: 15, weight: NSFontWeightThin)]
    }

    class var nameAttributes: [String: Any] {
        return [NSForegroundColorAttributeName: NSColor.black, NSParagraphStyleAttributeName: centerStyle, NSFontAttributeName: NSFont.systemFont(ofSize: 45, weight: NSFontWeightRegular)]
    }

    class var twitterCountryAttributes: [String: Any] {
        return [NSForegroundColorAttributeName: NSColor.black, NSParagraphStyleAttributeName: centerStyle, NSFontAttributeName: NSFont.systemFont(ofSize: 25, weight: NSFontWeightThin)]
    }

    class var descriptionAttributes: [String: Any] {
        return [NSForegroundColorAttributeName: NSColor.black, NSParagraphStyleAttributeName: centerStyle, NSFontAttributeName: NSFont.systemFont(ofSize: 25, weight: NSFontWeightThin)]
    }

    class var descriptionSmallAttributes: [String: Any] {
        return [NSForegroundColorAttributeName: NSColor.black, NSParagraphStyleAttributeName: centerStyle, NSFontAttributeName: NSFont.systemFont(ofSize: 18, weight: NSFontWeightThin)]
    }

    class var descriptionKeywordsAttributes: [String: Any] {
        return [NSForegroundColorAttributeName: NSColor.black, NSParagraphStyleAttributeName: centerStyle, NSFontAttributeName: NSFont.systemFont(ofSize: 25, weight: NSFontWeightRegular)]
    }

    class var introAttributes: [String: Any] {
        return [NSForegroundColorAttributeName: NSColor.gray, NSParagraphStyleAttributeName: centerStyle, NSFontAttributeName: NSFont(name: "HelveticaNeue-Light", size: 21)!]
    }

    class var introHighlightAttributes: [String: Any] {
        return [NSForegroundColorAttributeName: NSColor.gray, NSParagraphStyleAttributeName: centerStyle, NSFontAttributeName: NSFont(name: "HelveticaNeue-Medium", size: 21)!]
    }

    // MARK: Functions

    class func introFormatted() -> NSAttributedString {
        let string = NSMutableAttributedString(string: "👋 Hello!\nMy name is ", attributes: introAttributes)
        string.append(NSAttributedString(string: "Patrick", attributes: introHighlightAttributes))
        string.append(NSAttributedString(string: ". I love the Apple community and it is one of the many reasons why I love creating apps for Apple devices.\n\nThis is my creative way of thanking each person that I met through my passion for technology. It's an interactive world with all the people I met in ", attributes: introAttributes))
        string.append(NSAttributedString(string: "real life", attributes: introHighlightAttributes))
        string.append(NSAttributedString(string: " since I entered the Apple ", attributes: introAttributes))
        string.append(NSAttributedString(string: "community", attributes: introHighlightAttributes))
        string.append(NSAttributedString(string: ".\nMeetups, conferences, open-source projects and professional experiences helped me ", attributes: introAttributes))
        string.append(NSAttributedString(string: "meeting ", attributes: introHighlightAttributes))
        string.append(NSAttributedString(string: "these amazing people with my same interests. They come from all different parts of the world, speak different languages and have totally different cultures.\nOne thing is for sure, we have one big passion in ", attributes: introAttributes))
        string.append(NSAttributedString(string: "common", attributes: introHighlightAttributes))
        string.append(NSAttributedString(string: ".\n\nEnjoy my Playground 😀\n\n\n", attributes: introAttributes))
        return string
    }

    class func headerFormatted(with name: String) -> NSAttributedString {
        return NSAttributedString(string: name, attributes: headerAttributes)
    }

    class func titleFormatted(with name: String, twitter: String, country: String) -> NSAttributedString {
        let string = NSMutableAttributedString(string: name, attributes: nameAttributes)
        if twitter.isEmpty {
            string.append(NSAttributedString(string: "\n\(country)", attributes: twitterCountryAttributes))
        } else {
            string.append(NSAttributedString(string: "\n\(twitter) - \(country)", attributes: twitterCountryAttributes))
        }
        return string
    }

    class func descriptionFormatted(with year: Int, event: String?, location: String, country: String, description: String? = nil) -> NSAttributedString {
        let string = NSMutableAttributedString(string: "First met in ", attributes: descriptionAttributes)
        string.append(NSAttributedString(string: "\(year) ", attributes: descriptionKeywordsAttributes))

        if let event = event, event.isEmpty == false {
            string.append(NSAttributedString(string: "at ", attributes: descriptionAttributes))
            string.append(NSAttributedString(string: "\(event) ", attributes: descriptionKeywordsAttributes))
        }

        string.append(NSAttributedString(string: "in ", attributes: descriptionAttributes))
        string.append(NSAttributedString(string: "\(location).\n", attributes: descriptionKeywordsAttributes))
        string.append(NSAttributedString(string: "Currently lives in ", attributes: descriptionAttributes))
        string.append(NSAttributedString(string: "\(country).", attributes: descriptionKeywordsAttributes))
        if let description = description, description.isEmpty == false {
            string.append(NSAttributedString(string: "\n\n\(description)", attributes: descriptionSmallAttributes))
        }
        return string
    }
}
