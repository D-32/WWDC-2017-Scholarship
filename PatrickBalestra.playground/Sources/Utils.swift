import Foundation

func randomNumber<T : Integer>(in range: ClosedRange<T> = 1...6) -> Int {
    let length = (range.upperBound - range.lowerBound + 1).toIntMax()
    let value = Int(arc4random().toIntMax() % length + range.lowerBound.toIntMax())
    return value
}

func generateSkyBox(with imageName: String) -> [Any] {
    var skybox = [Any]()
    (0...5).forEach { _ in
        skybox.append(imageName)
    }
    return skybox
}
