import Foundation

class MainScene: CCNode, CCPhysicsCollisionDelegate {
    weak var mainScene: CCNode!
    weak var background1: CCNode!
    weak var background2: CCNode!
    weak var gamePhysicsNode: CCPhysicsNode!
    var player = CCBReader.load("Player") as! Player
    var timer = NSTimer()
    var scrollSpeed: CGFloat = 0.001
    var score: Double = 0.0

    func didLoadFromCCB() {
        userInteractionEnabled = true
        gamePhysicsNode.collisionDelegate = self
        setupGestures()
        playerSetup()
        //timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "fallingRocks", userInfo: nil, repeats: true)
    }
    
    func playerSetup() {
        player.position = CGPoint(x: 158.4, y: 113.6)
        player.scale = 3.0
        gamePhysicsNode.addChild(player)
    }
    
    func setupGestures() {
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "swipeLeft")
        swipeLeft.direction = .Left
        CCDirector.sharedDirector().view.addGestureRecognizer(swipeLeft)
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "swipeRight")
        swipeRight.direction = .Right
        CCDirector.sharedDirector().view.addGestureRecognizer(swipeRight)
    }
    
    func swipeLeft() {
        if player.position.x > 30.4 {
            player.position = CGPoint(x: player.position.x - 64, y: player.position.y)
        }
    }
    
    func swipeRight() {
        if player.position.x < 280 {
            player.position = CGPoint(x: player.position.x + 64, y: player.position.y)
        }
    }
    
    override func update(delta: CCTime) {
        background1.positionType = CCPositionTypePoints
        background2.positionType = CCPositionTypePoints
        background1.position.y -= scrollSpeed
        background2.position.y -= scrollSpeed
        if (background1.contentSize.height - background1.position.y) < 0 {
            println("1111111")
            background1.position.y = background1.contentSize.height
        }
        if (background2.contentSize.height - background2.position.y) < 0 {
            println("2222222")
            background2.position.y = background1.contentSize.height
        }
    }
    
    func fallingRocks() {
        var random = CCRANDOM_0_1() * 5
        var rock = CCBReader.load("Rock") as! Rock
        if random < 1 {
            rock.position = CGPoint(x: 30.0, y: 624.8)
        } else if  random < 2 {
            rock.position = CGPoint(x: 96.0, y: 624.8)
        } else if  random < 3 {
            rock.position = CGPoint(x: 156.0, y: 624.8)
        } else if  random < 4 {
            rock.position = CGPoint(x: 220.0, y: 624.8)
        } else {
            rock.position = CGPoint(x: 284.0, y: 624.8)
        }
        rock.scale = 3.0
        gamePhysicsNode.addChild(rock)
    }
    
    func triggerGameOver() {
        var scene = CCBReader.loadAsScene("GameOver")
        CCDirector.sharedDirector().presentScene(scene)
    }
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, goal: CCNode!, rock: Rock!) {
        rock.removeFromParent()
    }
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, playerC: CCNode!, rock: Rock!) {
        rock.removeFromParent()
        timer.invalidate()
        triggerGameOver()
    }
}