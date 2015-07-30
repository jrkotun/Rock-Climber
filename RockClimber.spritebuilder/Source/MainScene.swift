import Foundation

enum GameState {
    case Title, Store, Ready, Playing, Paused, Magnet, Armor, Golden, GameOver
}

enum Level {
    case Level1, Level2, Level3, Level4, Level5, LastLevel
}

class MainScene: CCNode, CCPhysicsCollisionDelegate {
    weak var mainScene: CCNode!
    weak var background1: CCNode!
    weak var background2: CCNode!
    weak var background3: CCNode!
    weak var leftRope1: CCNode!
    weak var leftRope2: CCNode!
    weak var leftOfMiddleRope1: CCNode!
    weak var leftOfMiddleRope2: CCNode!
    weak var middleRope1: CCNode!
    weak var middleRope2: CCNode!
    weak var rightOfMiddleRope1: CCNode!
    weak var rightOfMiddleRope2: CCNode!
    weak var rightRope1: CCNode!
    weak var rightRope2: CCNode!
    weak var gamePhysicsNode: CCPhysicsNode!
    weak var swipeIndicators: CCNode!
    weak var pauseScreen: CCNode!
    weak var scoreLabel: CCLabelTTF!
    weak var coinCountNode: CCNode!
    weak var coinLabel: CCLabelTTF!
    weak var movementRange: CCNodeGradient!
    var gameState: GameState = .Title
    var level: Level = .Level1
    var player = CCBReader.load("Player") as! Player
    var coinArray: [Coin] = []
    var scroller = 0
    var rockDelay = 4.0
    var birdDelay = 5.0
    var scrollSpeed: CGFloat = 0.0025
    var rockImpulse = [-200, -175, -150]
    var birdImpulse = [200, 150, 100]
    var leftMovementLimit: CGFloat = 0.20
    var rightMovementLimit: CGFloat = 0.80
    var tempGameState: GameState!
    var score = 0.0
    var modifier = 1.0
    var coinCount = 0
    var coinActivator = 0
    var obstacleActivator = 0
    var trigger = 0
    var magnetSpeed: CGFloat = 3.0
    var magnetPowerUpDuration = 10.0
    var armorPowerUpDuration = 10.0
    var goldenPowerUpDuration = 7.0
    
    func didLoadFromCCB() {
        userInteractionEnabled = true
        gamePhysicsNode.collisionDelegate = self
        loadPlayer()
        //gamePhysicsNode.debugDraw = true
    }
    
    func loadPlayer() {
        player.positionType = CCPositionType(xUnit: .Normalized, yUnit: .Normalized, corner: .BottomLeft)
        
        //let rectangle = CGRect(x: player.anchorPoint.x + 12, y: player.anchorPoint.y, width: player.contentSize.width * 0.53, height: player.contentSize.height)
        
        gamePhysicsNode.addChild(player)
        //player.physicsBody = CCPhysicsBody(polylineFromRect: rectangle, cornerRadius: 2)
        //player.physicsBody.type = .Static
        //player.physicsBody.collisionType = "playerC"
        player.position = ccp(0.5, 0.45)
    }

    override func update(delta: CCTime) {
        backgroundMovement()
        if gameState == .Playing || gameState == .Magnet || gameState == .Armor || gameState == .Golden {
            score = score + modifier
            scoreLabel.string = "\(Int(score))"
            coinLabel.string = "\(coinCount)"
            if coinActivator == 5 {
                spawnCoins()
                coinActivator = 0
            } else if obstacleActivator == 8 {
                spawnPowerUps()
                obstacleActivator = 0
            }
        }
        
        if gameState == .Magnet {
            for coin in coinArray {
                var scaleX: CGFloat = 1
                var scaleY: CGFloat = 1
                var positionX = (player.position.x - coin.position.x) * 100
                var positionY = (player.position.y - coin.position.y) * 100
                
                if positionX > 0 {
                    scaleX = magnetSpeed
                } else {
                    scaleX = -magnetSpeed
                }
                
                if positionY > 0 {
                    scaleY = magnetSpeed
                } else {
                    scaleY = -magnetSpeed
                }
                
                var angle = atan2(positionY, positionX)
                coin.physicsBody.affectedByGravity = false
                coin.physicsBody.velocity = ccp(scaleX * positionX * cos(angle), scaleY * positionY * sin(angle))
            }
        }
        
        if score > 2000 && gameState == .Playing && level == .Level1 {
            rockDelay = 3.0
            birdDelay = 4.0
            rockImpulse = [-300, -275, -250]
            birdImpulse = [200, 150, 100]
            scrollSpeed = 0.005
            gamePhysicsNode.gravity.y = -75.00
            level = .Level2
            modifier++
        } else if score > 5000 && gameState == .Playing && level == .Level2 {
            rockDelay = 2.0
            birdDelay = 3.0
            rockImpulse = [-400, -375, -350]
            birdImpulse = [300, 250, 200]
            scrollSpeed = 0.0075
            gamePhysicsNode.gravity.y = -100.00
            level = .Level3
            modifier++
        } else if score > 10000 && gameState == .Playing && level == .Level3 {
            birdDelay = 2.0
            rockImpulse = [-500, -475, -450]
            birdImpulse = [300, 250, 200]
            scrollSpeed = 0.01
            gamePhysicsNode.gravity.y = -150.00
            level = .Level4
            modifier++
        } else if score > 15000 && gameState == .Playing && level == .Level4 && player.position.x > 0.2 {
            leftRope1.physicsBody.affectedByGravity = true
            leftRope2.physicsBody.affectedByGravity = true
            leftMovementLimit = 0.4
            level = .Level5
            modifier++
        } else if score > 20000 && gameState == .Playing && level == .Level5 && player.position.x < 0.8 {
            rightRope1.physicsBody.affectedByGravity = true
            rightRope2.physicsBody.affectedByGravity = true
            rightMovementLimit = 0.6
            level = .LastLevel
            modifier++
        } else {
            return
        }
    }
    
    func backgroundMovement() {
        
        background1.position.y -= scrollSpeed
        background2.position.y -= scrollSpeed
        background3.position.y -= scrollSpeed
        
        leftRope1.position.y -= scrollSpeed
        leftRope2.position.y -= scrollSpeed
        
        leftOfMiddleRope1.position.y -= scrollSpeed
        leftOfMiddleRope2.position.y -= scrollSpeed
        
        middleRope1.position.y -= scrollSpeed
        middleRope2.position.y -= scrollSpeed
        
        rightOfMiddleRope1.position.y -= scrollSpeed
        rightOfMiddleRope2.position.y -= scrollSpeed
        
        rightRope1.position.y -= scrollSpeed
        rightRope2.position.y -= scrollSpeed
        
        if background1.position.y <= -0.33 && scroller == 2 {
            background3.position.y = 1.563
            scroller = 0
        }
        if background2.position.y <= -0.33 && scroller == 0 {
            background1.position.y = 1.563
            scroller = 1
        }
        if background3.position.y <= -0.33 && scroller == 1 {
            background2.position.y = 1.563
            scroller = 2
        }
        
        if (leftRope1.position.y + 1) < mainScene.position.y {
            leftRope1.position.y = 1
        }
        if (leftRope2.position.y + 1) < mainScene.position.y {
            leftRope2.position.y = 1
        }
        
        if (leftOfMiddleRope1.position.y + 1) < mainScene.position.y {
            leftOfMiddleRope1.position.y = 1
        }
        if (leftOfMiddleRope2.position.y + 1) < mainScene.position.y {
            leftOfMiddleRope2.position.y = 1
        }
        
        if (middleRope1.position.y + 1) < mainScene.position.y {
            middleRope1.position.y = 1
        }
        if (middleRope2.position.y + 1) < mainScene.position.y {
            middleRope2.position.y = 1
        }
        
        if (rightOfMiddleRope1.position.y + 1) < mainScene.position.y {
            rightOfMiddleRope1.position.y = 1
        }
        if (rightOfMiddleRope2.position.y + 1) < mainScene.position.y {
            rightOfMiddleRope2.position.y = 1
        }
        
        if (rightRope1.position.y + 1) < mainScene.position.y {
            rightRope1.position.y = 1
        }
        if (rightRope2.position.y + 1) < mainScene.position.y {
            rightRope2.position.y = 1
        }
    }
    
    func store() {
        var store = CCBReader.load("Store") as! Store
        var scene = CCScene()
        scene.addChild(store)
        var transition = CCTransition(fadeWithDuration: 0.3)
        CCDirector.sharedDirector().presentScene(scene, withTransition: transition)
    }
    
    func ready() {
        swipeIndicators.visible = true
        movementRange.visible = true
        gameState = .Ready
        self.animationManager.runAnimationsForSequenceNamed("Ready")
        setupGestures()
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        if gameState == .GameOver || gameState == .Title || gameState == .Paused {
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
        scoreLabel.visible = true
        coinCountNode.visible = true
        startObstacles()
    }
    
    func resume() {
        gameState = tempGameState
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
        
        var doubleTap = UITapGestureRecognizer(target: self, action: "pause")
        doubleTap.numberOfTapsRequired = 2
        CCDirector.sharedDirector().view.addGestureRecognizer(doubleTap)
    }
    
    func swipeLeft() {
        if player.position.x > leftMovementLimit {
            player.position = ccp(player.position.x - 0.20, player.position.y)
        }
    }
    
    func swipeRight() {
        if player.position.x < rightMovementLimit {
            player.position = ccp(player.position.x + 0.20, player.position.y)
        }
    }
    
    func swipeUp() {
        if player.position.y < 0.54 {
            player.position = ccp(player.position.x, player.position.y + 0.10)
        }
    }
    
    func swipeDown() {
        if player.position.y > 0.26 {
            player.position = ccp(player.position.x, player.position.y - 0.10)
        }
    }
    
    func pause() {
        if gameState == .Playing || gameState == .Magnet || gameState == .Armor || gameState == .Golden {
            tempGameState = gameState
            gameState = .Paused
            pauseScreen.visible = true
            mainScene.paused = true
            disableGestures()
        }
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
        gamePhysicsNode.addChild(rock)
        rock.scale = 3.0
        rock.positionType = CCPositionType(xUnit: .Normalized, yUnit: .Normalized, corner: .BottomLeft)
        
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
        
        var randomImpulse = CCRANDOM_0_1() * 3
        switch randomImpulse {
        case 0..<1:
            rock.physicsBody.applyImpulse(ccp(0, CGFloat(rockImpulse[0])))
        case 1..<2:
            rock.physicsBody.applyImpulse(ccp(0, CGFloat(rockImpulse[1])))
        default:
            rock.physicsBody.applyImpulse(ccp(0, CGFloat(rockImpulse[2])))
        }
    }
    
    func flyingBirds() {
        var bird = CCBReader.load("Bird") as! Bird
        gamePhysicsNode.addChild(bird)
        bird.positionType = CCPositionType(xUnit: .Normalized, yUnit: .Normalized, corner: .BottomLeft)
        
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
    
    func spawnCoins() {
        coinArray.removeAll()
        var coinColumn: Int = 0
        var xSetOff: CGFloat = 0.0
        var ySetOff: CGFloat = 0.0
        
        for (var i = 0; i < 5; i++) {
            
            if trigger == 4 {
                xSetOff = 0.3
                coinColumn = 4
            } else if trigger >= 5 {
                xSetOff = 0.3
                coinColumn = 3
            } else {
                xSetOff = 0.1
                coinColumn = 5
            }
            
            for (var j = 0; j < coinColumn; j++) {
                var coin = CCBReader.load("Coin") as! Coin
                coin.scale = 0.5
                coin.positionType = CCPositionType(xUnit: .Normalized, yUnit: .Normalized, corner: .BottomLeft)
                gamePhysicsNode.addChild(coin)
                coin.position = ccp(xSetOff, 1.1 + ySetOff)
                xSetOff += 0.2
                coinArray.append(coin)
            }
            ySetOff += 0.1
        }
    }
    
    func spawnPowerUps() {
        var random = CCRANDOM_0_1() * 10
        var randomPosition = CCRANDOM_0_1() * 3
        switch random {
        case 0..<4:
            var magnet = CCBReader.load("MagnetPowerUp") as! MagnetPowerUp
            magnet.scale = 0.5
            magnet.positionType = CCPositionType(xUnit: .Normalized, yUnit: .Normalized, corner: .BottomLeft)
            gamePhysicsNode.addChild(magnet)
            switch randomPosition {
            case 0..<1:
                magnet.position = ccp(0.3, 1.1)
            case 1..<2:
                magnet.position = ccp(0.5, 1.1)
            default:
                magnet.position = ccp(0.7, 1.1)
            }
        case 4..<8:
            var armor = CCBReader.load("ArmorPowerUp") as! ArmorPowerUp
            armor.scale = 0.5
            armor.positionType = CCPositionType(xUnit: .Normalized, yUnit: .Normalized, corner: .BottomLeft)
            gamePhysicsNode.addChild(armor)
            switch randomPosition {
            case 0..<1:
                armor.position = ccp(0.3, 1.1)
            case 1..<2:
                armor.position = ccp(0.5, 1.1)
            default:
                armor.position = ccp(0.7, 1.1)
            }
        default:
            var golden = CCBReader.load("GoldenPowerUp") as! GoldenPowerUp
            golden.scale = 0.5
            golden.positionType = CCPositionType(xUnit: .Normalized, yUnit: .Normalized, corner: .BottomLeft)
            gamePhysicsNode.addChild(golden)
            switch randomPosition {
            case 0..<1:
                golden.position = ccp(0.3, 1.1)
            case 1..<2:
                golden.position = ccp(0.5, 1.1)
            default:
                golden.position = ccp(0.7, 1.1)
            }
        }
    }
    
    func postArmorPowerUp() {
        player.armorRunningOut()
        self.scheduleOnce("postPowerUp", delay: 3)
    }
    
    func postMagnetPowerUp() {
        player.magnetRunningOut()
        self.scheduleOnce("postPowerUp", delay: 3)
    }
    
    func postGoldenPowerUp() {
        player.goldenRunningOut()
        self.scheduleOnce("postPowerUp", delay: 3)
    }
    
    func postPowerUp() {
        if gameState == .Armor {
            modifier = modifier * 2
            scrollSpeed = scrollSpeed * 2
        }
        
        if gameState == .Golden {
            modifier = modifier / 3
            scrollSpeed = scrollSpeed / 3
        }
        gameState = .Playing
        player.defaultClimber()
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, coin: Coin!, armor: ArmorPowerUp!) -> Bool {
        return false
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, coin one: CCNode!, coin two: CCNode!) -> Bool {
        return false
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, coin: Coin!, golden: GoldenPowerUp!) -> Bool {
        return false
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, coin: Coin!, magnet: MagnetPowerUp!) -> Bool {
        return false
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, obstacle: CCNode!, armor: ArmorPowerUp!) -> Bool {
        return false
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, obstacle: CCNode!, coin: Coin!) -> Bool {
        return false
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, obstacle: CCNode!, golden: GoldenPowerUp!) -> Bool {
        return false
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, obstacle: CCNode!, magnet: MagnetPowerUp!) -> Bool {
        return false
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, obstacle one: CCNode!, obstacle two: CCNode!) -> Bool {
        return false
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, playerC: Player!, armor: ArmorPowerUp!) -> Bool {
        if gameState == .Playing || gameState == .Magnet || gameState == .Armor {
            gameState = .Armor
            armor.removeFromParent()
            score += 20
            modifier = modifier / 2
            scrollSpeed = scrollSpeed / 2
            player.armorPowerUp()
            self.scheduleOnce("postArmorPowerUp", delay: armorPowerUpDuration - 3)
            return true
        } else {
            return false
        }
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, playerC: Player!, obstacle: CCSprite!) -> Bool {
        if gameState == .Magnet {
            obstacle.removeFromParent()
            disableGestures()
            triggerGameOver()
            return true
        } else if gameState != .Playing {
            return false
        } else {
            obstacle.removeFromParent()
            disableGestures()
            triggerGameOver()
            return true
        }
    }
    
    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, rope: CCNode!, wildcard: CCNode!) -> Bool {
        return false
    }
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, playerC: Player!, coin: Coin!) {
        if gameState == .Playing || gameState == .Magnet || gameState == .Armor || gameState == .Golden {
            coin.coinRemoved(coin)
            score += 3
            coinCount++
        }
    }
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, playerC: Player!, golden: GoldenPowerUp!) {
        if gameState == .Playing || gameState == .Magnet || gameState == .Armor || gameState == .Golden {
            gameState = .Golden
            golden.removeFromParent()
            score += 20
            modifier = modifier * 3
            scrollSpeed = scrollSpeed * 3
            player.goldenPowerUp()
            self.scheduleOnce("postGoldenPowerUp", delay: goldenPowerUpDuration - 3)
        }
    }
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, playerC: Player!, magnet: MagnetPowerUp!) {
        if gameState == .Playing || gameState == .Magnet || gameState == .Armor || gameState == .Golden {
            gameState = .Magnet
            magnet.removeFromParent()
            player.magnetPowerUp()
            self.scheduleOnce("postMagnetPowerUp", delay: magnetPowerUpDuration - 3)
        }
    }
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, remove: CCNode!, armor: ArmorPowerUp!) {
        armor.removeFromParent()
    }
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, remove: CCNode!, coin: Coin!) {
        coin.removeFromParent()
    }
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, remove: CCNode!, golden: GoldenPowerUp!) {
        golden.removeFromParent()
    }
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, remove: CCNode!, magnet: MagnetPowerUp!) {
        magnet.removeFromParent()
    }
    
    func ccPhysicsCollisionPostSolve(pair: CCPhysicsCollisionPair!, remove: CCNode!, obstacle: CCNode!) {
        obstacle.removeFromParent()
        coinActivator++
        obstacleActivator++
    }
    
    func triggerGameOver() {
        gameState = .GameOver
        var gameOver = CCBReader.load("GameOver", owner: self) as! GameOver
        gameOver.setLastScore(Int(score))
        gameOver.setCoinCollected(coinCount)
        self.addChild(gameOver)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var highScore = defaults.integerForKey("highScore")
        if Int(self.score) > highScore {
            defaults.setInteger(Int(self.score), forKey: "highScore")
        }
        
        var totalCoins = defaults.integerForKey("totalCoins")
        totalCoins += coinCount
        defaults.setInteger(totalCoins, forKey: "totalCoins")
    }
}