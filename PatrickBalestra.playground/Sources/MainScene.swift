import AppKit
import SceneKit

public class MainScene: SCNScene {

    public weak var detailsDelegate: DetailsDelegate?

    /// Returns a float number between -1 and 1.
    var randomFloat: CGFloat {
        return CGFloat(CGFloat(randomNumber(in: -1000...1000))/1000)
    }

    var people = DataSource.people

    public override init() {
        super.init()

        // Set skybox
        background.contents = generateSkyBox(with: "background.jpg")

        // Light
        let light = SCNLight()
        light.type = SCNLight.LightType.ambient
        light.color = NSColor(white: 0.25, alpha: 0.5)

        // Light node
        let lightNode = SCNNode()
        lightNode.light = light
        self.rootNode.addChildNode(lightNode)

        var index = 0
        for i in 0..<5 {
            for j in 0..<5 {
                for z in 0..<6 {
                    if index < people.count {
                        let person = people[index]
                        let x = CGFloat(i * 10) + CGFloat(randomNumber(in: -2...2))
                        let y = CGFloat(j * 10) + CGFloat(randomNumber(in: -2...2))
                        let z = CGFloat(z * 10) + CGFloat(randomNumber(in: -2...2))
                        let node = createSpere(at: SCNVector3(x, y, z), person: person)
                        node.name = "\(person.id)"
                        rootNode.addChildNode(node)
                        index += 1
                    }
                }
            }
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createSpere(at position: SCNVector3, person: Person) -> SCNNode {
        let sphere = SCNSphere(radius: 2)
        let material = SCNMaterial()
        material.diffuse.contents = generateImage(for: person)
        sphere.materials = [material]
        let node = SCNNode(geometry: sphere)
        let shape = SCNPhysicsShape(geometry: sphere, options: nil)
        let body = SCNPhysicsBody(type: .kinematic, shape: shape)
        node.position = position
        node.physicsBody = body
        node.categoryBitMask = 1
        node.addAnimation(generateSpinAnimation(), forKey: "spin around")
        return node
    }

    public func handleClick(with clickGesture: NSClickGestureRecognizer, scene: SCNView) {
        let point = clickGesture.location(in: scene)
        let hits = scene.hitTest(point, options: nil)

        if let result = hits.first, let material = result.node.geometry?.firstMaterial {
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.25
            result.node.scale = SCNVector3(x: 1.1, y: 1.1, z: 1.1)
            material.emission.contents = NSColor(white: 0.5, alpha: 0.25)
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.25
                material.emission.contents = NSColor.black
                result.node.scale = SCNVector3(x: 1.0, y: 1.0, z: 1.0)
                SCNTransaction.commit()
                let id = Int(result.node.name ?? "-1") ?? -1
                self.detailsDelegate?.show(id: id)
            }
            SCNTransaction.commit()
        }
    }

    private func generateImage(for person: Person) -> NSImage {
        return NSImage(named: "\(person.id).jpg") ?? NSImage(named: "0.jpg")!
    }

    private func generateSpinAnimation() -> CABasicAnimation {
        let spin = CABasicAnimation(keyPath: "rotation")
        spin.fromValue = NSValue(scnVector4: SCNVector4(x: 0, y: 0, z: 1, w: 0))
        var direction = Double(randomNumber(in: -1...1))
        if direction == 0 { direction = 1 }
        spin.toValue = NSValue(scnVector4: SCNVector4(x: randomFloat, y: randomFloat, z: randomFloat, w: CGFloat(2 * .pi * direction)))
        let duration = randomNumber(in: 10000...20000) / 500
        spin.duration = CFTimeInterval(duration)
        spin.repeatCount = .infinity
        return spin
    }
}
