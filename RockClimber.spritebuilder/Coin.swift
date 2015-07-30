import Foundation

class Coin: CCSprite {
    func coinRemoved(coin: Coin) {
        let collectedAnimation = CCBReader.load("CoinCollected") as! CCParticleSystem
        collectedAnimation.autoRemoveOnFinish = true;
        collectedAnimation.positionType = CCPositionType(xUnit: .Normalized, yUnit: .Normalized, corner: .BottomLeft)
        collectedAnimation.position = coin.position;
        coin.parent.addChild(collectedAnimation)
        coin.removeFromParent()
    }
}