import Foundation

class Store: CCNode {
    weak var storeIcon10: CCSprite!
    weak var totalCoinLabel: CCLabelTTF!
    weak var scrollView: CCScrollView!
    weak var indicator1: CCSprite!
    weak var indicator2: CCSprite!
    weak var indicator3: CCSprite!
    weak var indicator4: CCSprite!
    weak var indicator5: CCSprite!
    let defaults = NSUserDefaults.standardUserDefaults()
    var totalCoins = NSUserDefaults.standardUserDefaults().integerForKey("totalCoins")
    
    func didLoadFromCCB() {
        totalCoinLabel.string = "\(totalCoins)"
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            storeIcon10.position.x = 0.335
        }
    }
    
    override func update(delta: CCTime) {
        defaults.synchronize()
        totalCoins = defaults.integerForKey("totalCoins")
        totalCoinLabel.string = "\(totalCoins)"
        
        if scrollView.horizontalPage == 0 {
            indicator1.spriteFrame = CCSpriteFrame(imageNamed: "Rock Climber Assets/Page Indicator 2.png") as CCSpriteFrame
            indicator2.spriteFrame = CCSpriteFrame(imageNamed: "Rock Climber Assets/Page Indicator 1.png") as CCSpriteFrame
        } else if scrollView.horizontalPage == 1 {
            indicator1.spriteFrame = CCSpriteFrame(imageNamed: "Rock Climber Assets/Page Indicator 1.png") as CCSpriteFrame
            indicator2.spriteFrame = CCSpriteFrame(imageNamed: "Rock Climber Assets/Page Indicator 2.png") as CCSpriteFrame
            indicator3.spriteFrame = CCSpriteFrame(imageNamed: "Rock Climber Assets/Page Indicator 1.png") as CCSpriteFrame
        } else if scrollView.horizontalPage == 2 {
            indicator2.spriteFrame = CCSpriteFrame(imageNamed: "Rock Climber Assets/Page Indicator 1.png") as CCSpriteFrame
            indicator3.spriteFrame = CCSpriteFrame(imageNamed: "Rock Climber Assets/Page Indicator 2.png") as CCSpriteFrame
            indicator4.spriteFrame = CCSpriteFrame(imageNamed: "Rock Climber Assets/Page Indicator 1.png") as CCSpriteFrame
        } else if scrollView.horizontalPage == 3 {
            indicator3.spriteFrame = CCSpriteFrame(imageNamed: "Rock Climber Assets/Page Indicator 1.png") as CCSpriteFrame
            indicator4.spriteFrame = CCSpriteFrame(imageNamed: "Rock Climber Assets/Page Indicator 2.png") as CCSpriteFrame
            indicator5.spriteFrame = CCSpriteFrame(imageNamed: "Rock Climber Assets/Page Indicator 1.png") as CCSpriteFrame
        } else if scrollView.horizontalPage == 4 {
            indicator4.spriteFrame = CCSpriteFrame(imageNamed: "Rock Climber Assets/Page Indicator 1.png") as CCSpriteFrame
            indicator5.spriteFrame = CCSpriteFrame(imageNamed: "Rock Climber Assets/Page Indicator 2.png") as CCSpriteFrame
        }
    }
    
    func titleMenu() {
        var titleScreen = CCBReader.load("MainScene") as! MainScene
        var scene = CCScene()
        scene.addChild(titleScreen)
        var transition = CCTransition(fadeWithDuration: 0.3)
        CCDirector.sharedDirector().presentScene(scene, withTransition: transition)
    }
}