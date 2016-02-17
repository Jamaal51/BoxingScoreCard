//
//  BSRoundsTableView.swift
//  BoxingScoreCard
//
//  Created by Jamaal Sedayao on 2/16/16.
//  Copyright © 2016 Jamaal Sedayao. All rights reserved.
//

import UIKit

class BSRoundsTableView: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var blueCornerView: UIView!
    @IBOutlet var redCornerView: UIView!
    @IBOutlet var tableView: UITableView!
    
    var rounds = ["Round 1", "Round 2", "Round 3"]
    
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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rounds.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath:indexPath) as UITableViewCell
        
        cell.textLabel?.text = rounds[indexPath.row]
        
        return cell
    }
    
}


