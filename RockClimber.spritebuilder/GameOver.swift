import Foundation

class GameOver: CCNode {
    weak var score: CCLabelTTF!
    weak var highScoreNumber: CCLabelTTF!
    weak var coinsCollected: CCLabelTTF!
    
    func didLoadFromCCB() {
        updateHighScore()
        OALSimpleAudio.sharedInstance().playBg("Music/GameOver.wav", loop:false)
    }
    
    override func update(delta: CCTime) {
        let defaults = NSUserDefaults.standardUserDefaults()
        var currentHighScore = defaults.integerForKey("highScore")
        highScoreNumber.string = "\(currentHighScore)"
    }
 
    func setLastScore(lastScore: Int) {
        score.string = "\(lastScore)"
    }
    
    func setCoinCollected(coins: Int) {
        coinsCollected.string = "\(coins)"
    }
    
    func updateHighScore() {
        var newHighScore = NSUserDefaults.standardUserDefaults().integerForKey("highScore")
        highScoreNumber.string = "\(newHighScore)"
    }

    func restart() {
        var mainScene = CCBReader.load("MainScene") as! MainScene
        mainScene.ready()
        var scene = CCScene()
        scene.addChild(mainScene)
        var transition = CCTransition(fadeWithDuration: 0.3)
        CCDirector.sharedDirector().presentScene(scene, withTransition: transition)
        OALSimpleAudio.sharedInstance().stopBg()
    }
    
    func titleMenu() {
        var mainScene = CCBReader.load("MainScene") as! MainScene
        mainScene.titleMenu()
        var scene = CCScene()
        scene.addChild(mainScene)
        var transition = CCTransition(fadeWithDuration: 0.3)
        CCDirector.sharedDirector().presentScene(scene, withTransition: transition)
    }
}