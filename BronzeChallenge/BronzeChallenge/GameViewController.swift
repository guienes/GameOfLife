//
//  GameViewController.swift
//  BronzeChallenge
//
//  Created by Guilherme Enes on 31/10/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    let scene = SCNScene()
    lazy var sceneView = self.view as! SCNView
    lazy var arraySquare = [SCNNode]()
    var linhas: [Bool] = []
    var colunas: [[Bool]] = []
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSquare()
        createButton()
       }
    
    func createSquare() {
//        let squareGeometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.1)
//        let squareNode = SCNNode(geometry: squareGeometry)
//        squareNode.position = SCNVector3(1, 0.5, 1)
//
//        scene.rootNode.addChildNode(squareNode)
        
        
        
        
        
        // adiciona o chão (GRID)
        
        let geometry = SCNBox(width: 1 , height: 0.1,
                                      length: 1, chamferRadius: 0.005)
               geometry.firstMaterial?.diffuse.contents = UIColor.red
               geometry.firstMaterial?.specular.contents = UIColor.white
               geometry.firstMaterial?.emission.contents = UIColor.blue
               let boxnode = SCNNode(geometry: geometry)
               let offset: Int = 0
               
               
               for xIndex:Int in 0..<10{
                linhas = []
                   for zIndex:Int in 0..<10 {
                    linhas.append(false)
                       let boxCopy = boxnode.copy() as! SCNNode
                       boxCopy.position.x = Float(xIndex - offset)
                       boxCopy.position.z = Float(zIndex - offset)
                       scene.rootNode.addChildNode(boxCopy)
                   }
                colunas.append(linhas)
               }
        
        
        
        // ============================================================================================
        
//
//
//        let cameraNode = SCNNode()
//        cameraNode.camera = SCNCamera()
//        scene.rootNode.addChildNode(cameraNode)
//
//        cameraNode.position = SCNVector3(x: 0, y: 25, z: 0)
//        let lookConstraint = SCNLookAtConstraint(target: squareNode)
//        cameraNode.constraints = [lookConstraint]
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = .orange
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        sceneView.addGestureRecognizer(tapGesture)
        
    }
    
    //========================== BOTAO PARA DAR PLAY ==================================
    func createButton() {
        let buttonT = UIButton()
        
        let viewHeigth = self.view.frame.height
        let viewWidth = self.view.frame.width
        
        buttonT.frame = CGRect(x: viewWidth/2 - 25, y: viewHeigth/2 + 300, width: 50, height: 50)
        buttonT.backgroundColor = .black
        
        buttonT.addTarget(self, action: #selector(handleButton(_:)), for: .touchDown)
        sceneView.addSubview(buttonT)
        
    }
    
    @objc func handleButton(_ gestureRecognize: UIGestureRecognizer){
        var statesCell = States.init(array: arraySquare, boolArray: colunas)

        for i in 0 ..< arraySquare.count{
            arraySquare[i].removeFromParentNode()
        }
        arraySquare.removeAll()
        print("MATRIZ INICIAL \n",colunas)
        
        colunas = statesCell.stateDealer()
        print("MATRIZ MUDADA \n",colunas)
//
        for indexX:Int in 0...colunas.count-1{
            for indexZ:Int in 0...linhas.count-1{
                if colunas[indexX][indexZ] == true{
                    let square = Cell().createSquare(x: Float(indexX), y: 0.5, z: Float(indexZ))
                    scene.rootNode.addChildNode(square)
                    arraySquare.append(square)
                    
                }

            }
        }
        
        
        
        
//        if arraySquare.isEmpty {
//            print("Vai crashar n")
//        } else {
//            arraySquare.removeLast().removeFromParentNode()
//            print(arraySquare)
//
//        }
    }
    
    
    // =============================================================================
    
    @objc func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let sceneView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: sceneView)
        let hitResults = sceneView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            colunas[Int(result.node.position.x)][Int(result.node.position.z)] = true
            
            let square = Cell().createSquare(x: result.node.position.x, y: 0.5, z: result.node.position.z )
            
            scene.rootNode.addChildNode(square)
            arraySquare.append(square)
            
            
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    // ======================================================================================================================================================================

    
    
    
    
    func setupNave() {
        // create a new scene
               let scene = SCNScene(named: "art.scnassets/ship.scn")!
               
               // create and add a camera to the scene
               let cameraNode = SCNNode()
               cameraNode.camera = SCNCamera()
               scene.rootNode.addChildNode(cameraNode)
               
               // place the camera
               cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
               
               // create and add a light to the scene
               let lightNode = SCNNode()
               lightNode.light = SCNLight()
               lightNode.light!.type = .omni
               lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
               scene.rootNode.addChildNode(lightNode)
               
               // create and add an ambient light to the scene
               let ambientLightNode = SCNNode()
               ambientLightNode.light = SCNLight()
               ambientLightNode.light!.type = .ambient
               ambientLightNode.light!.color = UIColor.darkGray
               scene.rootNode.addChildNode(ambientLightNode)
               
               // retrieve the ship node
               let ship = scene.rootNode.childNode(withName: "ship", recursively: true)!
               
               // animate the 3d object
               ship.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))
               
               // retrieve the SCNView
               let scnView = self.view as! SCNView
               
               // set the scene to the view
               scnView.scene = scene
               
               // allows the user to manipulate the camera
               scnView.allowsCameraControl = true
               
               // show statistics such as fps and timing information
               scnView.showsStatistics = true
               
               // configure the view
               scnView.backgroundColor = UIColor.black
               
            
           }
    }

