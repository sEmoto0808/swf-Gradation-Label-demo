//
//  TargetGradeView.swift
//  swf-Gradation-demo
//
//  Created by Sho Emoto on 2018/11/29.
//  Copyright © 2018年 Sho Emoto. All rights reserved.
//

import UIKit

final class TargetGradeView: UIView {
    
    private let radius: CGFloat = 10
    private let targets = ["1":"none",
                           "2":"none",
                           "3":"none",
                           "4":"none",
                           "5":"none",
                           "6":"low",
                           "7":"high",
                           "8":"low",
                           "9":"none"]
    
    func createSubTargetView(rect: CGRect, gradeWidth: CGFloat) {
        
        self.frame = rect
        
        self.cornerRadius = radius
        
        self.backgroundColor = UIColor(named: "subTargetColor")
        self.frame.size.width = gradeWidth * CGFloat(getTargetCount())
        
        var gradeTexts = createGradeTexts(targetCount: getTargetCount(),
                                          position: getSubTargetPosition() + 1,
                                          mainTarget: getMainTargetPosition())
        for i in 0..<getTargetCount() {
            let subLabel = UILabel()
            subLabel.frame.origin.x = gradeWidth * CGFloat(i)
            subLabel.frame.size.width = gradeWidth
            subLabel.frame.size.height = rect.size.height
            subLabel.text = gradeTexts[i]
            subLabel.textColor = .white
            subLabel.textAlignment = .center
            subLabel.font = UIFont.systemFont(ofSize: CGFloat(11))
            subLabel.backgroundColor = UIColor(named: "subTargetColor")
            self.addSubview(subLabel)
        }
    }
    
    func createMainLabel(rect: CGRect, gradeWidth: CGFloat) -> UILabel {
        
        let mainLabel = UILabel()
        mainLabel.frame = rect
        mainLabel.frame.origin.x = gradeWidth * CGFloat(getMainTargetPosition())
        mainLabel.cornerRadius = radius
        
        mainLabel.backgroundColor = UIColor(named: "mainTargetColor")
        mainLabel.frame.size.width = gradeWidth
        
        mainLabel.text = getMainTargetPosition() < 6 ? "小\(getMainTargetPosition() + 1)":"中\(getMainTargetPosition() + 1 - 6)"
        mainLabel.textAlignment = .center
        mainLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(11))
        mainLabel.textColor = .white
        
        return mainLabel
    }
    
    func getTargetCount() -> Int {
        
        var targetCount = 0
        targets.forEach {
            if $0.value == "low" || $0.value == "high" {
                targetCount += 1
            }
        }
        
        return targetCount
    }
    
    func getSubTargetPosition() -> Int {
        
        var targetGrade = "99"
        for target in targets {
            if target.value == "low" {
                if Int(targetGrade) ?? 99 >= Int(target.key) ?? 99 {
                    targetGrade = target.key
                }
            }
        }
        guard let targetPosition = Int(targetGrade) else { return 99}
        return targetPosition - 1
    }
    
    func getMainTargetPosition() -> Int {
        
        guard let targetGrade = targets.first(where: { $0.value == "high"})?.key,
            let targetPosition = Int(targetGrade) else { return 99}
        return targetPosition - 1
    }
}

// MARK: - File Extension
extension TargetGradeView {
    
    private func createGradeTexts(targetCount: Int, position: Int, mainTarget: Int) -> [String] {
        var gradeTexts = [String]()
        
        for t in 0..<targetCount {
            var gradeText = ""
            if position + t <= 6 {
                gradeText = "小\(position + t)"
            } else {
                gradeText = "中\(position + t - 6)"
            }
            
            if position + t == mainTarget + 1 {
                gradeText = ""
            }
            gradeTexts.append(gradeText)
        }
        return gradeTexts
    }
}
