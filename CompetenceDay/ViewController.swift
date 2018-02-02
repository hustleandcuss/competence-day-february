//
//  ViewController.swift
//  CompetenceDay
//
//  Created by Olivia Lennerö on 2018-01-12.
//  Copyright © 2018 Olivia Lennerö. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

class ViewController: UIViewController {
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var highScoreLabel: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var objectLabel: UILabel!
    @IBOutlet var topView: UIView!
    @IBOutlet var bottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
