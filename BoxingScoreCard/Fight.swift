//
//  Fight.swift
//  BoxingScoreCard
//
//  Created by Jamaal Sedayao on 2/20/16.
//  Copyright © 2016 Jamaal Sedayao. All rights reserved.
//

import Foundation

class Fight {
    var roundsArray: [Rounds]
    var fighterBlueCorner: String
    var fighterRedCorner: String
    var winnerOfFight: String               //who won - class of fighter
    var resultOfFight: String               //result = UD, SD, ND, KO, TKO, RTD
    var roundEnded: Rounds
    var timeEnded: Int
    
    init(roundsArray:[Rounds], fighterBlueCorner: String, fighterRedCorner: String, winnerOfFight: String, resultOfFight: String, roundEnded: Rounds, timeEnded: Int){
    self.roundsArray = roundsArray
    self.fighterBlueCorner = fighterBlueCorner
    self.fighterRedCorner = fighterRedCorner
    self.winnerOfFight = winnerOfFight
    self.resultOfFight = resultOfFight
    self.roundEnded = roundEnded
    self.timeEnded = timeEnded
    }
}