//
//  CreditScene.swift
//  Swift_Rift
//
//  Created by Erhan Ulusal on 28/02/2019.
//  Copyright © 2019 Erhan Ulusal. All rights reserved.
//

import UIKit
import SpriteKit

class CreditScene: SKScene {
    
    //variable for credit heading
    var title:SKLabelNode!
    
    //variables for the back button
    var backButton:SKSpriteNode!
    var back:SKLabelNode!
    
    //variables for the credits
    var cred1:SKLabelNode!
    var cred1_2:SKLabelNode!
    var cred2:SKLabelNode!
    var cred2_2:SKLabelNode!
    var cred3:SKLabelNode!
    var cred3_2:SKLabelNode!
    var cred4:SKLabelNode!
    var cred4_2:SKLabelNode!
    var cred5:SKLabelNode!
    var cred5_2:SKLabelNode!
    var cred6:SKLabelNode!
    var cred6_2:SKLabelNode!
    var cred7:SKLabelNode!
    var cred7_2:SKLabelNode!
    var cred8:SKLabelNode!
    var cred8_2:SKLabelNode!
    
    override func didMove(to view: SKView) {
        
        //assigning assests in CreditScene.sks to the variables above
        title = (self.childNode(withName: "creditLabel") as! SKLabelNode)
        
        backButton = (self.childNode(withName: "backButton") as! SKSpriteNode)
        back = (self.childNode(withName: "back") as! SKLabelNode)
        
        cred1 = (self.childNode(withName: "cred1") as! SKLabelNode)
        cred1_2 = (self.childNode(withName: "cred1_2") as! SKLabelNode)
        cred2 = (self.childNode(withName: "cred2") as! SKLabelNode)
        cred2_2 = (self.childNode(withName: "cred2_2") as! SKLabelNode)
        cred3 = (self.childNode(withName: "cred3") as! SKLabelNode)
        cred3_2 = (self.childNode(withName: "cred3_2") as! SKLabelNode)
        cred4 = (self.childNode(withName: "cred4") as! SKLabelNode)
        cred4_2 = (self.childNode(withName: "cred4_2") as! SKLabelNode)
        cred5 = (self.childNode(withName: "cred5") as! SKLabelNode)
        cred5_2 = (self.childNode(withName: "cred5_2") as! SKLabelNode)
        cred6 = (self.childNode(withName: "cred6") as! SKLabelNode)
        cred6_2 = (self.childNode(withName: "cred6_2") as! SKLabelNode)
        cred7 = (self.childNode(withName: "cred7") as! SKLabelNode)
        cred7_2 = (self.childNode(withName: "cred7_2") as! SKLabelNode)
        cred8 = (self.childNode(withName: "cred8") as! SKLabelNode)
        cred8_2 = (self.childNode(withName: "cred8_2") as! SKLabelNode)
        
        
        
    }
    
    //checking whether back button is pressed to return to the main menu screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self){
            let nodes = self.nodes(at: location)
            
            if nodes.first?.name == "backButton" || nodes.first?.name == "back" {
                let trans = SKTransition.doorsCloseHorizontal(withDuration: 0.5)
                let menuScreen = MenuScene(fileNamed: "MenuScene")
                menuScreen?.scaleMode = SKSceneScaleMode.resizeFill
                self.view?.presentScene(menuScreen!, transition: trans)
            }
        }
        
    }

}
