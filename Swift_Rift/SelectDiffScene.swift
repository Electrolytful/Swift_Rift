//
//  SelectDiffScene.swift
//  Swift_Rift
//
//  Created by Erhan Ulusal on 28/02/2019.
//  Copyright © 2019 Erhan Ulusal. All rights reserved.
//

import UIKit
import SpriteKit

class SelectDiffScene: SKScene {
    
    //variable for heading
    var title:SKSpriteNode!
    
    //variable for animated background
    var starbg:SKEmitterNode!
    
    //variables for back button
    var backButton:SKSpriteNode!
    var back:SKLabelNode!
    
    //variables for difficulty selection buttons
    var easyButton:SKSpriteNode!
    var mediumButton:SKSpriteNode!
    var hardButton:SKSpriteNode!
    var insaneButton:SKSpriteNode!

    var easyLabel:SKLabelNode!
    var mediumLabel:SKLabelNode!
    var hardLabel:SKLabelNode!
    var insaneLabel:SKLabelNode!
    
    //variable for spaceship avatar
    var player:SKSpriteNode!
    
    //variable for storing the current difficulty selection as a string to compare in the game scene
    static var diff:String!
    
    
    override func didMove(to view: SKView) {
        
        //assigning corresponding assets to the variables declared above
        title = (self.childNode(withName: "selectDiff") as! SKSpriteNode)
        
        starbg = (self.childNode(withName: "starBack") as! SKEmitterNode)
        starbg.advanceSimulationTime(10)
        
        backButton = (self.childNode(withName: "backButton") as! SKSpriteNode)
        back = (self.childNode(withName: "back") as! SKLabelNode)
        
        easyButton = (self.childNode(withName: "easyButton") as! SKSpriteNode)
        mediumButton = (self.childNode(withName: "mediumButton") as! SKSpriteNode)
        hardButton = (self.childNode(withName: "hardButton") as! SKSpriteNode)
        insaneButton = (self.childNode(withName: "insaneButton") as! SKSpriteNode)
        
        easyLabel = (self.childNode(withName: "easyLabel") as! SKLabelNode)
        mediumLabel = (self.childNode(withName: "mediumLabel") as! SKLabelNode)
        hardLabel = (self.childNode(withName: "hardLabel") as! SKLabelNode)
        insaneLabel = (self.childNode(withName: "insaneLabel") as! SKLabelNode)
        
        player = (self.childNode(withName: "player") as! SKSpriteNode)
        
        
    }
    
    //checking whether back button is pressed to return to the main menu screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        
        if let location = touch?.location(in: self){
            let nodes = self.nodes(at: location)
            
            
            if nodes.first?.name == "easyButton" || nodes.first?.name == "easyLabel" {
                SelectDiffScene.diff = "easy"
                
                let trans = SKTransition.crossFade(withDuration: 1)
                let gameScreen = GameScene(fileNamed: "GameScene")
                gameScreen?.scaleMode = SKSceneScaleMode.resizeFill
                self.view?.presentScene(gameScreen!, transition: trans)
            }
            
            if nodes.first?.name == "mediumButton" || nodes.first?.name == "mediumLabel" {
                SelectDiffScene.diff = "medium"
                
                let trans = SKTransition.crossFade(withDuration: 1)
                let gameScreen = GameScene(fileNamed: "GameScene")
                gameScreen?.scaleMode = SKSceneScaleMode.resizeFill
                self.view?.presentScene(gameScreen!, transition: trans)
            }
            
            if nodes.first?.name == "hardButton" || nodes.first?.name == "hardLabel" {
                SelectDiffScene.diff = "hard"
                
                let trans = SKTransition.crossFade(withDuration: 1)
                let gameScreen = GameScene(fileNamed: "GameScene")
                gameScreen?.scaleMode = SKSceneScaleMode.resizeFill
                self.view?.presentScene(gameScreen!, transition: trans)
            }
            
            if nodes.first?.name == "insaneButton" || nodes.first?.name == "insaneLabel" {
                SelectDiffScene.diff = "insane"
                
                let trans = SKTransition.crossFade(withDuration: 1)
                let gameScreen = GameScene(fileNamed: "GameScene")
                gameScreen?.scaleMode = SKSceneScaleMode.resizeFill
                self.view?.presentScene(gameScreen!, transition: trans)
            }
            
            
            if nodes.first?.name == "backButton" || nodes.first?.name == "back" {
                let trans = SKTransition.doorsCloseHorizontal(withDuration: 0.5)
                let menuScreen = MenuScene(fileNamed: "MenuScene")
                menuScreen?.scaleMode = SKSceneScaleMode.resizeFill
                self.view?.presentScene(menuScreen!, transition: trans)
            }
        }
        
    }
    
    

}
