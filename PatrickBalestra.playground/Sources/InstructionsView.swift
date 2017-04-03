import AppKit

public class InstructionsView: NSView {

    var imageView: NSImageView!

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    func setUp() {
        imageView = NSImageView(image: NSImage(named: "instructions.png")!)
        var frame = bounds.insetBy(dx: 25, dy: 25)
        frame.origin.y += 35
        imageView.frame = frame
        addSubview(imageView)
    }
}
