//
//  BSRoundDetailScore.swift
//  BoxStat
//
//  Created by Jamaal Sedayao on 2/11/16.
//  Copyright © 2016 Jamaal Sedayao. All rights reserved.
//

import UIKit

class BSRoundDetailScore: UIViewController {
    //Fighters
    var redFighter: Fighter?
    var blueFighter: Fighter?
    var currentRound: Rounds!
    
    @IBOutlet var roundNumberLabel: UILabel!
    //RoundTimer
    var timer = NSTimer()
    @IBOutlet var roundTimerLabel: UILabel!
    var roundTime = 10.0
    //UIView
    @IBOutlet var redImageView: UIImageView!
    @IBOutlet var blueImageView: UIImageView!
    @IBOutlet var redCornerButtonsView: UIView!
    @IBOutlet var blueCornerButtonsView: UIView!
    @IBOutlet var redCornerTopView: UIView!
    @IBOutlet var blueCornerTopView: UIView!
    //ButtonOutlets
    @IBOutlet var redCleanPunchButton: UIButton!
    @IBOutlet var redDefenseButton: UIButton!
    @IBOutlet var redEffAggButton: UIButton!
    @IBOutlet var redRingGenButton: UIButton!
    @IBOutlet var blueCleanPunchButton: UIButton!
    @IBOutlet var blueDefenseButton: UIButton!
    @IBOutlet var blueEffAggButton: UIButton!
    @IBOutlet var blueRingGenButton: UIButton!
    //otherbuttons
    @IBOutlet var blueKnockdownButton: UIButton!
    @IBOutlet var bluePointDedButton: UIButton!
    @IBOutlet var redKnockdownButton: UIButton!
    @IBOutlet var redPointDedButton: UIButton!
    //viewLabels
    @IBOutlet var redNameLabel: UILabel!
    @IBOutlet var redKnockdownLabel: UILabel!
    @IBOutlet var redPointDedLabel: UILabel!
    @IBOutlet var blueNameLabel: UILabel!
    @IBOutlet var blueKnockdownLabel: UILabel!
    @IBOutlet var bluePointDedLabel: UILabel!

    //Score Variables
    var redCleanPunchScore = 0.0
    var redDefenseScore = 0.0
    var redEffAggScore = 0.0
    var redRingGenScore = 0.0
    var blueCleanPunchScore = 0.0
    var blueDefenseScore = 0.0
    var blueEffAggScore = 0.0
    var blueRingGenScore = 0.0
    
    var redKnockedDown = 0
    var redPointDed = 0
    var blueKnockedDown = 0
    var bluePointDed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rotateLandscape()
        displayUI()
        startTimer()
            
    }
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    func startTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self,   selector: Selector("countDown"), userInfo: nil, repeats: true)
    }
    
    func countDown(){
        roundTime--
//        var dateString = String(roundTime)
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "mm:ss"
//        let dateFormat = dateFormatter.dateFromString(dateString)
        
        if roundTime > 0{
            roundTimerLabel.text = String(roundTime)
        } else if roundTime == 0 {
            pushToRoundSummary()
            timer.invalidate()
        }
        
    }

    func rotateLandscape(){
        let value = UIInterfaceOrientation.LandscapeRight.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
    }
    
    func displayUI(){
        
        redNameLabel.text = (redFighter!.lastName!)
        blueNameLabel.text = (blueFighter!.lastName!)
        roundNumberLabel.text = "Round: \(currentRound!.value)"
        
        redImageView.image = UIImage(named: (redFighter?.imageString)!)
        blueImageView.image = UIImage(named: (blueFighter?.imageString)!)
        
        redDefenseButton.layer.borderWidth = 2.0
        redDefenseButton.layer.borderColor = UIColor.redColor().CGColor
        redCleanPunchButton.layer.borderWidth = 2.0
        redCleanPunchButton.layer.borderColor = UIColor.redColor().CGColor
        redEffAggButton.layer.borderWidth = 2.0
        redEffAggButton.layer.borderColor = UIColor.redColor().CGColor
        redRingGenButton.layer.borderWidth = 2.0
        redRingGenButton.layer.borderColor = UIColor.redColor().CGColor
        
        blueDefenseButton.layer.borderWidth = 2.0
        blueDefenseButton.layer.borderColor = UIColor.blueColor().CGColor
        blueCleanPunchButton.layer.borderWidth = 2.0
        blueCleanPunchButton.layer.borderColor = UIColor.blueColor().CGColor
        blueEffAggButton.layer.borderWidth = 2.0
        blueEffAggButton.layer.borderColor = UIColor.blueColor().CGColor
        blueRingGenButton.layer.borderWidth = 2.0
        blueRingGenButton.layer.borderColor = UIColor.blueColor().CGColor
    }
    
    
    @IBAction func redCornerButtonTapped(sender: AnyObject) {
        if redCleanPunchButton == sender as! UIButton{
            redCleanPunchScore += 1
        } else if redDefenseButton == sender as! UIButton{
            redDefenseScore += 1
        } else if redEffAggButton == sender as! UIButton{
            redEffAggScore += 1
        } else if redRingGenButton == sender as! UIButton{
            redRingGenScore += 1
        }
    }
    @IBAction func blueCornerButtonTapped(sender: AnyObject) {
        if blueCleanPunchButton == sender as! UIButton{
            blueCleanPunchScore += 1
        } else if blueDefenseButton == sender as! UIButton{
            blueDefenseScore += 1
        } else if blueEffAggButton == sender as! UIButton{
            blueEffAggScore += 1
        } else if blueRingGenButton == sender as! UIButton{
            blueRingGenScore += 1
        }
    }
    
    @IBAction func knockdownButtonTapped(sender: UIButton) {
        if redKnockdownButton == sender {
            blueKnockedDown += 1
            print("Blue Knocked Down: \(blueKnockedDown) times")
        } else if blueKnockdownButton == sender {
            redKnockedDown += 1
            print("Red Knocked Down: \(redKnockedDown) times")
        }
        
    }
    
    @IBAction func pointDedTapped(sender: AnyObject) {
        if redPointDedButton == sender as! UIButton {
            redPointDed += 1
            print("Red Point Deducted: \(redPointDed) points")
        } else if bluePointDedButton == sender as! UIButton {
            bluePointDed += 1
            print("Blue Point Deducted: \(bluePointDed)")
        }
        
    }
    
    func pushToRoundSummary(){
        performSegueWithIdentifier("pushToSummary", sender: nil)
        print("Segue works")
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "pushToSummary" {
            let destinationVC = segue.destinationViewController as! ViewController
            
            destinationVC.redFighter = self.redFighter
            destinationVC.blueFighter = self.blueFighter    
            destinationVC.redPunch = self.redCleanPunchScore
            destinationVC.redDefense = self.redDefenseScore
            destinationVC.redEffAgg = self.redEffAggScore
            destinationVC.redRingGen = self.redRingGenScore
            destinationVC.bluePunch = self.blueCleanPunchScore
            destinationVC.blueDefense = self.blueDefenseScore
            destinationVC.blueEffAgg = self.blueEffAggScore
            destinationVC.blueRingGen = self.blueRingGenScore
            destinationVC.blueKnockedDown = self.blueKnockedDown
            destinationVC.redKnockedDown = self.redKnockedDown
            destinationVC.redPointDed = self.redPointDed
            destinationVC.bluePointDed = self.bluePointDed
            destinationVC.currentRound = self.currentRound
        }
        
    }

}
