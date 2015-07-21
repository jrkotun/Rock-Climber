import Foundation

enum GameState {
    case Title, Ready, Playing, Pause, GameOver
}

class MainScene: CCNode, CCPhysicsCollisionDelegate {
    weak var mainScene: CCNode!
    weak var background1: CCNode!
    weak var background2: CCNode!
    weak var player: CCSprite!
    weak var gamePhysicsNode: CCPhysicsNode!
    weak var swipeIndicators: CCNode!
    weak var pauseButton: CCButton!
    weak var pauseScreen: CCNode!
    weak var scoreLabel: CCLabelTTF!
    weak var movementRange: CCNodeGradient!
    var gameState: GameState = .Title
    var rockDelay = 2.0
    var birdDelay = 3.0
    var coinDelay = 10.0
    var scrollSpeed: CGFloat = 0.0025
    var rockGravity = [-75, -65, -55, -45, -35, -25]
    var birdImpulse = [300, 250, 200]
    var score = 0
    
    func didLoadFromCCB() {
        userInteractionEnabled = true
        gamePhysicsNode.collisionDelegate = self
    }
    
    override func update(delta: CCTime) {
        backgroundMovement()
        if gameState != .Playing {
            return
        }
        score++
        scoreLabel.string = "\(score)"
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
    
    func ready() {
        swipeIndicators.visible = true
        movementRange.visible = true
        gameState = .Ready
        self.animationManager.runAnimationsForSequenceNamed("Ready")
        setupGestures()
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        if gameState == .GameOver || gameState == .Title || gameState == .Pause {
            return
        }
        if gameState == .Ready {
            startGame()
        }
    }
    
    func startGame() {
        gameState = .Playing
        swipeIndicators.visible = false
        movementRange.visible = false
        pauseButton.visible = true
        scoreLabel.visible = true
        startObstacles()
    }
    
    func pause() {
        gameState = .Pause
        pauseScreen.visible = true
        mainScene.paused = true
        disableGestures()
    }
    
    func resume() {
        gameState = .Playing
        pauseScreen.visible = false
        mainScene.paused = false
        setupGestures()
    }
    
    func titleMenu() {
        var titleScreen = CCBReader.load("MainScene") as! MainScene
        var scene = CCScene()
        scene.addChild(titleScreen)
        var transition = CCTransition(fadeWithDuration: 0.3)
        CCDirector.sharedDirector().presentScene(scene, withTransition: transition)
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
        
        var longPress = UILongPressGestureRecognizer(target: self, action: "longPress")
        longPress.minimumPressDuration = 0.20
        CCDirector.sharedDirector().view.addGestureRecognizer(longPress)
    }
    
    func swipeLeft() {
        if player.position.x > 0.20 {
            player.position = ccp(player.position.x - 0.20, player.position.y)
        }
    }
    
    func swipeRight() {
        if player.position.x < 0.80 {
            player.position = ccp(player.position.x + 0.20, player.position.y)
        }
    }
    
    func swipeUp() {
        if player.position.y < 0.55 {
            player.position = ccp(player.position.x, player.position.y + 0.10)
        }
    }
    
    func swipeDown() {
        if player.position.y > 0.25 {
            player.position = ccp(player.position.x, player.position.y - 0.10)
        }
    }
    
    func longPress() {
        player.position.y = 0.25
    }
    
    func disableGestures() {
        if let recognizers = CCDirector.sharedDirector().view.gestureRecognizers {
            for recognizer in recognizers {
                CCDirector.sharedDirector().view.removeGestureRecognizer(recognizer as! UIGestureRecognizer)
            }
        }
    }
    
    func startObstacles() {
        self.schedule("fallingRocks", interval: rockDelay)
        self.schedule("flyingBirds", interval: birdDelay)
    }
    
    func fallingRocks() {
        var rock = CCBReader.load("Rock") as! Rock
        rock.scale = 3.0
        rock.positionType = CCPositionType(xUnit: .Normalized, yUnit: .Normalized, corner: .BottomLeft)
        gamePhysicsNode.addChild(rock)
        
        var randomPosition = CCRANDOM_0_1() * 6
        switch randomPosition {
        case 0..<2.1:
            rock.position = ccp(player.position.x, 1.1)
        case 2.1..<4.2:
            rock.position = ccp(player.position.x, 1.1)
        default:
            if randomPosition < 4.56 {
                rock.position = ccp(0.1, 1.1)
            } else if randomPosition < 4.92 {
                rock.position = ccp(0.3, 1.1)
            } else if randomPosition < 5.28 {
                rock.position = ccp(0.5, 1.1)
            } else if randomPosition < 5.64 {
                rock.position = ccp(0.7, 1.1)
            } else {
                rock.position = ccp(0.9, 1.1)
            }
        }
        
        var randomGravity = CCRANDOM_0_1() * 6
        switch randomGravity {
        case 0..<1:
            rock.physicsBody.applyImpulse(ccp(0, CGFloat(rockGravity[0])))
        case 1..<2:
            rock.physicsBody.applyImpulse(ccp(0, CGFloat(rockGravity[1])))
        case 2..<3:
            rock.physicsBody.applyImpulse(ccp(0, CGFloat(rockGravity[2])))
        case 3..<4:
            rock.physicsBody.applyImpulse(ccp(0, CGFloat(rockGravity[3])))
        case 4..<5:
            rock.physicsBody.applyImpulse(ccp(0, CGFloat(rockGravity[4])))
        default:
            rock.physicsBody.applyImpulse(ccp(0, CGFloat(rockGravity[5])))
        }
    }
    
    func flyingBirds() {
        var bird = CCBReader.load("Bird") as! Bird
        bird.positionType = CCPositionType(xUnit: .Normalized, yUnit: .Normalized, corner: .BottomLeft)
        gamePhysicsNode.addChild(bird)
        
        var randomPosition = CCRANDOM_0_1() * 10
        switch randomPosition {
        case 0..<3.5:
            bird.position = ccp(1.1, player.position.y)
            bird.flipX = true
        case 3.5..<7:
            bird.position = ccp(-0.1, player.position.y)
        default:
            if randomPosition < 7.375 {
                bird.position = ccp(1.1, 0.25)
                bird.flipX = true
            } else if randomPosition < 7.75 {
                bird.position = ccp(1.1, 0.35)
                bird.flipX = true
            } else if randomPosition < 8.125 {
                bird.position = ccp(1.1, 0.45)
                bird.flipX = true
            } else if randomPosition < 8.5 {
                bird.position = ccp(1.1, 0.55)
                bird.flipX = true
            } else if randomPosition < 8.875 {
                bird.position = ccp(-0.1, 0.55)
            } else if randomPosition < 9.25 {
                bird.position = ccp(-0.1, 0.35)
            } else if randomPosition < 9.625 {
                bird.position = ccp(-0.1, 0.45)
            } else {
                bird.position = ccp(-0.1, 0.25)
            }
        }
        
        var randomSpeed = CCRANDOM_0_1() * 3
        switch randomSpeed {
        case 0..<1:
            if bird.flipX == true {
                bird.physicsBody.applyImpulse(ccp(CGFloat(-birdImpulse[0]), 0))
            } else {
                bird.physicsBody.applyImpulse(ccp(CGFloat(birdImpulse[0]), 0))
            }
        case 1..<2:
            if bird.flipX == true {
                bird.physicsBody.applyImpulse(ccp(CGFloat(-birdImpulse[1]), 0))
            } else {
                bird.physicsBody.applyImpulse(ccp(CGFloat(birdImpulse[1]), 0))
            }
        default:
            if bird.flipX == true {
                bird.physicsBody.applyImpulse(ccp(CGFloat(-birdImpulse[2]), 0))
            } else {
                bird.physicsBody.applyImpulse(ccp(CGFloat(birdImpulse[2]), 0))
            }
        }
    }
    
    func startCoinsAndPowerups() {
        self.schedule("generateCoins", interval: coinDelay)
    }
    
    func generateCoins() {
        var coin = CCBReader.load("Coin") as! Coin
        coin.scale = 0.5
        coin.positionType = CCPositionType(xUnit: .Normalized, yUnit: .Normalized, corner: .BottomLeft)
        gamePhysicsNode.addChild(coin)
        coin.position = ccp(0.7, 0.55)
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, obstacle one: CCNode!, obstacle two: CCNode!) -> Bool {
        return false
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, obstacle: CCNode!, coin: CCNode!) -> Bool {
        return false
    }
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, playerC: CCNode!, coin: Coin!) {
        coin.removeFromParent()
        score += 3
    }
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, remove: CCNode!, obstacle: CCNode!) {
        obstacle.removeFromParent()
        if gameState != .Playing {
            return
        }
        score++
    }
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, playerC: CCNode!, obstacle: CCSprite!) {
        obstacle.removeFromParent()
        triggerGameOver()
    }
    
    func triggerGameOver() {
        gameState = .GameOver
        var gameOver = CCBReader.load("GameOver", owner: self) as! GameOver
        gameOver.setLastScore(score)
        self.addChild(gameOver)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var highScore = defaults.integerForKey("highScore")
        if self.score > highScore {
            defaults.setInteger(Int(self.score), forKey: "highScore")
        }
    }
}