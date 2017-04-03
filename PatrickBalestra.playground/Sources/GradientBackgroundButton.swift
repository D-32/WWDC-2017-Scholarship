import AppKit

public class GradientBackgroundButton: NSView {

    private var titleLabel: TextLabel!

    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setUp()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    public func set(title: String) {
        titleLabel.stringValue = "Explore 🌎"
    }

    private func setUp() {
        wantsLayer = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [NSColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1.0).cgColor, NSColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1.0)
        layer = gradientLayer
        layer?.cornerRadius = 7.0
        layer?.masksToBounds = true

        let shadow = NSShadow()
        shadow.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5443600171)
        shadow.shadowOffset = CGSize(width: 0, height: -1)
        shadow.shadowBlurRadius = 1
        self.shadow = shadow

        titleLabel = TextLabel(frame: CGRect(x: bounds.midX - 75, y: bounds.midY - 35, width: 150, height: 50))
        titleLabel.stringValue = "Next ➡️"
        titleLabel.alignment = .center
        titleLabel.font = NSFont.systemFont(ofSize: 25, weight: NSFontWeightThin)
        titleLabel.textColor = NSColor.black
        addSubview(titleLabel)
    }
}
