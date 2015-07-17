import Foundation

class MainScene: CCNode, CCPhysicsCollisionDelegate {
    weak var mainScene: CCNode!
    weak var background1: CCNode!
    weak var background2: CCNode!
    weak var gamePhysicsNode: CCPhysicsNode!
    var player = CCBReader.load("Player") as! Player
    var timer = NSTimer()
    var obstacleDelay = 2.0
    var overState: Bool?
    var scrollSpeed: CGFloat = 0.0025
    var score = 0

    func didLoadFromCCB() {
        userInteractionEnabled = true
        gamePhysicsNode.collisionDelegate = self
        overState = false
        playerSetup()
        setupGestures()
        timer = NSTimer.scheduledTimerWithTimeInterval(obstacleDelay, target: self, selector: "obstacles", userInfo: nil, repeats: true)
    }
    
    override func update(delta: CCTime) {
        if overState == false {
            backgroundMovement()
            score++
        }
    }
    
    func backgroundMovement() {
        background1.position.y -= scrollSpeed
        background2.position.y -= scrollSpeed
        if (background1.position.y + 1) < 0 {
            background1.position.y = 1
        }
        if (background2.position.y + 1) < 0 {
            background2.position.y = 1
        }
    }
    
    func playerSetup() {
        player.positionType = CCPositionType(xUnit: .Normalized, yUnit: .Normalized, corner: .BottomLeft)
        player.position = ccp(0.5, 0.4)
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
        
        var swipeUp = UISwipeGestureRecognizer(target: self, action: "swipeUp")
        swipeUp.direction = .Up
        CCDirector.sharedDirector().view.addGestureRecognizer(swipeUp)
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: "swipeDown")
        swipeDown.direction = .Down
        CCDirector.sharedDirector().view.addGestureRecognizer(swipeDown)
    }
    
    func swipeLeft() {
        if player.position.x > 0.1 {
            player.position = ccp(player.position.x - 0.2, player.position.y)
        }
    }
    
    func swipeRight() {
        if player.position.x < 0.9 {
            player.position = ccp(player.position.x + 0.2, player.position.y)
        }
    }
    
    func swipeUp() {
        if player.position.y < 0.5 {
            player.position = ccp(player.position.x, player.position.y + 0.1)
        }
    }
    
    func swipeDown() {
        if player.position.y > 0.3 {
            player.position = ccp(player.position.x, player.position.y - 0.1)
        }
    }
    
    func obstacles() {
        var random = CCRANDOM_0_1() * 2
        
        if random < 1 {
            fallingRocks()
        } else {
            flyingBirds()
        }
    }
    
    func fallingRocks() {
        var rock = CCBReader.load("Rock") as! Rock
        rock.scale = 3.0
        rock.positionType = CCPositionType(xUnit: .Normalized, yUnit: .Normalized, corner: .BottomLeft)
        gamePhysicsNode.addChild(rock)
        var random = CCRANDOM_0_1() * 6
        
        switch random {
        case 0..<3:
            rock.position = ccp(player.position.x, 1.1)
        case 3..<6:
            rock.position = ccp(player.position.x, 1.1)
        default:
            return
        }
        
        switch random {
        case 0..<1:
            gamePhysicsNode.gravity.y = -1250
        case 1..<2:
            gamePhysicsNode.gravity.y = -1000
        case 2..<3:
            gamePhysicsNode.gravity.y = -750
        case 3..<4:
            gamePhysicsNode.gravity.y = -500
        case 4..<5:
            gamePhysicsNode.gravity.y = -250
        default:
            gamePhysicsNode.gravity.y = -100
        }
    }
    
    func flyingBirds() {
        var bird = CCBReader.load("Bird") as! Bird
        bird.positionType = CCPositionType(xUnit: .Normalized, yUnit: .Normalized, corner: .BottomLeft)
        bird.position = ccp(1.1, player.position.y)
        bird.scaleX = -1
        gamePhysicsNode.addChild(bird)
        var random = CCRANDOM_0_1() * 5
        switch random {
        case 0..<1:
            bird.physicsBody.applyImpulse(ccp(-125, 0))
        case 1..<2:
            bird.physicsBody.applyImpulse(ccp(-100, 0))
        case 2..<3:
            bird.physicsBody.applyImpulse(ccp(-75, 0))
        case 3..<4:
            bird.physicsBody.applyImpulse(ccp(-50, 0))
        default:
            bird.physicsBody.applyImpulse(ccp(-25, 0))
        }
    }
    
    func triggerGameOver() {
        var gameOver = CCBReader.load("GameOver", owner: self) as! GameOver
        gameOver.setLastScore(score)
        self.addChild(gameOver)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var highScore = defaults.integerForKey("highScore")
        if self.score > highScore {
            defaults.setInteger(Int(self.score), forKey: "highScore")
        }
    }
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, remove: CCNode!, wildcard: CCNode!) {
        wildcard.removeFromParent()
    }
    
    func ccPhysicsCollisionPreSolve(pair: CCPhysicsCollisionPair!, obstacle one: CCNode!, obstacle two: CCNode!) -> Bool {
        one.physicsBody.sensor = true
        two.physicsBody.sensor = true
        return false
    }
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, playerC: CCNode!, obstacle: CCSprite!) {
        obstacle.removeFromParent()
        overState = true
        timer.invalidate()
        triggerGameOver()
    }
}