import Foundation

class GameOver: CCNode {
    weak var score: CCLabelTTF!
    weak var highScoreNumber: CCLabelTTF!
    weak var coinsCollected: CCLabelTTF!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    func didLoadFromCCB() {
        updateHighScore()
        OALSimpleAudio.sharedInstance().playEffect("Music and Sounds/GameOver.wav", loop:false)
    }
 
    override func update(delta: CCTime) {
        var currentBestScore = defaults.integerForKey("highScore")
        highScoreNumber.string = "\(currentBestScore)"
    }
    
    func setLastScore(lastScore: Int) {
        score.string = "\(lastScore)"
    }
    
    func updateHighScore() {
        let newHighScore = defaults.integerForKey("highScore")
        highScoreNumber.string = "\(newHighScore)"
    }
    
    func setCoinCollected(coins: Int) {
        coinsCollected.string = "\(coins)"
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