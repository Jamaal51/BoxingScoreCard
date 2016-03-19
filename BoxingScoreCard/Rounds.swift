//
//  Rounds.swift
//  BoxingScoreCard
//
//  Created by Jamaal Sedayao on 2/18/16.
//  Copyright © 2016 Jamaal Sedayao. All rights reserved.
//

import Foundation

class Rounds {
    var value: Int
    var redScore: Int = 0
    var blueScore: Int = 0
    var winnerOfRound: String?
    var close: Bool?
    var roundScored = false
    var redKnockdown: Int = 0
    var blueKnockdown: Int = 0
    var redPointDed: Int = 0
    var bluePointDed: Int = 0
    
    init(value: Int) {
    self.value = value
//    self.roundScored = roundScored
//    self.blueScore = blueScore
    }
}

