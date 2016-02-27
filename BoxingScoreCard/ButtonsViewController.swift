//
//  ButtonsViewController.swift
//  BoxingScoreCard
//
//  Created by Jamaal Sedayao on 2/26/16.
//  Copyright © 2016 Jamaal Sedayao. All rights reserved.
//

import UIKit

class ButtonsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // rotateLandscape()
     

        // Do any additional setup after loading the view.
    }
    
    func rotateLandscape(){
        let value = UIInterfaceOrientation.LandscapeRight.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
