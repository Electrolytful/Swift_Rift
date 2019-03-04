//
//  InstructionScene.swift
//  Swift_Rift
//
//  Created by Erhan Ulusal on 27/02/2019.
//  Copyright © 2019 Erhan Ulusal. All rights reserved.
//

import UIKit
import SpriteKit

class InstructionScene: SKScene {
    
    //varibale for title label
    var title:SKLabelNode!
    
    //variables for description labels
    var desc1:SKLabelNode!
    var desc2:SKLabelNode!
    var desc3:SKLabelNode!
    var desc4:SKLabelNode!
    
    //variables for instruction labels
    var ins1:SKLabelNode!
    var ins2:SKLabelNode!
    var ins3:SKLabelNode!
    var ins3_2:SKLabelNode!
    var ins4:SKLabelNode!
    var ins4_2:SKLabelNode!
    
    //variables for ending description labels
    var endDesc:SKLabelNode!
    var endDesc_2:SKLabelNode!
    var endDesc_3:SKLabelNode!
    var endDesc_4:SKLabelNode!
    
    //varibales for ending labels
    var end:SKLabelNode!
    var end_2:SKLabelNode!
    
    //varibales for the back button
    var backButton:SKSpriteNode!
    var back:SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        //assigning linking assets in InstructionScene.sks to the varibales above
        title = (self.childNode(withName: "instructLabel") as! SKLabelNode)
        
        desc1 = (self.childNode(withName: "desc1") as! SKLabelNode)
        desc2 = (self.childNode(withName: "desc2") as! SKLabelNode)
        desc3 = (self.childNode(withName: "desc3") as! SKLabelNode)
        desc4 = (self.childNode(withName: "desc4") as! SKLabelNode)
        
        ins1 = (self.childNode(withName: "ins1") as! SKLabelNode)
        ins2 = (self.childNode(withName: "ins2") as! SKLabelNode)
        ins3 = (self.childNode(withName: "ins3") as! SKLabelNode)
        ins3_2 = (self.childNode(withName: "ins3_2") as! SKLabelNode)
        ins4 = (self.childNode(withName: "ins4") as! SKLabelNode)
        ins4_2 = (self.childNode(withName: "ins4_2") as! SKLabelNode)
        
        endDesc = (self.childNode(withName: "endDesc") as! SKLabelNode)
        endDesc_2 = (self.childNode(withName: "endDesc_2") as! SKLabelNode)
        endDesc_3 = (self.childNode(withName: "endDesc_3") as! SKLabelNode)
        endDesc_4 = (self.childNode(withName: "endDesc_4") as! SKLabelNode)
        
        end = (self.childNode(withName: "end") as! SKLabelNode)
        end_2 = (self.childNode(withName: "end_2") as! SKLabelNode)
        
        backButton = (self.childNode(withName: "backButton") as! SKSpriteNode)
        back = (self.childNode(withName: "back") as! SKLabelNode)
        
    }
    
    //checking whether back button is pressed to return to the main menu screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodes = self.nodes(at: location)
            
            if nodes.first?.name == "backButton" || nodes.first?.name == "back" {
                let trans = SKTransition.doorsCloseHorizontal(withDuration: 0.5)
                let menuScreen = MenuScene(fileNamed: "MenuScene")
                menuScreen?.scaleMode = .aspectFit
                self.view?.presentScene(menuScreen!, transition: trans)
            }
        }
        
    }

    
    

}
