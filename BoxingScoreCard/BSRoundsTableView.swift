//
//  BSRoundsTableView.swift
//  BoxingScoreCard
//
//  Created by Jamaal Sedayao on 2/16/16.
//  Copyright © 2016 Jamaal Sedayao. All rights reserved.
//

import UIKit

class BSRoundsTableView: UIViewController,UITableViewDelegate, UITableViewDataSource, RedFighterSelectedDelegate, BlueFighterSelectedDelegate{
    
    let tapRec = UITapGestureRecognizer()
    let tapRec2 = UITapGestureRecognizer()
    
    @IBOutlet var topViewLabel: UILabel!
    var passedData: String?
    
    //redCornerView
    @IBOutlet var redCornerView: UIView!
    @IBOutlet var redNameLabel: UILabel!
    @IBOutlet var redDivisionLabel: UILabel!
    @IBOutlet var redStanceLabel: UILabel!
    @IBOutlet var redCornerImageView: UIImageView!
    
    //blueCornerView
    @IBOutlet var blueCornerView: UIView!
    @IBOutlet var blueNameLabel: UILabel!
    @IBOutlet var blueCornerImageView: UIImageView!
    @IBOutlet var blueDivisionLabel: UILabel!
    @IBOutlet var blueStanceLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    var redCornerFighter: Fighter?
    var blueCornerFighter: Fighter?
    var roundsArray = [Rounds]()
    var currentRound:Rounds!
    var finishedRoundsArray = [Rounds]()
    
    func displayUI(){
        redCornerView.layer.borderWidth = 1.0
        blueCornerView.layer.borderWidth = 1.0
        redCornerView.layer.borderColor = (UIColor.redColor()).CGColor
        blueCornerView.layer.borderColor = (UIColor.blueColor()).CGColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayUI()
        assignTapGestures()
        initializeRounds()
        //checkCurrentRound()
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "testNotification", name: "UserLoggedIn", object: nil)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationController?.navigationBarHidden = true
        self.tableView.userInteractionEnabled = false
        self.tableView.backgroundColor = UIColor.grayColor()
        topViewLabel.text = "Choose Fighters"
        
        
    }
    
//    func checkCurrentRound() {
//        print("Check Current Round")
//       
//        while (currentRound == nil){
//            for round in roundsArray {
//                if round.roundScored == false {
//                    currentRound = round
//                    print("Current round is Round \(currentRound!.value)")
//                    break
//                }
//            }
//        }
//        
//    }
    
    func testNotification(){
        
        let lastRound = roundsArray.removeAtIndex(0)
        
        finishedRoundsArray.append(lastRound)
        
        currentRound = roundsArray[0]
        
        print("Current Round is now \(currentRound.value)")
        
        print("Notification works!")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        tableView.reloadData()
        //checkCurrentRound()
        
        if self.passedData != nil {
        print("Data Passed: \(self.passedData!)")
        }
    }
    
    func initializeRounds(){
        let round1 = Rounds(value: 1)
        let round2 = Rounds(value: 2)
        let round3 = Rounds(value: 3)
        let round4 = Rounds(value: 4)
        let round5 = Rounds(value: 5)
        let round6 = Rounds(value: 6)
        let round7 = Rounds(value: 7)
        let round8 = Rounds(value: 8)
        let round9 = Rounds(value: 9)
        let round10 = Rounds(value: 10)
        let roundeleven = Rounds(value: 11)
        let roundtwelve = Rounds(value: 12)
        
        roundsArray = [round1,round2, round3, round4, round5, round6, round7, round8, round9, round10, roundeleven,roundtwelve]
        
        currentRound = roundsArray[0]
        
    }
    
    func assignTapGestures(){
        
        redCornerView.addGestureRecognizer(tapRec)
        redCornerView.userInteractionEnabled = true
        tapRec.addTarget(self, action: "tappedRedView")
        
        blueCornerView.addGestureRecognizer(tapRec2)
        blueCornerView.userInteractionEnabled = true
        tapRec2.addTarget(self, action: "tappedBlueView")
    }
    
    func userDidSelectRedFighter(redFighter: Fighter) {
        print(redFighter.firstName!)
        redCornerFighter = redFighter
        redNameLabel.text = "\(redFighter.firstName!) \"\(redFighter.nickName!)\" \(redFighter.lastName!)"
        redDivisionLabel.text = "Division: \(redFighter.weightDivision!)"
        redStanceLabel.text = "Stance: \(redFighter.stance!)"
        let image: UIImage = UIImage(named: redFighter.imageString!)!
        redCornerImageView.image = image
        
        if blueCornerFighter != nil {
            tableView.userInteractionEnabled = true
            topViewLabel.text = "\(redCornerFighter!.lastName!) Vs. \(blueCornerFighter!.lastName!)"
        }
    }
    
    func userDidSelectBlueFighter(blueFighter: Fighter) {
        print(blueFighter.firstName!)
        
        blueCornerFighter = blueFighter
        blueNameLabel.text = "\(blueFighter.firstName!) \"\(blueFighter.nickName!)\" \(blueFighter.lastName!)"
        blueDivisionLabel.text = "Division: \(blueFighter.weightDivision!)"
        blueStanceLabel.text = "Stance:\(blueFighter.stance!)"
        let image: UIImage = UIImage(named: blueFighter.imageString!)!
        blueCornerImageView.image = image
        
        if redCornerFighter != nil {
            tableView.userInteractionEnabled = true
            topViewLabel.text = "\(redCornerFighter!.lastName!) Vs. \(blueCornerFighter!.lastName!)"
        }
    }
    
    func tappedRedView(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewControllerWithIdentifier("fighterListTBVID") as! BSFighterListTableViewController
        destinationVC.delegateRed = self
        self.presentViewController(destinationVC, animated: true, completion: nil)
        
    }
    func tappedBlueView(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewControllerWithIdentifier("fighterListTBVID") as! BSFighterListTableViewController
        destinationVC.delegateBlue = self
        self.presentViewController(destinationVC, animated: true, completion: nil)
        
    }

    //MARK: - TableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.finishedRoundsArray.count
        } else {
            return self.roundsArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier("roundsIdentifier", forIndexPath:indexPath) as? CustomRoundsTableViewCell else {
            return UITableViewCell()
        }
        
//        let round = roundsArray[indexPath.row]
//        
//        cell.roundNumberLabel?.text = "Round \(round.value)"
//        cell.redScoreLabel?.text = String(round.redScore)
//        cell.blueScoreLabel?.text = String(round.blueScore)
//        
//        let hasScore = round.redScore != 0 && round.blueScore != 0
//        cell.selectionStyle = hasScore ? .None : .Default
//        cell.userInteractionEnabled = !hasScore
//        cell.roundNumberLabel.enabled = !hasScore
//        cell.blueScoreLabel.enabled = !hasScore
//        cell.redScoreLabel.enabled = !hasScore
        
        if indexPath.section == 0 {
            
            let round = finishedRoundsArray[indexPath.row]
            cell.roundNumberLabel?.text = "Round \(round.value)"
            cell.redScoreLabel?.text = String(round.redScore)
            cell.blueScoreLabel?.text = String(round.blueScore)

            let hasScore = round.redScore != 0 && round.blueScore != 0
            cell.selectionStyle = hasScore ? .None : .Default
            cell.userInteractionEnabled = !hasScore
            cell.roundNumberLabel.enabled = !hasScore
            cell.blueScoreLabel.enabled = !hasScore
            cell.redScoreLabel.enabled = !hasScore
        
            
        } else {
            
            let round = roundsArray[indexPath.row]
            
            cell.roundNumberLabel?.text = "Round \(round.value)"
            cell.redScoreLabel?.text = String(round.redScore)
            cell.blueScoreLabel?.text = String(round.blueScore)
            
            let hasScore = round.redScore != 0 && round.blueScore != 0
            cell.selectionStyle = hasScore ? .None : .Default
            cell.userInteractionEnabled = !hasScore
            cell.roundNumberLabel.enabled = !hasScore
            cell.blueScoreLabel.enabled = !hasScore
            cell.redScoreLabel.enabled = !hasScore

        }
        
        return cell
        
    }
    
    //MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "passToRoundDetail"{
            let destinationVC = segue.destinationViewController as! BSRoundDetailScore
            destinationVC.redFighter = redCornerFighter
            destinationVC.blueFighter = blueCornerFighter
            
            let indexPath = tableView.indexPathForSelectedRow
            let passRound = roundsArray[(indexPath?.row)!]
            destinationVC.currentRound = passRound
            print("PassedRound:\(passRound)")
            print("CALLED SEGUE")
        }
    }

}