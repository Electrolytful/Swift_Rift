//
//  GameScene.swift
//  Swift_Rift
//
//  Created by Erhan Ulusal on 17/03/2019.
//  Copyright © 2019 Erhan Ulusal. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {

    var starback:SKEmitterNode!
    var player:SKSpriteNode!
    var scoreLabel:SKLabelNode!
    var lifeLabel:SKLabelNode!
    var score:Int = 0 {
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    var life:Int = 3{
        didSet{
        lifeLabel.text = "Lives: \(life)"
        }
    }
    
    static var didWin:Bool!
    static var scoreTransfer:Int!
    
    //variables that are changed depending on difficulty selected in previous scene
    var gameDuration:Int!
    var invaderDuration:Int!
    var invaderInterval:Int!
    
    //specifying variable timers for the spawning invaders and the game duration
    var invaderTimer:Timer!
    var gameTimer:Timer!
    
    //variables for the live countdown timer during level
    var timeLabel:SKLabelNode!
    var count:Int!
    var countdownTimer:Timer!
    
    //specifying variable identifiers for the invaders category and the laser beam category to be used in bitmasks
    let invaderID:UInt32 = 0x1 << 1
    let laserBeamID:UInt32 = 0x1 << 0
    
    //creating a motion manager and a variable to hold the x axis acceleration of the player
    let motionManager = CMMotionManager()
    var xAccel:CGFloat = 0
    
    //function that runs when this scene is called
    override func didMove(to view: SKView) {
        
        //changing duration of game and speed of invaders depending on difficulty currently selected
        if SelectDiffScene.diff == "easy" {
            gameDuration = 30
            count = 30
            invaderDuration = 5
            invaderInterval = 2
        }
        else if SelectDiffScene.diff == "medium" {
            gameDuration = 40
            count = 40
            invaderDuration = 3
            invaderInterval = 2
        }
        else if SelectDiffScene.diff == "hard" {
            gameDuration = 50
            count = 50
            invaderDuration = 3
            invaderInterval = 1
        }
        else if SelectDiffScene.diff == "insane" {
            gameDuration = 60
            count = 60
            invaderDuration = 2
            invaderInterval = 1
        }
        
        GameScene.didWin = true
        
        starback = (self.childNode(withName: "starback") as! SKEmitterNode)
        starback.advanceSimulationTime(10)
        
        player = (self.childNode(withName: "player") as! SKSpriteNode)
        
        scoreLabel = (self.childNode(withName: "scoreLabel") as! SKLabelNode)
        
        lifeLabel = (self.childNode(withName: "lifeLabel") as! SKLabelNode)
        
        timeLabel = (self.childNode(withName: "timeLabel") as! SKLabelNode)
        
        //removing gravity from the scene
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        gameTimer = Timer.scheduledTimer(timeInterval: TimeInterval(gameDuration), target: self, selector: #selector(gotoGameOver), userInfo: nil, repeats: false)
        
        
        invaderTimer = Timer.scheduledTimer(timeInterval: TimeInterval(invaderInterval), target: self, selector: #selector(addInvader), userInfo: nil, repeats: true)
        
        
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data:CMAccelerometerData?, error:Error?) in
            if let accelerometerData = data {
                let acceleration = accelerometerData.acceleration
                self.xAccel = CGFloat(acceleration.x) * 0.85 + self.xAccel * 0.50
            }
            
        }
        
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        fireLaser()
        
    }
    
    
    @objc func updateTimer() {
        if count > 0 {
            count = count - 1
            timeLabel.text = "Time: \(count ?? 0)"
        }
    }
    
    //function to generate invaders which move from top to bottom of the screen with a specific time interval
    @objc func addInvader() {
        
        let invader = SKSpriteNode(imageNamed: "invader.png")
        
        let generatePosition = GKRandomDistribution(lowestValue: -200, highestValue: 200)
        let position = CGFloat(generatePosition.nextInt())
        
        invader.size = CGSize(width: CGFloat(100), height: CGFloat(100))
        invader.position = CGPoint(x: position, y: self.frame.size.height + invader.size.height)
        
        invader.physicsBody = SKPhysicsBody(rectangleOf: invader.size)
        invader.physicsBody?.isDynamic = true
        
        invader.physicsBody?.categoryBitMask = invaderID
        invader.physicsBody?.contactTestBitMask = laserBeamID
        invader.physicsBody?.collisionBitMask = 0
        
        self.addChild(invader)
        
        let duration = invaderDuration
        
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: position, y: -self.frame.size.height + 350), duration: TimeInterval(duration!)))
        
        //if invader reaches bottom of screen and gets past player
        actionArray.append(SKAction.run {
            if self.life > 0 {
                self.life -= 1
            }
            
            if self.life == 0 {
                GameScene.didWin = false
                self.gotoGameOver()
            }
        })
        
        actionArray.append(SKAction.removeFromParent())
        
        invader.run(SKAction.sequence(actionArray))
        
    }
    
    func fireLaser() {
        
        self.run(SKAction.playSoundFileNamed("laser.mp3", waitForCompletion: false))
        
        let laser = SKSpriteNode(imageNamed: "laserbeam.png")
        
        laser.size = CGSize(width: CGFloat(50), height: CGFloat(20))
        laser.zRotation = .pi / 2
        laser.position = player.position
        laser.position.y += 5
        
        laser.physicsBody = SKPhysicsBody(circleOfRadius: laser.size.width / 2)
        laser.physicsBody?.isDynamic = true
        
        laser.physicsBody?.categoryBitMask = laserBeamID
        laser.physicsBody?.contactTestBitMask = invaderID
        laser.physicsBody?.collisionBitMask = 0
        laser.physicsBody?.usesPreciseCollisionDetection = true
        
        self.addChild(laser)
        
        let animationDuration:TimeInterval = 0.4
        
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: player.position.x, y: self.frame.size.height + 10), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        
        laser.run(SKAction.sequence(actionArray))
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody:SKPhysicsBody
        var secondBody:SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & laserBeamID) != 0 && (secondBody.categoryBitMask & invaderID) != 0 {
            laserCollideWithInvader(laser: firstBody.node as! SKSpriteNode, invader: secondBody.node as! SKSpriteNode)
        }
        
        
    }
    
    func laserCollideWithInvader(laser:SKSpriteNode, invader:SKSpriteNode) {
        
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        
        explosion.position = invader.position
        self.addChild(explosion)
        
        self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
        
        laser.removeFromParent()
        invader.removeFromParent()
        
        self.run(SKAction.wait(forDuration: 2)) {
            explosion.removeFromParent()
        }
        
        score += 100
    }
    
    override func didSimulatePhysics() {
        
        player.position.x += xAccel * 50
        
        if player.position.x < self.frame.minX {
            player.position = CGPoint(x: self.frame.minX, y: player.position.y)
        }
        else if player.position.x > self.frame.maxX {
            player.position = CGPoint(x: self.frame.maxX, y: player.position.y)
        }
        
    }
    
    
    @objc func gotoGameOver() {
        if GameScene.didWin {
            GameScene.scoreTransfer = score
        }
        else {
            GameScene.scoreTransfer = 0
        }
        
        let trans = SKTransition.crossFade(withDuration: 0.2)
        let gameOverScene = GameOverScene(fileNamed: "GameOverScene")
        gameOverScene?.scaleMode = SKSceneScaleMode.resizeFill
        self.view?.presentScene(gameOverScene!, transition: trans)
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    
    
    
}
