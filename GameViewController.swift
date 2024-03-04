//
//  GameViewController.swift
//  spritekittest
//
//  Created by Николай Лаврентьев on 02.01.2023.
//

import UIKit
import SpriteKit
import GameplayKit

var rewardedAdHelper = RewardedAdHelper()

class GameViewController: UIViewController {



    override func viewDidLoad() {
        super.viewDidLoad()
        rewardedAdHelper.loadRewardedAd()

        MusicPlayer.shared.startBackgroundMusic()
    
        
        let defaults = UserDefaults.standard
        highScoreNumber = defaults.integer(forKey: scoreKey)
        highscoreLabel.update(with: String(highScoreNumber))
        
        isUranusSelected = defaults.bool(forKey: uranusKey)
        isSunSelected = defaults.bool(forKey: sunKey)
        isNeptuneSelected = defaults.bool(forKey: neptuneKey)
        isGalaxySelected = defaults.bool(forKey: galaxyKey)
        
        sunCanBeSelected = defaults.bool(forKey: sunKey1)
        neptuneCanBeSelected = defaults.bool(forKey: neptuneKey1)
        galaxyCanBeSelected = defaults.bool(forKey: galaxyKey1)
        
        
        money = defaults.integer(forKey: moneyKey)
        hasSeenJumpTutorial = defaults.bool(forKey: jumpKey)
        hasSeenAsteroidTutorial = defaults.bool(forKey: asteroidKey)
        hasSeenDeathstarTutorial = defaults.bool(forKey: deathstarKey)

        
        print(highScoreNumber)
        print(money)
        

        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
//            view.showsFPS = true
//            view.showsNodeCount = true
        }
    }
    

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
