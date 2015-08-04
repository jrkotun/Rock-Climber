import Foundation

class Store: CCNode {
    weak var totalCoinLabel: CCLabelTTF!
    let defaults = NSUserDefaults.standardUserDefaults()
    var totalCoins = NSUserDefaults.standardUserDefaults().integerForKey("totalCoins")
    
    func didLoadFromCCB() {
        totalCoinLabel.string = "\(totalCoins)"
    }
    
    override func update(delta: CCTime) {
        defaults.synchronize()
        totalCoins = defaults.integerForKey("totalCoins")
        totalCoinLabel.string = "\(totalCoins)"
    }
    
    func titleMenu() {
        var titleScreen = CCBReader.load("MainScene") as! MainScene
        var scene = CCScene()
        scene.addChild(titleScreen)
        var transition = CCTransition(fadeWithDuration: 0.3)
        CCDirector.sharedDirector().presentScene(scene, withTransition: transition)
    }
}