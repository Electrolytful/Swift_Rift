//
//  MenuScene.swift
//  Swift_Rift
//
//  Created by Erhan Ulusal on 26/02/2019.
//  Copyright © 2019 Erhan Ulusal. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class MenuScene: SKScene {
    
    //declaring variables for assest within the menu scene as shown in MenuScene.sks
    var starbg:SKEmitterNode!
    
    var playButton:SKSpriteNode!
    var instructButton:SKSpriteNode!
    var quitButton:SKSpriteNode!
    var creditButton:SKSpriteNode!
    
    var highscoreLabel:SKLabelNode!
    var score:SKLabelNode!
    
    //declaring an audio player
    var audioPlayer:AVAudioPlayer!
    
    override func didMove(to view: SKView) {
        
        //assigning varibales above with the linking assets in MenuScene.sks
        starbg = (self.childNode(withName: "starBack") as! SKEmitterNode)
        starbg.advanceSimulationTime(10)
        
        playButton = (self.childNode(withName: "playButton") as! SKSpriteNode)
        instructButton = (self.childNode(withName: "instructionsButton") as! SKSpriteNode)
        quitButton = (self.childNode(withName: "quitButton") as! SKSpriteNode)
        creditButton = (self.childNode(withName: "creditsButton") as! SKSpriteNode)
        
        highscoreLabel = (self.childNode(withName: "highscore") as! SKLabelNode)
        score = (self.childNode(withName: "score") as! SKLabelNode)
        
        //initial value of highscore set to 0
        score.text = "0"
        
        //creating an audio player to play a sound effect when button is pressed, could return an error
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "explosion", ofType: "mp3")!))
        }
        catch{
            print(error)
        }
        
    }
    
    //method to detect touch and check whether a button is pressed and the corresponding scene is opened
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodes = self.nodes(at: location)
            
            if nodes.first?.name == "playButton" || nodes.first?.name == "playLabel" {
                let trans = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                let diffScene = SelectDiffScene(fileNamed: "SelectDiffScene")
                diffScene?.scaleMode = .aspectFit
                playSound()
                self.view?.presentScene(diffScene!, transition: trans)
            }
            
            else if nodes.first?.name == "instructionsButton" || nodes.first?.name == "instructLabel" {
                let trans = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                let insScene = InstructionScene(fileNamed: "InstructionScene")
                insScene?.scaleMode = .aspectFit
                playSound()
                self.view?.presentScene(insScene!, transition: trans)
            }
            
            else if nodes.first?.name == "creditsButton" || nodes.first?.name == "creditsLabel" {
                let trans = SKTransition.doorsOpenHorizontal(withDuration: 0.5)
                let credScene = CreditScene(fileNamed: "CreditScene")
                credScene?.scaleMode = .aspectFit
                playSound()
                self.view?.presentScene(credScene!, transition: trans)
            }
            
            else if nodes.first?.name == "quitButton" || nodes.first?.name == "quitLabel" {
                exit(0)
            }
        }
        
        
    }
    
    //function that is called to play the sound effect for the buttons
    func playSound(){
        audioPlayer.play()
    }
    

    
    

}
