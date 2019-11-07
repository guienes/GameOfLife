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
    var arraySquare = [SCNNode]()
    var arraySquareBlink = [SCNNode]()
    var linhas: [Bool] = []
    var colunas: [[Bool]] = []
    var yheigth: Float = 0.5
    var timerSet = Timer()
    let imageSeta = UIImage(named: "seta")
    let imageStop = UIImage(named: "stop")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLight()
        createSquare()
        playButton()
        deleteBttn()
    }
    
    func makeLight() {
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(0, 100, 0)
        scene.rootNode.addChildNode(lightNode)
        
        let ambient = SCNNode()
        ambient.light = SCNLight()
        ambient.light?.type = .ambient
        ambient.light?.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambient)
    }
    
    func createSquare() {
        
        let geometry = SCNBox(width: 1 , height: 0.1,
                              length: 1, chamferRadius: 0.005)
        geometry.firstMaterial?.diffuse.contents = UIColor.white
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
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        cameraNode.position = SCNVector3(x: 5, y: 0, z: 50)
        cameraNode.camera?.zFar = 75
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = .orange
        
        //        let lookConstraint = SCNLookAtConstraint(target: squareNode)
        //        cameraNode.constraints = [lookConstraint]
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchInMatriz(_:)))
        sceneView.addGestureRecognizer(tapGesture)
        
    }
    
    
    
    
    
    func playButton() {


        let viewHeigth = self.view.frame.height
        let viewWidth = self.view.frame.width
        
        let buttonT = UIButton(frame: CGRect(x: viewWidth/2 - 120, y: viewHeigth/2 + 300, width: 50, height: 50))
        buttonT.layer.zPosition = 999999
        buttonT.setBackgroundImage(imageSeta, for: .normal)
        buttonT.addTarget(self, action: #selector(startTimer), for: .touchDown)
        sceneView.addSubview(buttonT)
    }
    
    func deleteBttn() {
        let viewHeigth = self.view.frame.height
        let viewWidth = self.view.frame.width
        let buttonDel = UIButton(frame: CGRect(x: viewWidth/2 + 80 , y: viewHeigth/2 + 300, width: 50, height: 50))
        buttonDel.layer.zPosition = 999999
        buttonDel.setBackgroundImage(imageStop, for: .normal)
        buttonDel.addTarget(self, action: #selector(deleteButton(_:)), for: .touchDown)
        sceneView.addSubview(buttonDel)
        
        
    }
    
    @objc func deleteButton(_ gestureRecognize: UIGestureRecognizer){
        timerSet.invalidate()
    }
    
    @objc func startTimer() {
        timerSet = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(handleButton(_:)), userInfo: nil, repeats: true)
    }
    
    @objc func handleButton(_ gestureRecognize: UIGestureRecognizer){
        var rand = Int.random(in: 0...arraySquareBlink.count-1)

        var statesCell = States.init(array: arraySquare, boolArray: colunas)
        
        arraySquare.removeAll()
        colunas = statesCell.stateDealer()
        
        yheigth+=1
        for indexX:Int in 0...colunas.count-1{
            for indexZ:Int in 0...linhas.count-1{
                if colunas[indexX][indexZ] == true{
                    let square = Cell().createSquare(x: Float(indexX), y: yheigth, z: Float(indexZ))
                    scene.rootNode.addChildNode(square)
                    arraySquare.append(square)
                    arraySquareBlink.append(square)
                }
            }
        }
        print(rand)
    }
    

   
    
    @objc func touchInMatriz(_ gestureRecognize: UIGestureRecognizer) {
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
            
            let square = Cell().createSquare(x: result.node.position.x, y: yheigth, z: result.node.position.z )
            
            scene.rootNode.addChildNode(square)
            arraySquare.append(square)
            arraySquareBlink.append(square)
            
            
            
        }
    }
    
}

