import AppKit
import SceneKit

public class ContainerView: NSView {

    let scene = MainScene()
    var sceneView: SCNView!
    var detailsView: PersonDetailsView!
    var effectView: NSVisualEffectView!
    var scrollView: NSScrollView!
    var instructionsView: InstructionsView!

    // MARK: View Lifecycle

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    func setUp() {

        // Set up SceneKit scene
        sceneView = SCNView(frame: bounds)
        sceneView.backgroundColor = NSColor.black
        sceneView.scene = scene as SCNScene
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        scene.detailsDelegate = self

        addSubview(sceneView)

        // Add gesture recognizer to click spheres
        let clickRecognizer = NSClickGestureRecognizer(target: self, action: #selector(ContainerView.handleClick(_:)))
        addGestureRecognizer(clickRecognizer)

        // Set up details view
        detailsView = PersonDetailsView(frame: NSRect(x: 100, y: -DetailHeight + 50, width: DetailWidth, height: DetailHeight))
        addSubview(detailsView, positioned: NSWindowOrderingMode.above, relativeTo: sceneView)

        effectView = NSVisualEffectView(frame: bounds)
        effectView.wantsLayer = true
        effectView.layer?.backgroundColor = NSColor(deviceWhite: 0.0, alpha: 0.9).cgColor
        let imageView = NSImageView(frame: bounds)
        imageView.image = NSImage(named: "intro.png")!
        effectView.addSubview(imageView)

        scrollView = NSScrollView(frame: bounds.insetBy(dx: 85, dy: 85))
        scrollView.backgroundColor = .clear
        scrollView.drawsBackground = false
        scrollView.wantsLayer = false
        
        let textView = NSTextView(frame: scrollView.bounds.insetBy(dx: 5, dy: 5))
        textView.textStorage?.append(NSAttributedString.introFormatted())
        textView.textColor = .black
        textView.alignment = .center
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.drawsBackground = false
        textView.isSelectable = false

        scrollView.documentView = textView
        effectView.addSubview(scrollView)
        addSubview(effectView, positioned: .above, relativeTo: detailsView)

        let button = GradientBackgroundButton(frame: NSRect(x: textView.frame.midX-100, y: 480, width: 200, height: 40))

        let showTipsRecognizer = NSClickGestureRecognizer(target: self, action: #selector(showTips(_:)))
        button.addGestureRecognizer(showTipsRecognizer)
        textView.addSubview(button)
    }

    @objc private func handleClick(_ clickGesture: NSClickGestureRecognizer) {
        scene.handleClick(with: clickGesture, scene: sceneView)
    }

    @objc private func showTips(_ click: NSClickGestureRecognizer) {
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 1.0
            scrollView.animator().alphaValue = 0.0
        }) { 
            self.instructionsView = InstructionsView(frame: self.bounds.insetBy(dx: 85, dy: 85))
            let button = GradientBackgroundButton(frame: NSRect(x: self.instructionsView.frame.midX-200, y: 5, width: 200, height: 40))
            button.set(title: "Explore 🌎")
            self.instructionsView.addSubview(button)
            let closeRecognizer = NSClickGestureRecognizer(target: self, action: #selector(self.close(_:)))
            button.addGestureRecognizer(closeRecognizer)
            self.instructionsView.alphaValue = 0.0
            self.effectView.addSubview(self.instructionsView)
            NSAnimationContext.runAnimationGroup({ context in
                context.duration = 0.5
                self.instructionsView.animator().alphaValue = 1.0
            }, completionHandler: nil)
        }
    }

    @objc private func close(_ click: NSClickGestureRecognizer) {
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.5
            context.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            var frame = self.effectView.frame
            frame.origin.y -= CGFloat(PlaygroundHeight)
            self.effectView.animator().frame = frame
        }) { 
            self.effectView.removeFromSuperview()
        }
    }
}

extension ContainerView: DetailsDelegate {

    public func show(id: Int) {
        detailsView.make(visible: true, id: id)
    }
    
    public func hide() {
        detailsView.make(visible: false)
    }
}
