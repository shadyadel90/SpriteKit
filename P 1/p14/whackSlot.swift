//
//  whackSlot.swift
//  p14
//
//  Created by Shady Adel on 15/05/2023.
//

import UIKit
import SpriteKit
class whackSlot: SKNode {
    var charNode : SKSpriteNode!
    var isVisible = false
    var isHit = false
    
    func configure(_ position: CGPoint){
        self.position = position
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        
        cropNode.addChild(charNode)
        
        addChild(cropNode)
    }
    
    func show (hideTime:Double){
        if isVisible {return}
        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        isVisible = true
        isHit = false
        if Int.random(in: 0...2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "goodFriend"
            
        }
        else
        {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "evilFriend"
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)){
            [weak self] in
            self!.hide()
        }
    }
    func hide(){
        if !isVisible {return}
        isVisible = false
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        
    }
    func hit() {
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.5))
        if charNode.name == "evilFriend" {
            if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
                        fireParticles.position = charNode.position
                            addChild(fireParticles)
                        }
        }
        
    }
}
