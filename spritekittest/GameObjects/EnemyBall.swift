//
//  EnemyBall.swift
//  spritekittest
//
//  Created by Николай Лаврентьев on 04.01.2023.
//


import SpriteKit


class EnemyBall: SKSpriteNode {

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)

        self.colorBlendFactor = 1
        self.name = "enemyball"
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        self.physicsBody?.categoryBitMask = PhysicsCategories.enemyball
        self.physicsBody?.contactTestBitMask = PhysicsCategories.floorObstacle |  PhysicsCategories.ball | PhysicsCategories.usedball | PhysicsCategories.deathball
        self.physicsBody?.collisionBitMask = PhysicsCategories.ball | PhysicsCategories.enemyball | PhysicsCategories.evilenemyball | PhysicsCategories.floorObstacle | PhysicsCategories.usedball | PhysicsCategories.deathball
        self.physicsBody?.fieldBitMask = PhysicsCategories.none

        self.physicsBody?.allowsRotation = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.angularDamping = 0
        self.physicsBody?.linearDamping = 0.5
        self.physicsBody?.restitution = 1
        self.physicsBody?.friction = 0
        
        self.zPosition = 10
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

