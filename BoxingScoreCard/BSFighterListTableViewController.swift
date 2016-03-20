//
//  BSFighterListTableViewController.swift
//  
//
//  Created by Jamaal Sedayao on 2/23/16.
//
//

import UIKit

protocol RedFighterSelectedDelegate{
    func userDidSelectRedFighter(redFighter:Fighter)
}
protocol BlueFighterSelectedDelegate{
    func userDidSelectBlueFighter(blueFighter:Fighter)
}

class BSFighterListTableViewController: UITableViewController {
    
    var fightersArray = [Fighter]()
    var delegateRed: RedFighterSelectedDelegate? = nil
    var delegateBlue: BlueFighterSelectedDelegate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.topItem?.title = "Choose Your Fighter"
        initiateData()
    
    }

    func initiateData(){
        
        let rayLeonard = Fighter(firstName: "Ray", lastName: "Leonard", weight: "147", height: "5'10", wins:36, losses: 3, imageString: "rayLeonard", weightDivision:"Welterweight", stance: "Orthodox", country:"USA")
        rayLeonard.knockouts = 25
        //rayLeonard.nickName = "Sugar"
    
        
        let marvinHagler = Fighter(firstName: "Marvin", lastName: "Hagler", weight: "160", height: "5'9", wins: 62, losses: 3, imageString: "marvinHagler", weightDivision:"Middleweight", stance: "SouthPaw", country: "USA")
        marvinHagler.knockouts = 52
        marvinHagler.nickName = "Marvelous"
        
        let thomasHearns = Fighter(firstName: "Thomas", lastName: "Hearns", weight: "154", height: "6'1", wins: 61, losses: 5, imageString: "thomasHearns", weightDivision: "Super Welterweight", stance: "Orthodox", country: "USA")
        thomasHearns.knockouts = 48
        thomasHearns.nickName = "Hitman"
        
        let robertoDuran = Fighter(firstName: "Roberto", lastName: "Duran", weight: "147", height: "5'7", wins: 103, losses: 16, imageString: "robertoDuran", weightDivision: "Welterweight", stance: "Orthodox", country: "Panama")
        robertoDuran.knockouts = 70
        robertoDuran.nickName = "Manos De Piedra"
        
        fightersArray.append(marvinHagler)
        fightersArray.append(rayLeonard)
        fightersArray.append(thomasHearns)
        fightersArray.append(robertoDuran)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fightersArray.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Fighters"
        }
        return ""
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let fighter = fightersArray[indexPath.row] as Fighter!
        
        if (delegateRed != nil){
            delegateRed?.userDidSelectRedFighter(fighter)
        }
        
        if (delegateBlue != nil){
            delegateBlue?.userDidSelectBlueFighter(fighter)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("fighterIdentifier", forIndexPath: indexPath) as! CustomFighterTableViewCell
        
        let fighter = fightersArray[indexPath.row] as Fighter!
        
        cell.nameLabel.text = "\(fighter.firstName!) \(fighter.lastName!)"
        
        if (fighter.nickName != nil){
            cell.nicknameLabel.text = "Alias: \(fighter.nickName!)"
        } else {
            cell.nicknameLabel.text = "Alias: n/a"
        }
        
        cell.weightLabel.text = "\(fighter.weight!) lbs."
        cell.heightLabel.text = "Ht: \(fighter.height!)"
        cell.recordLabel.text = "\(fighter.wins!) W - \(fighter.losses!) L, \(fighter.knockouts!)KOs"
        cell.countryLabel.text = "Origin: \(fighter.country!)"
        cell.divisionLabel.text = fighter.weightDivision!
        cell.stanceLabel.text = "Stance: \(fighter.stance!)"
        let image : UIImage = UIImage(named: fighter.imageString!)!
        cell.fighterImage?.image = image
        
        return cell
    }

}
