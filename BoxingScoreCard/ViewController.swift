//
//  Fight Summary View Controller
//
//  ViewController.swift
//  BoxingScoreCard
//
//  Created by Jamaal Sedayao on 2/16/16.
//  Copyright © 2016 Jamaal Sedayao. All rights reserved.
//

import UIKit
import SwiftCharts


class ViewController: UIViewController {
    
    @IBOutlet var myView: UIView!
    
    var redFighter: Fighter!
    var blueFighter: Fighter!
    
    //Points Variables
    var redPunch = Double()
    var redDefense = Double()
    var redEffAgg = Double()
    var redRingGen = Double()
    var bluePunch = Double()
    var blueDefense = Double()
    var blueEffAgg = Double()
    var blueRingGen = Double()
    
    var blueKnockedDown = 0
    var redKnockedDown = 0
    var redPointDed = 0
    var bluePointDed = 0
    
    //Chart Variables
    private var chart: Chart?
    private let dirSelectorHeight: CGFloat = 30
    
    //Fight Summary Variables
    @IBOutlet var redFighterLabel: UILabel!
    @IBOutlet var redKnockdownLabel: UILabel!
    @IBOutlet var redPointsDedLabel: UILabel!
    @IBOutlet var redFighterSuggScore: UILabel!
    @IBOutlet var blueFighterLabel: UILabel!
    @IBOutlet var blueKnockdownLabel: UILabel!
    @IBOutlet var bluePointsDedLabel: UILabel!
    @IBOutlet var blueSuggScoreLabel: UILabel!
    var redFighterScore = Int()
    var blueFighterScore = Int()
    
    //Select Round Winner
    @IBOutlet var redScoreLabel: UILabel!
    @IBOutlet var blueScoreLabel: UILabel!
    @IBOutlet var roundWinnerSelector: UISegmentedControl!
    @IBOutlet var closeRoundSwitch: UISwitch!
    var roundWinner: Fighter?
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        myView.layer.borderWidth = 0.5
        myView.layer.borderColor = (UIColor.blackColor()).CGColor
        rotatePortrait()
        calculateSuggestedScore()
       // populateLabelsAtLoad()

        roundWinnerSelector.setTitle(redFighter.lastName, forSegmentAtIndex: 0)
        roundWinnerSelector.setTitle(blueFighter.lastName, forSegmentAtIndex: 1)
        roundWinnerSelector.tintColor = UIColor.darkGrayColor()
        
        self.showChart(horizontal: false)
        if let chart = self.chart {
            let dirSelector = DirSelector(frame: CGRectMake(0, chart.frame.origin.y + chart.frame.size.height, self.myView.frame.size.width, self.dirSelectorHeight), controller: self)
            self.myView.addSubview(dirSelector)
        }
            
    }
    
    func rotatePortrait(){
        let value = UIInterfaceOrientation.Portrait.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
    }
    
    func populateLabelsAtLoad(){
        redFighterLabel.text = self.redFighter!.lastName
        blueFighterLabel.text = self.blueFighter!.lastName
        redKnockdownLabel.text = String(blueKnockedDown)
        blueKnockdownLabel.text = String(redKnockedDown)
        redPointsDedLabel.text = String(redPointDed)
        bluePointsDedLabel.text = String(bluePointDed)
        redFighterSuggScore.text = String(redFighterScore)
        blueSuggScoreLabel.text = String(blueFighterScore)
        redScoreLabel.text = String(redFighterScore)
        blueScoreLabel.text = String(blueFighterScore)
        
        if roundWinner?.lastName == redFighter.lastName || roundWinner?.lastName == nil {
          roundWinnerSelector.selectedSegmentIndex = 0
        } else {
            roundWinnerSelector.selectedSegmentIndex = 1
        }
    }
    
    func calculateSuggestedScore(){
        let redPointsTotal = redPunch + redDefense + redEffAgg + redRingGen
        let bluePointsTotal = bluePunch + blueDefense + blueEffAgg + blueRingGen
        
        //if no knockdowns
        if redKnockedDown == 0 && blueKnockedDown == 0 {
            if redPointsTotal > bluePointsTotal {
                redFighterScore = 10
                blueFighterScore = 9
                roundWinner = redFighter
            } else if bluePointsTotal > redPointsTotal {
                blueFighterScore = 10
                redFighterScore = 9
                roundWinner = blueFighter
            } else {
                blueFighterScore = 10
                redFighterScore = 10
            }
        }
    
        //if blue wins by knockdown
        if redKnockedDown >= 1 && blueKnockedDown == 0 {
            roundWinner = blueFighter
            blueFighterScore = 10
            redFighterScore = 9 - redKnockedDown
        }
        
        //if red wins by knockdown
        if blueKnockedDown >= 1 && redKnockedDown == 0 {
            roundWinner = redFighter
            redFighterScore = 10
            blueFighterScore = 9 - blueKnockedDown
        }
        
        //if both red and blue have knockdowns
        if blueKnockedDown >= 1 && redKnockedDown >= 1 {
            if blueKnockedDown == redKnockedDown{
                redFighterScore = 10
                blueFighterScore = 10
            } else if blueKnockedDown > redKnockedDown {
                roundWinner = redFighter
                redFighterScore = 10
                let knockDownDifference = blueKnockedDown - redKnockedDown
                blueFighterScore = 9 - knockDownDifference
            } else if redKnockedDown > blueKnockedDown {
                roundWinner = blueFighter
                blueFighterScore = 10
                let knockDownDifference = redKnockedDown - blueKnockedDown
                redFighterScore = 9 - knockDownDifference
            }
            
        }
        
        redFighterScore -= redPointDed
        blueFighterScore -= bluePointDed
        
        populateLabelsAtLoad()
    }
    
    @IBAction func segmentControlAction(sender: UISegmentedControl) {
        
    
        
        
    }

//MARK: SegueToRoot
    
    @IBAction func finishRoundTapped(sender: UIButton) {
        //self.navigationController!.popToRootViewControllerAnimated(true)
        
        let rootView = self.navigationController!.viewControllers.first as! BSRoundsTableView
        rootView.passedData = "DATA PASS WORKS!"
        self.navigationController!.popToRootViewControllerAnimated(true)
        
    }

//MARK: Initiate Graph

    func barsChart(horizontal horizontal: Bool) -> Chart {
        
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
        let groupsData: [(title: String, [(min: Double, max: Double)])] = [
            ("Punches", [
                (0, redPunch),
                (0, bluePunch),
                ]),
            ("Defense", [
                (0, redDefense),
                (0, blueDefense),
                ]),
            ("Eff-Agg", [
                (0, redEffAgg),
                (0, blueEffAgg),
                ]),
            ("Ring-Gen", [
                (0, redRingGen),
                (0, blueRingGen),
                ])
        ]
        
        let groupColors = [UIColor.redColor().colorWithAlphaComponent(0.6), UIColor.blueColor().colorWithAlphaComponent(0.6)]
        
        let groups: [ChartPointsBarGroup] = groupsData.enumerate().map {index, entry in
            let constant = ChartAxisValueDouble(index)
            let bars = entry.1.enumerate().map {index, tuple in
                ChartBarModel(constant: constant, axisValue1: ChartAxisValueDouble(tuple.min), axisValue2: ChartAxisValueDouble(tuple.max), bgColor: groupColors[index])
            }
            return ChartPointsBarGroup(constant: constant, bars: bars)
        }
        
        let (axisValues1, axisValues2): ([ChartAxisValue], [ChartAxisValue]) = (
            0.stride(through: 40, by: 5).map {ChartAxisValueDouble(Double($0), labelSettings: labelSettings)},
            [ChartAxisValueString(order: -1)] +
                groupsData.enumerate().map {index, tuple in ChartAxisValueString(tuple.0, order: index, labelSettings: labelSettings)} +
                [ChartAxisValueString(order: groupsData.count)]
        )
        let (xValues, yValues) = horizontal ? (axisValues1, axisValues2) : (axisValues2, axisValues1)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Categories", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Points", settings: labelSettings.defaultVertical()))
        let frame = ExamplesDefaults.chartFrame(self.myView.bounds)
        let chartFrame = self.chart?.frame ?? CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height - self.dirSelectorHeight)
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: ExamplesDefaults.chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxis, yAxis, innerFrame) = (coordsSpace.xAxis, coordsSpace.yAxis, coordsSpace.chartInnerFrame)
        
        let groupsLayer = ChartGroupedPlainBarsLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, groups: groups, horizontal: horizontal, barSpacing: 0, groupSpacing: 5, animDuration: 0.5)
        
        let settings = ChartGuideLinesLayerSettings(linesColor: UIColor.blackColor(), linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesLayer(xAxis: xAxis, yAxis: yAxis, innerFrame: innerFrame, axis: horizontal ? .X : .Y, settings: settings)
        
        return Chart(
            frame: chartFrame,
            layers: [
                xAxis,
                yAxis,
                guidelinesLayer,
                groupsLayer
            ]
        )
    }
    
    func showChart(horizontal horizontal: Bool) {
        self.chart?.clearView()
        
        let chart = self.barsChart(horizontal: horizontal)
        self.myView.addSubview(chart.view)
        self.chart = chart
    }
    
    class DirSelector: UIView {
        
        let horizontal: UIButton
        let vertical: UIButton
        
        weak var controller: ViewController?
        
        private let buttonDirs: [UIButton : Bool]
        
        init(frame: CGRect, controller: ViewController) {
            
            self.controller = controller
            
            self.horizontal = UIButton()
            self.horizontal.setTitle("Horizontal", forState: .Normal)
            self.vertical = UIButton()
            self.vertical.setTitle("Vertical", forState: .Normal)
            
            self.buttonDirs = [self.horizontal : true, self.vertical : false]
            
            super.init(frame: frame)
            
            self.addSubview(self.horizontal)
            self.addSubview(self.vertical)
            
            for button in [self.horizontal, self.vertical] {
                button.titleLabel?.font = ExamplesDefaults.fontWithSize(14)
                button.setTitleColor(UIColor.blueColor(), forState: .Normal)
                button.addTarget(self, action: "buttonTapped:", forControlEvents: .TouchUpInside)
            }
        }
        
        func buttonTapped(sender: UIButton) {
            let horizontal = sender == self.horizontal ? true : false
            controller?.showChart(horizontal: horizontal)
        }
        
        override func didMoveToSuperview() {
            let views = [self.horizontal, self.vertical]
            for v in views {
                v.translatesAutoresizingMaskIntoConstraints = false
            }
            
            let namedViews = views.enumerate().map{index, view in
                ("v\(index)", view)
            }
            
            let viewsDict = namedViews.reduce(Dictionary<String, UIView>()) {(var u, tuple) in
                u[tuple.0] = tuple.1
                return u
            }
            
            let buttonsSpace: CGFloat = 10
            
            let hConstraintStr = namedViews.reduce("H:|") {str, tuple in
                "\(str)-(\(buttonsSpace))-[\(tuple.0)]"
            }
            
            let vConstraits = namedViews.flatMap {NSLayoutConstraint.constraintsWithVisualFormat("V:|[\($0.0)]", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict)}
            
            self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(hConstraintStr, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict)
                + vConstraits)
        }
        
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
    }
    
    
    
// MARK: Fight Summary Bottom View
    
    
    
    
    
}

