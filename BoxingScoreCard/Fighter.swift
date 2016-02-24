//
//  Fighter.swift
//  BoxingScoreCard
//
//  Created by Jamaal Sedayao on 2/20/16.
//  Copyright © 2016 Jamaal Sedayao. All rights reserved.
//

import Foundation

class Fighter{
    var firstName: String?
    var lastName: String?
    var nickName: String?
    var weight: String?
    var height: String?
    var wins: Int?
    var losses: Int?
    var knockouts: Int?
    var imageString: String?
    var weightDivision:String?
    var stance:String?
    var country: String?

    init(firstName:String, lastName:String, weight:String, height:String, wins:Int, losses:Int, imageString:String, weightDivision:String, stance:String, country:String){
        self.firstName = firstName
        self.lastName = lastName
        self.weight = weight
        self.height = height
        self.wins = wins
        self.losses = losses
        self.imageString = imageString
        self.weightDivision = weightDivision
        self.stance = stance
        self.country = country
    }
}