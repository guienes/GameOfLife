//
//  States.swift
//  BronzeChallenge
//
//  Created by Guilherme Enes on 01/11/19.
//  Copyright © 2019 Guilherme Enes. All rights reserved.
//

import Foundation
import SceneKit


class States {
    
    var diverseCases:Int = 0
    var isAlive:Bool = false
    var neighborCount = 0
    var arraySquare = [SCNNode]()
    var linhas: [Bool] = []
    var colunas: [[Bool]] = []
    var behaviors: Bool = false
    var outraMatriz: [[Bool]] = []
    
    init(array: [SCNNode], boolArray: [[Bool]] ) {
        self.arraySquare = array
        self.colunas = boolArray
    }
    
    private func get(_ x: Int, _ y: Int) -> Bool? {
        if x > 0, y > 0, x < colunas.count, y < colunas.count{
            let value = colunas[x][y]
            return value
        }
        return nil
    }
    
    
    
    
    
    func stateDealer() -> [[Bool]] {
//        print("MATRIZ DO STATE DEALER \n", colunas)
        for xIndex:Int in 0...10{
            linhas = []
            for zIndex:Int in 0...10{
                diverseCases = 0
                let neighbors: [Bool?] = [
                        get(xIndex-1, zIndex-1),
                        get(xIndex, zIndex-1),
                        get(xIndex, zIndex+1),
                        get(xIndex+1, zIndex+1),
                        get(xIndex-1, zIndex+1),
                        get(xIndex+1, zIndex-1),
                        get(xIndex-1, zIndex),
                        get(xIndex+1, zIndex),
                        ]
                    let neighborsSum = neighbors.compactMap { $0 }.map{ $0 ? 1 : 0 }.reduce(0,+)
                    switch neighborsSum {
                    case 0 ... 1:
                        linhas.append(false)
                    case 2 ... 3:
                        if let isAlive = get(xIndex, zIndex) {
                            if isAlive {
                                linhas.append(true)
                            } else {
                                linhas.append(neighborsSum == 3)
                            }
                        } else {
                            linhas.append(false)
                        }
                    default:
                        linhas.append(false)
                    }
        }
            outraMatriz.append(linhas)

    }
    return outraMatriz
    }
}


//if xIndex == 0 && zIndex < linhas.count-1{
//                  if xIndex == 0 && zIndex == 0{
//                      if colunas[xIndex][zIndex+1] == true {
//                          diverseCases+=1
//                      }
//                      if colunas[xIndex+1][zIndex+1] == true{
//                          diverseCases+=1
//                      }
//                      if colunas[xIndex+1][zIndex] == true {
//                          diverseCases+=1
//                      }
//                  }
//
//                  if xIndex == 0 && zIndex == 10{
//
//                      if colunas[xIndex][zIndex-1] == true{
//                                     diverseCases+=1
//                                    }
//
//                      if colunas[xIndex+1][zIndex-1] == true{
//                          diverseCases+=1
//                      }
//
//                      if colunas[xIndex+1][zIndex] == true{
//                          diverseCases+=1
//                      }
//                  }
//
//                  if colunas[xIndex+1][zIndex] == true{
//                      diverseCases+=1
//                  }
//
//                  if colunas[xIndex][zIndex-1] == true{
//                      diverseCases+=1
//                  }
//
//                  if colunas[xIndex+1][zIndex-1] == true{
//                      diverseCases+=1
//                  }
//
//                  if colunas[xIndex+1][zIndex+1] == true{
//                      diverseCases+=1
//                  }
//
//                  if colunas[xIndex][zIndex+1] == true{
//                      diverseCases+=1
//                  }
//
//              }
//
//              if xIndex == 10 && zIndex < linhas.count-1{
//                  if xIndex == 10 && zIndex == 0{
//
//                  }
//              }
//

