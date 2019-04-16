//
//  GameOverScene.swift
//  Swift_Rift
//
//  Created by Erhan Ulusal on 06/04/2019.
//  Copyright © 2019 Erhan Ulusal. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    
    var starback:SKEmitterNode!
    
    var title:SKSpriteNode!
    
    var winLabel:SKLabelNode!
    
    var scoreLabel:SKLabelNode!
    var score:Int!
    
    var playAgainButton:SKSpriteNode!
    var selectDiffButton:SKSpriteNode!
    var menuButton:SKSpriteNode!
    
    var playAgainLabel:SKLabelNode!
    var selectDiffLabel:SKLabelNode!
    var menuLabel:SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        starback = (self.childNode(withName: "starback") as! SKEmitterNode)
        starback.advanceSimulationTime(10)
        
        title = (self.childNode(withName: "gameOver") as! SKSpriteNode)
        
        winLabel = (self.childNode(withName: "winLabel") as! SKLabelNode)
        
        scoreLabel = (self.childNode(withName: "scoreLabel") as! SKLabelNode)
        score = GameScene.scoreTransfer
        scoreLabel.text = "SCORE: \(score ?? 0)"
        
        playAgainButton = (self.childNode(withName: "playAgainButton") as! SKSpriteNode)
        selectDiffButton = (self.childNode(withName: "selectDiffButton") as! SKSpriteNode)
        menuButton = (self.childNode(withName: "menuButton") as! SKSpriteNode)
        
        playAgainLabel = (self.childNode(withName: "playAgainLabel") as! SKLabelNode)
        selectDiffLabel = (self.childNode(withName: "selectDiffLabel") as! SKLabelNode)
        menuLabel = (self.childNode(withName: "menuLabel") as! SKLabelNode)
        
        if GameScene.didWin {
            winLabel.text = "YOU WIN"
            winLabel.fontColor = UIColor.green
            
            if UserDefaults.standard.integer(forKey: "highscore") < score {
                UserDefaults.standard.set(score, forKey: "highscore")
            }
            
        }
        else {
            winLabel.text = "YOU LOSE"
            winLabel.fontColor = UIColor.red
        }
    }
    
    
    func replay() {
        let trans = SKTransition.crossFade(withDuration: 0.2)
        let gameScreen = GameScene(fileNamed: "GameScene")
        gameScreen?.scaleMode = SKSceneScaleMode.resizeFill
        self.view?.presentScene(gameScreen!, transition: trans)
    }
    
    func gotoDiff() {
        let trans = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
        let diffScene = SelectDiffScene(fileNamed: "SelectDiffScene")
        diffScene?.scaleMode = SKSceneScaleMode.resizeFill
        self.view?.presentScene(diffScene!, transition: trans)
    }
    
    func gotoMenu() {
        let trans = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
        let menuScene = MenuScene(fileNamed: "MenuScene")
        menuScene?.scaleMode = SKSceneScaleMode.resizeFill
        self.view?.presentScene(menuScene!, transition: trans)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        
        if let location = touch?.location(in: self){
            let nodes = self.nodes(at: location)
            
            if nodes.first?.name == "playAgainButton" || nodes.first?.name == "playAgainLabel" {
                replay()
            }
            
            else if nodes.first?.name == "selectDiffButton" || nodes.first?.name == "selectDiffLabel" {
                gotoDiff()
            }
            
            else if nodes.first?.name == "menuButton" || nodes.first?.name == "menuLabel" {
                gotoMenu()
            }
            
    }


}

}
