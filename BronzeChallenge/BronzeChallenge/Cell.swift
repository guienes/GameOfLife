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
    
    
    var colorPicker: [UIColor] = [#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 1, green: 0.677033606, blue: 0.2051951423, alpha: 1),#colorLiteral(red: 1, green: 0.08670990864, blue: 0.9406366298, alpha: 1),#colorLiteral(red: 0.01022211655, green: 0.4063753999, blue: 1, alpha: 1),#colorLiteral(red: 0.06558893203, green: 1, blue: 0, alpha: 1)]
    
    func createSquare(x: Float, y: Float, z: Float) -> SCNNode{
        let squareGeometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.1)
        squareGeometry.firstMaterial?.diffuse.contents = colorPicker.randomElement()
        if Int.random(in: 1...100) % 2 == 0, let emission = squareGeometry.firstMaterial?.emission {
            emission.contents = colorPicker.randomElement()
            makePiscaPiscaAnimation(property: emission)
        }
        let squareNode = SCNNode(geometry: squareGeometry)
        
        squareNode.position = SCNVector3(x: x, y: y, z: z)
        return squareNode
    }
    
    func makePiscaPiscaAnimation(property: SCNMaterialProperty) {
           let animation = CABasicAnimation(keyPath: "intensity")
           animation.fromValue = 0.0
           animation.toValue = 0.8
           animation.duration = 4
           animation.autoreverses = true
        animation.repeatCount = .infinity

           property.addAnimation(animation, forKey: "extrude")
       }
   
    
}
