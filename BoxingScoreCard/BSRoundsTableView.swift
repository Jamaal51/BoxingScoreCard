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
    var usedRoundsArray = [Rounds]()
    
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
        
        let lastRound = roundsArray.removeAtIndex(0)
        
        usedRoundsArray.append(lastRound)
        
        currentRound = usedRoundsArray.last
        
        print("The Round is:\(currentRound.value)")

        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "testNotification", name: "sendBackData", object: nil)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationController?.navigationBarHidden = true
        self.tableView.userInteractionEnabled = false
        self.tableView.backgroundColor = UIColor.grayColor()
        topViewLabel.text = "Choose Fighters"
        
        
    }
    @IBAction func backButton(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Done?", message: "This fight has not been saved. If you go back your scorecard will be lost.", preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (ACTION) -> Void in
            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func testNotification(){
        
        let lastRound = roundsArray.removeAtIndex(0)
        
        usedRoundsArray.append(lastRound)
        
        currentRound = usedRoundsArray.last
        
        print("Current Round is now \(currentRound.value)")
        
        //print("Notification works!")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        tableView.reloadData()
        //checkCurrentRound()
        
        print("The Round is:\(currentRound.value)")
        
//        if self.passedData != nil {
//        print("Data Passed: \(self.passedData!)")
//        }
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
        let round11 = Rounds(value: 11)
        let round12 = Rounds(value: 12)
        
        roundsArray = [round1,round2, round3, round4, round5, round6, round7, round8, round9, round10, round11,round12]
        
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
        redNameLabel.text = "\(redFighter.firstName!) \(redFighter.lastName!)"
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
        blueNameLabel.text = "\(blueFighter.firstName!) \(blueFighter.lastName!)"
        blueDivisionLabel.text = "Division: \(blueFighter.weightDivision!)"
        blueStanceLabel.text = "Stance:\(blueFighter.stance!)"
        let image: UIImage = UIImage(named: blueFighter.imageString!)!
        blueCornerImageView.image = image
        
        if redCornerFighter != nil {
            tableView.userInteractionEnabled = true
            topViewLabel.text = "\(redCornerFighter!.lastName!) vs. \(blueCornerFighter!.lastName!)"
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
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedRoundsArray.count
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
            
            let round = usedRoundsArray[indexPath.row]
            cell.roundNumberLabel?.text = "\(round.value)"
            cell.redScoreLabel?.text = String(round.redScore)
            cell.blueScoreLabel?.text = String(round.blueScore)

            let hasScore = round.redScore != 0 && round.blueScore != 0
            cell.selectionStyle = hasScore ? .None : .Default
            cell.userInteractionEnabled = !hasScore
            cell.roundNumberLabel.enabled = !hasScore
            cell.blueScoreLabel.enabled = !hasScore
            cell.redScoreLabel.enabled = !hasScore
        
//            
//        } else {
//            
//            let round = roundsArray[indexPath.row]
//            
//            cell.roundNumberLabel?.text = "Round \(round.value)"
//            cell.redScoreLabel?.text = String(round.redScore)
//            cell.blueScoreLabel?.text = String(round.blueScore)
//            
//            let hasScore = round.redScore != 0 && round.blueScore != 0
//            cell.selectionStyle = hasScore ? .None : .Default
//            cell.userInteractionEnabled = !hasScore
//            cell.roundNumberLabel.enabled = !hasScore
//            cell.blueScoreLabel.enabled = !hasScore
//            cell.redScoreLabel.enabled = !hasScore
//
        }
        
        return cell
        
    }
    
    //MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "passToRoundDetail"{
            let destinationVC = segue.destinationViewController as! BSRoundDetailScore
            destinationVC.redFighter = redCornerFighter
            destinationVC.blueFighter = blueCornerFighter
            destinationVC.currentRound = currentRound
            print("PassedRound:\(currentRound.value)")
        }
    }

}