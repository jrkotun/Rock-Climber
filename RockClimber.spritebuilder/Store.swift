import Foundation

class Store: CCNode {
    weak var totalCoinLabel: CCLabelTTF!
    
    func didLoadFromCCB() {
        let defaults = NSUserDefaults.standardUserDefaults()
        var totalCoins = defaults.integerForKey("totalCoins")
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