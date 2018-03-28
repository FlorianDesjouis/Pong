//
//  GameScene.swift
//  Pong
//
//  Created by Florian Desjouis on 08/03/2018.
//  Copyright © 2018 Florian Desjouis. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    private var computerScore = 0
    private var playerScore = 0
    var elements = [String: SKSpriteNode]()
    
    override func didMove(to view: SKView) {
        elements["ball"] = self.childNode(withName: "ball") as! SKSpriteNode
        
        elements["ball"]?.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 70))
        
        let frameBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        frameBody.friction = 0
        frameBody.restitution = 1
        
        self.physicsBody = frameBody
    }
    
    func touchMoved(toPoint pos: CGPoint){
        self.childNode(withName: "playerBottom")?.position.x = pos.x
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
//         Called before each frame is rendered
        self.childNode(withName: "playerTop")?.run(SKAction.moveTo(x: (self.childNode(withName: "ball")?.position.x)!, duration: 0.15 ))
        
        if((self.childNode(withName: "ball")?.position.y)! > CGFloat(565)){
            self.playerScore += 1
            self.childNode(withName: "ball")?.position.x = 0
            self.childNode(withName: "ball")?.position.y = 0
            elements["ball"]?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            elements["ball"]?.physicsBody?.applyImpulse(CGVector(dx: -50, dy: -50))
        }
        
        if((self.childNode(withName: "ball")?.position.y)! < CGFloat(-565)){
            self.computerScore += 1
            self.childNode(withName: "ball")?.position.x = 0
            self.childNode(withName: "ball")?.position.y = 0
            elements["ball"]?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            elements["ball"]?.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
        }
        
        let computerScoreLabel = self.childNode(withName: "computerScore") as! SKLabelNode
        let playerScoreLabel = self.childNode(withName: "playerScore") as! SKLabelNode
        
        computerScoreLabel.text = "\(self.computerScore)"
        playerScoreLabel.text = "\(self.playerScore)"
        
    }
}
