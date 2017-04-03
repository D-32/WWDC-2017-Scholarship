import AppKit

public class PersonDetailsView: NSView {

    var textLabel: TextLabel!
    var nameLabel: TextLabel!
    var informationLabel: TextLabel!

    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setUp()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    func setUp() {
        wantsLayer = true
        layer?.backgroundColor = NSColor.white.cgColor
        layer?.cornerRadius = 20.0

        let imageView = NSImageView(frame: NSRect(x: bounds.midX - 25, y: bounds.maxY - 12, width: 50, height: 7))
        imageView.image = #imageLiteral(resourceName: "bar.png")
        addSubview(imageView)

        let panRecognizer = NSPanGestureRecognizer(target: self, action: #selector(panRecognized(_:)))
        addGestureRecognizer(panRecognizer)

        textLabel = TextLabel(frame: NSRect(x: 20, y: 355, width: bounds.width - 40, height: 25))
        textLabel.attributedStringValue = NSAttributedString.headerFormatted(with: "Click a Sphere to learn more about a person 🌎")
        textLabel.alignment = .center
        textLabel.font = NSFont.systemFont(ofSize: 20)
        addSubview(textLabel)

        nameLabel = TextLabel(frame: NSRect(x: 20, y: 260, width: bounds.width - 40, height: 90))
        nameLabel.alignment = .center
        nameLabel.textColor = NSColor.black
        nameLabel.font = NSFont.systemFont(ofSize: 30)
        addSubview(nameLabel)

        informationLabel = TextLabel(frame: NSRect(x: 20, y: 0, width: bounds.width - 40, height: 220))
        informationLabel.alignment = .center
        informationLabel.textColor = NSColor.black
        informationLabel.font = NSFont.systemFont(ofSize: 25)
        addSubview(informationLabel)
    }

    public func updateUI(person: Person) {
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.25
            self.nameLabel.animator().alphaValue = 0.0
            self.informationLabel.animator().alphaValue = 0.0
        }) {
            self.nameLabel.attributedStringValue = NSAttributedString.titleFormatted(with: person.name, twitter: person.twitter, country: person.birthCountry)
            self.informationLabel.attributedStringValue = NSAttributedString.descriptionFormatted(with: person.year, event: person.event, location: person.location, country: person.city, description: person.description)
            NSAnimationContext.runAnimationGroup({ context in
                context.duration = 0.5
                self.nameLabel.animator().alphaValue = 1.0
                self.informationLabel.animator().alphaValue = 1.0
            })
        }
    }

    public func make(visible: Bool, id: Int = -1) {

        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.5
            if visible {
                self.animator().frame.origin.y = 0
            } else {
                self.animator().frame.origin.y = -CGFloat(DetailHeight) + 50
            }
        })

        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.2
            self.textLabel.animator().alphaValue = 0.0
        }, completionHandler: { completed in
            if let person = DataSource.person(with: id) {
                self.updateUI(person: person)
            }

            if visible {
                self.textLabel.attributedStringValue = NSAttributedString.headerFormatted(with: "Pull down to close 👇")
            } else {
                self.textLabel.attributedStringValue = NSAttributedString.headerFormatted(with: "Click a Sphere to learn more about a person 🌎")
            }
            NSAnimationContext.runAnimationGroup({ context in
                context.duration = 0.2
                self.textLabel.animator().alphaValue = 1.0
            })
        })
    }

    @objc private func panRecognized(_ panGesture: NSPanGestureRecognizer) {
        guard self.frame.origin.y != -CGFloat(DetailHeight) + 50 else { return }
        switch panGesture.state {
        case .ended:
            if CGFloat(DetailHeight) - abs(self.frame.origin.y) >= bounds.height / 2 {
                make(visible: true)
            } else {
                make(visible: false)
                self.nameLabel.animator().alphaValue = 0.0
                self.informationLabel.animator().alphaValue = 0.0
            }
        default:
            self.frame.origin.y = panGesture.location(in: self.superview).y - self.bounds.height
        }
    }
}
