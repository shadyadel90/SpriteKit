//
//  GameScene.swift
//  p14
//
//  Created by Shady Adel on 14/05/2023.
//

import SpriteKit

class GameScene: SKScene {
    var gamescore : SKLabelNode!
    var score = 0 {
        didSet {
            gamescore.text = "Score:\(score)"
        }
    }
    var numRounds = 0
    var slots = [whackSlot]()
    var popupTime = 0.85
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: 512, y: 386)
        background.zPosition = -1
        addChild(background)
        
        gamescore = SKLabelNode (fontNamed: "Chalkduster")
        gamescore.text = "Score: 0"
        gamescore.position = CGPoint (x: 8, y: 8)
        gamescore.horizontalAlignmentMode = .left
        gamescore.fontSize = 40
        addChild(gamescore)
        
        for i in 0..<5 { createSlot(at: CGPoint (x: 100 + (i * 170), y: 410)) }
        for i in 0..<4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 320)) }
        for i in 0..<5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 230)) }
        for i in 0..<4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 140)) }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            [weak self] in
            self?.createEnemy()
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let location = touches.first?.location(in: self) else {return}
        let touchNodes = nodes(at: location)
        
        for node in touchNodes {
            guard let whackSlot = node.parent?.parent as? whackSlot else {continue}
            
            whackSlot.charNode.xScale = 0.7
            whackSlot.charNode.yScale = 0.7
           
            if node.name == "goodFriend" {
                run(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion: false))
                score -= 5
                run(SKAction.wait(forDuration: 1))
                whackSlot.hit()
            }
            else if node.name == "evilFriend"{
                run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion: false))
                score += 1
                run(SKAction.wait(forDuration: 1))
                whackSlot.hit()
            }
        }
    }
    
    func createSlot(at position: CGPoint){
        let slot = whackSlot()
        slot.configure(position)
        addChild(slot)
        slots.append(slot)
    }
    func createEnemy () {
        if numRounds >= 10 {
            let gameover = SKSpriteNode(imageNamed: "gameOver")
            gameover.position = CGPoint(x: 512, y: 386)
            gameover.zPosition = 1
            addChild(gameover)
            let fgamescore = SKLabelNode (fontNamed: "Chalkduster")
            fgamescore.text = "Score: \(score)"
            fgamescore.position = CGPoint (x:512 , y: 300)
            fgamescore.horizontalAlignmentMode = .left
            fgamescore.fontSize = 40
            fgamescore.zPosition = 1
            addChild(fgamescore)
            return
        }
        numRounds += 1
        popupTime *= 0.991
        slots.shuffle()
        slots[0].show(hideTime: popupTime)
        
        if Int.random(in: 0...12) > 4 { slots [1].show(hideTime: popupTime) }
        if Int.random(in: 0...12) > 8 { slots [2].show(hideTime: popupTime) }
        if Int.random(in: 0...12) > 10 { slots[3].show(hideTime: popupTime) }
        if Int.random(in: 0...12) > 11 { slots[4].show(hideTime: popupTime) }
        
        let minDelay = popupTime / 2.0
        let maxDelay = popupTime * 2
        let delay = Double.random(in: minDelay...maxDelay)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.createEnemy()
        }
    }
    }


        
        
// skaction,skcropnode,spritekit
// gcd

