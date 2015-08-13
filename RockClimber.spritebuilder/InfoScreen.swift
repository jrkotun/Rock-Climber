import Foundation

class InfoScreen: CCNode {
    func support() {
        UIApplication.sharedApplication().openURL(NSURL(string:"https://docs.google.com/forms/d/1Hj5fivBmnKakS2uhqbViRzQeAf400Zf536gEQE91FeM/viewform")!)
    }
    
    func titleMenu() {
        var titleScreen = CCBReader.load("MainScene") as! MainScene
        var scene = CCScene()
        scene.addChild(titleScreen)
        var transition = CCTransition(fadeWithDuration: 0.3)
        CCDirector.sharedDirector().presentScene(scene, withTransition: transition)
    }
}