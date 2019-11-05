//
//  Cell.swift
//  BronzeChallenge
//
//  Created by Guilherme Enes on 01/11/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import Foundation
import SceneKit

class Cell: SCNNode{

    
//    init(x: Float, y: Float, z: Float) {
//        super.init()
//        self.x = x
//        self.y = y
//        self.z = z
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    
    func createSquare(x: Float, y: Float, z: Float) -> SCNNode{
        let squareGeometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.1)
         let squareNode = SCNNode(geometry: squareGeometry)
        squareNode.position = SCNVector3(x: x, y: y, z: z)
        return squareNode
    }
}




//let squareGeometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.1)
//    let squareNode = SCNNode(geometry: squareGeometry)
//    squareNode.position = SCNVector3(0, 0.5, 0)
