//
//  BSRoundsTableView.swift
//  BoxingScoreCard
//
//  Created by Jamaal Sedayao on 2/16/16.
//  Copyright © 2016 Jamaal Sedayao. All rights reserved.
//

import UIKit

class BSRoundsTableView: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    let tapRec = UITapGestureRecognizer()
    let tapRec2 = UITapGestureRecognizer()
    
    @IBOutlet var blueCornerView: UIView!
    @IBOutlet var redCornerView: UIView!
    @IBOutlet var tableView: UITableView!
    
    var rounds = 1
    
    func displayUI(){
        redCornerView.layer.borderWidth = 1.0
        blueCornerView.layer.borderWidth = 1.0
        redCornerView.layer.borderColor = (UIColor.redColor()).CGColor
        blueCornerView.layer.borderColor = (UIColor.blueColor()).CGColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayUI()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        redCornerView.addGestureRecognizer(tapRec)
        redCornerView.userInteractionEnabled = true
        tapRec.addTarget(self, action: "tappedView")
        
        blueCornerView.addGestureRecognizer(tapRec2)
        blueCornerView.userInteractionEnabled = true
        tapRec2.addTarget(self, action: "tappedView")
        
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        rounds += 1
    }
    
    func tappedView(){

        let tapAlert = UIAlertController(title: "Tapped", message: "You just tapped the tap view", preferredStyle: UIAlertControllerStyle.Alert)
        tapAlert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
        self.presentViewController(tapAlert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func endFightButtonTapped(sender: AnyObject) {
        
        print("button works!")
        
        
    }
    //MARK: - TableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rounds + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        if indexPath.row < self.rounds{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath:indexPath) as UITableViewCell
        
        cell.textLabel?.text = "Round \(rounds)"
       
        return cell
            
        } else {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("endFightIdentifier", forIndexPath: indexPath)
        return cell
        }

}
}

