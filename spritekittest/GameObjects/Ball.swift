//
//  Ball.swift
//  spritekittest
//
//  Created by Николай Лаврентьев on 03.01.2023.
//

import SpriteKit

class Ball: SKSpriteNode {

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)

        self.colorBlendFactor = 1
        self.name = "ball"

        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        self.physicsBody?.categoryBitMask = PhysicsCategories.ball
        self.physicsBody?.contactTestBitMask = PhysicsCategories.floorObstacle | PhysicsCategories.borderObstacle | PhysicsCategories.deathball
        self.physicsBody?.collisionBitMask = PhysicsCategories.borderObstacle | PhysicsCategories.enemyball | PhysicsCategories.evilenemyball | PhysicsCategories.floorObstacle | PhysicsCategories.usedball | PhysicsCategories.deathball
        self.physicsBody?.fieldBitMask = PhysicsCategories.none

        self.physicsBody?.allowsRotation = true
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.linearDamping = 0.5
        self.physicsBody?.restitution = 0.9
        self.physicsBody?.friction = 0
        
        self.zPosition = 10
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

func ballApplyImpulse(ball: SKSpriteNode, vx: Int, vy: Int) {
    ball.physicsBody?.applyImpulse(CGVector(dx: vx,
                                            dy: vy))
}


