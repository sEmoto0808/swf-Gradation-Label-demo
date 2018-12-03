//
//  ViewController.swift
//  swf-Gradation-demo
//
//  Created by Sho Emoto on 2018/11/28.
//  Copyright © 2018年 Sho Emoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var baseView: UIView! {
        didSet {
            baseView.backgroundColor = UIColor(named: "notTargetColor")
        }
    }
    @IBOutlet weak var gradationView: UIStackView!
    @IBOutlet var gradeLabels: [UILabel]! {
        didSet {
            gradeLabels.forEach {
                $0.backgroundColor = .clear
                $0.textColor = .white
                $0.font = UIFont.systemFont(ofSize: CGFloat(11))
            }
        }
    }
    
    // MARK: - Properties
    
    private var gradePositions = [CGRect]()
    private let targets = ["1":"none",
                           "2":"none",
                           "3":"none",
                           "4":"none",
                           "5":"none",
                           "6":"low",
                           "7":"low",
                           "8":"high",
                           "9":"none"]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGradePositions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setSubTarget()
        setMainTarget()
    }
}

// MARK: - File Extension
extension ViewController {
    
    private func setGradePositions() {
        
        gradeLabels.forEach { gradePositions.append($0.frame) }
    }
    
    private func setSubTarget() {
        
        let targetView = TargetGradeView()
        let position = targetView.getSubTargetPosition()
        let targetCount = targetView.getTargetCount()
        
        gradeLabels.forEach {
            if $0.tag >= position + 1 && $0.tag <= position + targetCount {
                $0.text = ""
            }
        }
        
        targetView.createSubTargetView(rect: gradePositions[position],
                                       gradeWidth: gradePositions[0].size.width)
        
        gradationView.addSubview(targetView)
    }
    
    private func setMainTarget() {
        
        let targetView = TargetGradeView()
        let position = targetView.getMainTargetPosition()
        gradeLabels[position].text = ""
        let mainLabel = targetView.createMainLabel(rect: gradePositions[position],
                                                   gradeWidth: gradePositions[0].size.width)
        
        gradationView.addSubview(mainLabel)
    }
}
