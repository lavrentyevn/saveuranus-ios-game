//
//  Constant.swift
//  spritekittest
//
//  Created by Николай Лаврентьев on 07.01.2023.
//

import SpriteKit

enum PhysicsCategories {
    static let none: UInt32 = 0
    static let ball: UInt32 = 0b1
    static let enemyball: UInt32 = 0b10
    static let evilenemyball: UInt32 = 0b100
    static let usedball: UInt32 = 0b1000
    static let borderObstacle: UInt32 = 0b10000
    static let floorObstacle: UInt32 = 0b100000
    static let deathball: UInt32 = 0b1000000
}

