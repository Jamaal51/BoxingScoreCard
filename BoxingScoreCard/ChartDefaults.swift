//
//  ChartDefaults.swift
//  BoxingScoreCard
//
//  Created by Jamaal Sedayao on 2/16/16.
//  Copyright © 2016 Jamaal Sedayao. All rights reserved.
//

import UIKit
import SwiftCharts

struct ExamplesDefaults {
    
    static var chartSettings: ChartSettings {
        return self.iPhoneChartSettings
    }

//    private static var iPadChartSettings: ChartSettings {
//        let chartSettings = ChartSettings()
//        chartSettings.leading = 20
//        chartSettings.top = 20
//        chartSettings.trailing = 20
//        chartSettings.bottom = 20
//        chartSettings.labelsToAxisSpacingX = 10
//        chartSettings.labelsToAxisSpacingY = 10
//        chartSettings.axisTitleLabelsToLabelsSpacing = 5
//        chartSettings.axisStrokeWidth = 1
//        chartSettings.spacingBetweenAxesX = 15
//        chartSettings.spacingBetweenAxesY = 15
//        return chartSettings
//    }
    
    private static var iPhoneChartSettings: ChartSettings {
        let chartSettings = ChartSettings()
        chartSettings.leading = 2
        chartSettings.top = 2
        chartSettings.trailing = 2
        chartSettings.bottom = 2
        chartSettings.labelsToAxisSpacingX = 5
        chartSettings.labelsToAxisSpacingY = 5
        chartSettings.axisTitleLabelsToLabelsSpacing = 4
        chartSettings.axisStrokeWidth = 0.2
        chartSettings.spacingBetweenAxesX = 8
        chartSettings.spacingBetweenAxesY = 8
        return chartSettings
    }
    
    static func chartFrame(containerBounds: CGRect) -> CGRect {
        return CGRectMake(0, 70, containerBounds.size.width - 250, containerBounds.size.height - 70)
    }
    
    static var labelSettings: ChartLabelSettings {
        return ChartLabelSettings(font: ExamplesDefaults.labelFont)
    }
    
    static var labelFont: UIFont {
        return ExamplesDefaults.fontWithSize(11)
    }
    
    static var labelFontSmall: UIFont {
        return ExamplesDefaults.fontWithSize(10)
    }
    
    static func fontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: "Helvetica", size: size) ?? UIFont.systemFontOfSize(size)
    }
    
    static var guidelinesWidth: CGFloat {
        return 0.1
    }
    
    static var minBarSpacing: CGFloat {
        return 5
    }
}
