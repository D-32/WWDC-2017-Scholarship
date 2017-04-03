import AppKit

public class TextLabel: NSTextField {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    func setUp() {
        textColor = NSColor.darkGray
        font = NSFont.systemFont(ofSize: 16)
        isBezeled = false
        drawsBackground = false
        isEditable = false
        isSelectable = false
    }
}
