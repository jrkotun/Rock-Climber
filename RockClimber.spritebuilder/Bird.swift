import Foundation

class Bird: CCSprite {
    func birdRemoved(bird: Bird) {
        let collectedAnimation = CCBReader.load("BirdCollected") as! CCParticleSystem
        collectedAnimation.autoRemoveOnFinish = true;
        collectedAnimation.positionType = CCPositionType(xUnit: .Normalized, yUnit: .Normalized, corner: .BottomLeft)
        collectedAnimation.position = bird.position;
        bird.parent.addChild(collectedAnimation)
        bird.removeFromParent()
    }
}