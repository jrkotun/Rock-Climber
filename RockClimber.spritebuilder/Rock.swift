import Foundation

class Rock: CCSprite {
    func rockRemoved(rock: Rock) {
        let collectedAnimation = CCBReader.load("RockCollected") as! CCParticleSystem
        collectedAnimation.autoRemoveOnFinish = true;
        collectedAnimation.positionType = CCPositionType(xUnit: .Normalized, yUnit: .Normalized, corner: .BottomLeft)
        collectedAnimation.position = rock.position;
        rock.parent.addChild(collectedAnimation)
        rock.removeFromParent()
    }
}