//
//  SpaceShop.swift
//  spritekittest
//
//  Created by Николай Лаврентьев on 27.01.2023.
//

import Foundation
import SpriteKit
import EFCountingLabel

var isUranusSelected: Bool = true
var isSunSelected: Bool = false
var isNeptuneSelected: Bool = false
var isGalaxySelected: Bool = false

var sunCanBeSelected: Bool = false
var neptuneCanBeSelected: Bool = false
var galaxyCanBeSelected: Bool = false

var uranusKey: String = "uranusKey"
var sunKey: String = "sunKey"
var neptuneKey: String = "neptuneKey"
var galaxyKey: String = "galaxyKey"

var sunKey1: String = "sunKey1"
var neptuneKey1: String = "neptuneKey1"
var galaxyKey1: String = "galaxyKey1"

var moneyLabel = EFCountingLabel()


extension UIResponder {
    public var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}

class SpaceShop : SKScene {
    
    
    let defaults = UserDefaults.standard
    
    var bg : SKSpriteNode?
    var videobutton : UIButton?
    var backbutton: UIButton?
    
    var coinImage: SKSpriteNode?
    let screenSize: CGRect = UIScreen.main.bounds
    let ratio: Double = UIScreen.main.bounds.height / UIScreen.main.bounds.width
    
    var title : SKSpriteNode?
    var moreCoins: SKLabelNode?
    
    var uranus: SKSpriteNode?
    var sun: SKSpriteNode?
    var neptune: SKSpriteNode?
    var galaxy: SKSpriteNode?
    
    var uranusName: SKLabelNode?
    var sunName: SKLabelNode?
    var neptuneName: SKLabelNode?
    var galaxyName: SKLabelNode?
    
    
    var uranusButton: SKSpriteNode?
    var sunButton: SKSpriteNode?
    var neptuneButton: SKSpriteNode?
    var galaxyButton: SKSpriteNode?
    
    var sunPrice: Int = 100
    var neptunePrice: Int = 500
    var galaxyPrice: Int = 1000
    
    let changetoselect = SKAction.setTexture(SKTexture(imageNamed: "select"))
    let changetoselected = SKAction.setTexture(SKTexture(imageNamed: "selected"))
    


    
    override func didMove(to view: SKView) {

        
        createBg()
        createMoney()
        createTitle()
        if (doAdsWork == true) {
            createVideo()
        }
        displayEverything()

        
        print(ratio)
        

        
        
        backbutton = UIButton(frame: CGRect(x: view.frame.midX - 65, y: view.frame.midY + view.frame.height / 3, width: 130, height: 50))
        if screenSize.height == 1024.0 || screenSize.height == 1180.0 || screenSize.height == 1112.0 || screenSize.height == 1194 || screenSize.height == 1366.0 {
            backbutton = UIButton(frame: CGRect(x: view.frame.midX - 65, y: view.frame.midY + view.frame.height / 2.5, width: 130, height: 50))
        }
        backbutton?.addTarget(self, action: #selector(goHome), for: .touchUpInside)
        backbutton?.layer.zPosition = 15
        self.view!.addSubview(backbutton!)
        UIView.animate(withDuration: 1) {
            self.backbutton!.setImage(UIImage(named: "home"), for: .normal)
        }
    }
    
    func createVideo() {
        print(screenSize.height)
        print(ratio)
        videobutton = UIButton()
        videobutton? = UIButton(frame: CGRect(x: view!.frame.midX - frame.width / 4, y: self.frame.midY + 80, width: 50, height: 50))
        if ratio >= 2.165 && ratio <= 2.166 {
            videobutton? = UIButton(frame: CGRect(x: view!.frame.midX - frame.width / 4.5, y: self.frame.midY + 70, width: 50, height: 50))
        }
        if ratio >= 1.76 && ratio <= 1.78 {
            videobutton? = UIButton(frame: CGRect(x: view!.frame.midX - frame.width / 4.5, y: self.frame.midY + 60, width: 50, height: 50))
        }
        if ratio >= 2.164 && ratio <= 2.165 {
            videobutton? = UIButton(frame: CGRect(x: view!.frame.midX - frame.width / 4.5, y: self.frame.midY + 70, width: 50, height: 50))
        }
        if screenSize.height == 896.0 {
            videobutton? = UIButton(frame: CGRect(x: view!.frame.midX - frame.width / 4.3, y: self.frame.midY + 75, width: 50, height: 50))
        }
        if UIDevice.current.userInterfaceIdiom == .pad{
            videobutton? = UIButton(frame: CGRect(x: view!.frame.midX - frame.width / 3, y: self.frame.midY + 80, width: 50, height: 50))
        }
        if screenSize.height == 1133.0 {
            videobutton? = UIButton(frame: CGRect(x: view!.frame.midX - frame.width / 3, y: self.frame.midY + 90, width: 50, height: 50))
        }
        if ratio >= 1.33 && ratio <= 1.34 {
            videobutton? = UIButton(frame: CGRect(x: view!.frame.midX - frame.width / 2.5, y: self.frame.midY + 80, width: 50, height: 50))
        }
        if ratio >= 1.438 && ratio <= 1.44 {
            videobutton? = UIButton(frame: CGRect(x: view!.frame.midX - frame.width / 2.8, y: self.frame.midY + 95, width: 50, height: 50))
        }
        if ratio >= 1.431 && ratio <= 1.432 {
            videobutton? = UIButton(frame: CGRect(x: view!.frame.midX - frame.width / 2.8, y: self.frame.midY + 95, width: 50, height: 50))
        }
        if screenSize.height == 1366.0{
            videobutton? = UIButton(frame: CGRect(x: view!.frame.midX - frame.width / 2.4, y: self.frame.midY + 95, width: 50, height: 50))
        }
        if screenSize.height == 1180.0 {
            videobutton? = UIButton(frame: CGRect(x: view!.frame.midX - frame.width / 2.5, y: self.frame.midY + 100, width: 50, height: 50))
        }
        if screenSize.height == 1112.0 {
            videobutton? = UIButton(frame: CGRect(x: view!.frame.midX - frame.width / 2.5, y: self.frame.midY + 90, width: 50, height: 50))
        }
        if screenSize.height == 1194.0 {
            videobutton? = UIButton(frame: CGRect(x: view!.frame.midX - frame.width / 2.6, y: self.frame.midY + 100, width: 50, height: 50))
        }
        if screenSize.height == 1366.0 {
            videobutton? = UIButton(frame: CGRect(x: view!.frame.midX - frame.width / 2.1, y: self.frame.midY + 110, width: 50, height: 50))
        }
        if screenSize.height == 812.0 {
            videobutton? = UIButton(frame: CGRect(x: view!.frame.midX - frame.width / 4.5, y: self.frame.midY + 65, width: 50, height: 50))
        }
        if screenSize.height == 667.0 {
            videobutton? = UIButton(frame: CGRect(x: view!.frame.midX - frame.width / 5, y: self.frame.midY + 50, width: 50, height: 50))
        }
        if screenSize.height == 852.0 {
            videobutton? = UIButton(frame: CGRect(x: view!.frame.midX - frame.width / 4.3, y: self.frame.midY + 70, width: 50, height: 50))
        }
        
        videobutton!.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        videobutton?.layer.zPosition = 15
        self.view!.addSubview(videobutton!)
        UIView.animate(withDuration: 0.5) {
            self.videobutton!.setImage(UIImage(named: "video"), for: .normal)
        }
        
        moreCoins = SKLabelNode(text: "More Coins!")
        moreCoins!.fontName = "' RonySiswadi Architect 4"
        moreCoins!.fontColor = .white
        moreCoins!.fontSize = 40
        moreCoins!.zPosition = 15
        moreCoins!.position = CGPoint(x: self.frame.midX - 70, y: self.frame.midY + self.frame.height / 2.65)
        if UIDevice.current.userInterfaceIdiom == .pad{
            moreCoins!.position = CGPoint(x: self.frame.midX - self.frame.width / 8, y: self.frame.midY + self.frame.height / 3.5)
        }
        if screenSize.height == 1133.0 {
            moreCoins!.position = CGPoint(x: self.frame.midX - self.frame.width / 8, y: self.frame.midY + self.frame.height / 3.05)
        }
        if ratio >= 1.438 && ratio <= 1.44 {
            moreCoins!.position = CGPoint(x: self.frame.midX - self.frame.width / 8, y: self.frame.midY + self.frame.height / 3.3)
        }
        if ratio >= 1.431 && ratio <= 1.432 {
            moreCoins!.position = CGPoint(x: self.frame.midX - self.frame.width / 8, y: self.frame.midY + self.frame.height / 3.3)
        }
        if screenSize.height == 1366.0{
            moreCoins!.position = CGPoint(x: self.frame.midX - self.frame.width / 8, y: self.frame.midY + self.frame.height / 3.5)
        }
        addChild(moreCoins!)
    }
    
    
    func createBg() {
        bg = SKSpriteNode(imageNamed: "bgShop")
        bg!.position = CGPoint(x: 0, y: 0)
        bg!.size.width = self.size.width
        bg!.size.height = self.size.height
        bg!.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        bg?.zPosition = 0
        self.addChild(bg!)
    }
    
    
    func createMoney() {
        coinImage = SKSpriteNode(imageNamed: "money")
        coinImage!.alpha = 1
        coinImage!.zPosition = 10
        coinImage!.size = CGSize(width: 80, height: 80)
        coinImage!.position = CGPoint(x: self.frame.maxX / 3.5, y: self.frame.midY + self.frame.height / 2.6)
        if UIDevice.current.userInterfaceIdiom == .pad {
            coinImage!.position = CGPoint(x: self.frame.maxX / 2.5, y: self.frame.midY + self.frame.height / 3.4)
         }
        if ratio >= 1.52 && ratio <= 1.53 {
            coinImage!.position = CGPoint(x: self.frame.maxX / 2.5, y: self.frame.midY + self.frame.height / 3)
        }
        if ratio >= 1.43 && ratio <= 1.44 {
            coinImage!.position = CGPoint(x: self.frame.maxX / 2.5, y: self.frame.midY + self.frame.height / 3.2)
        }
        self.addChild(coinImage!)

        
        moneyLabel = EFCountingLabel(frame: CGRect(center: CGPoint(x: screenSize.maxX * 0.87, y: screenSize.midY / 4.6), size: CGSize(width: 100, height: 80)))
        if screenSize.height == 1024.0 {
            moneyLabel = EFCountingLabel(frame: CGRect(center: CGPoint(x: screenSize.maxX * 0.87, y: screenSize.midY / 4.7), size: CGSize(width: 100, height: 80)))
        }
        if screenSize.height == 812.0 {
            moneyLabel = EFCountingLabel(frame: CGRect(center: CGPoint(x: screenSize.maxX * 0.92, y: screenSize.midY / 4.6), size: CGSize(width: 100, height: 80)))
        }
        if screenSize.height == 896.0 || screenSize.height == 844.0 || screenSize.height == 926.0 || screenSize.height == 852.0 {
            moneyLabel = EFCountingLabel(frame: CGRect(center: CGPoint(x: screenSize.maxX * 0.9, y: screenSize.midY / 4.6), size: CGSize(width: 100, height: 80)))
        }
        
        moneyLabel.setUpdateBlock { value, label in
            let blackFormat = [NSAttributedString.Key.font : UIFont(name: "' RonySiswadi Architect 4", size: 35), NSAttributedString.Key.foregroundColor: UIColor.white]
            let blackMoney = NSMutableAttributedString(string: String(Int(value)), attributes:blackFormat as [NSAttributedString.Key : Any])
            label.attributedText = blackMoney
        }
        moneyLabel.countFrom(CGFloat(money), to: CGFloat(money))
        moneyLabel.layer.zPosition = 15
        self.view?.addSubview(moneyLabel)
    }
    
    func createTitle() {
        title = SKSpriteNode(imageNamed: "titlespaceshop")
        title!.alpha = 1
        title!.zPosition = 10
        title!.size = CGSize(width: 440, height: 70)
        title!.position = CGPoint(x: self.frame.midX, y: self.frame.midY + self.frame.height / 4)
        if UIDevice.current.userInterfaceIdiom == .pad{
            title!.position = CGPoint(x: self.frame.midX, y: self.frame.midY + self.frame.height / 4.5)
        }
        self.addChild(title!)
    }
    
    func displayEverything() {
        uranus = SKSpriteNode(imageNamed: "uranus")
        uranus!.size = CGSize(width: 100, height: 100)
        uranus!.zPosition = 10
        uranus!.position = CGPoint(x: self.frame.midX - self.frame.width / 4, y: self.frame.midY + 170)
        addChild(uranus!)
        
        sun = SKSpriteNode(imageNamed: "sun")
        sun!.size = CGSize(width: 100, height: 100)
        sun!.zPosition = 10
        sun!.position = CGPoint(x: self.frame.midX - self.frame.width / 4, y: self.frame.midY + 10)
        addChild(sun!)
        
        neptune = SKSpriteNode(imageNamed: "neptune")
        neptune!.size = CGSize(width: 100, height: 100)
        neptune!.zPosition = 10
        neptune!.position = CGPoint(x: self.frame.midX - self.frame.width / 4, y: self.frame.midY - 150)
        addChild(neptune!)
        
        galaxy = SKSpriteNode(imageNamed: "galaxy")
        galaxy!.size = CGSize(width: 100, height: 100)
        galaxy!.zPosition = 10
        galaxy!.position = CGPoint(x: self.frame.midX - self.frame.width / 4, y: self.frame.midY - 310)
        addChild(galaxy!)
        
        uranusName = SKLabelNode(text: "Uranus Hero")
        uranusName!.fontName = "' RonySiswadi Architect 4"
        uranusName!.fontColor = .white
        uranusName!.fontSize = 30
        uranusName!.zPosition = 15
        uranusName!.position = CGPoint(x: self.frame.midX - 20, y: self.frame.midY + 165)
        addChild(uranusName!)
        
        sunName = SKLabelNode(text: "Sun Savior")
        sunName!.fontName = "' RonySiswadi Architect 4"
        sunName!.fontColor = .white
        sunName!.fontSize = 30
        sunName!.zPosition = 15
        sunName!.position = CGPoint(x: self.frame.midX - 27, y: self.frame.midY + 5)
        addChild(sunName!)
        
        neptuneName = SKLabelNode(text: "Neptune Guard")
        neptuneName!.fontName = "' RonySiswadi Architect 4"
        neptuneName!.fontColor = .white
        neptuneName!.fontSize = 30
        neptuneName!.zPosition = 15
        neptuneName!.position = CGPoint(x: self.frame.midX - 2, y: self.frame.midY - 155)
        addChild(neptuneName!)
        
        galaxyName = SKLabelNode(text: "Galaxy God")
        galaxyName!.fontName = "' RonySiswadi Architect 4"
        galaxyName!.fontColor = .white
        galaxyName!.fontSize = 30
        galaxyName!.zPosition = 15
        galaxyName!.position = CGPoint(x: self.frame.midX - 23, y: self.frame.midY - 315)
        addChild(galaxyName!)
        
        
        
        if isUranusSelected == true {
            uranusButton = SKSpriteNode(imageNamed: "selected")
        }
        else {
            uranusButton = SKSpriteNode(imageNamed: "select")
        }
        uranusButton!.name = "uranusbutton"
        uranusButton!.size = CGSize(width: 122, height: 70)
        uranusButton!.zPosition = 10
        uranusButton!.position = CGPoint(x: self.frame.midX + self.frame.width / 4, y: self.frame.midY + 170)
        addChild(uranusButton!)
        
        if isSunSelected == true {
            sunButton = SKSpriteNode(imageNamed: "selected")
        }
        else if isSunSelected == false && sunCanBeSelected == true {
            sunButton = SKSpriteNode(imageNamed: "select")
        }
        else {
            sunButton = SKSpriteNode(imageNamed: "100")
        }
        sunButton!.name = "sunbutton"
        sunButton!.size = CGSize(width: 122, height: 70)
        sunButton!.zPosition = 10
        sunButton!.position = CGPoint(x: self.frame.midX + self.frame.width / 4, y: self.frame.midY + 10)
        addChild(sunButton!)
        
        if isNeptuneSelected == true {
            neptuneButton = SKSpriteNode(imageNamed: "selected")
        }
        else if isNeptuneSelected == false && neptuneCanBeSelected == true {
            neptuneButton = SKSpriteNode(imageNamed: "select")
        }
        else {
            neptuneButton = SKSpriteNode(imageNamed: "500")
        }
        neptuneButton!.name = "neptunebutton"
        neptuneButton!.size = CGSize(width: 122, height: 70)
        neptuneButton!.zPosition = 10
        neptuneButton!.position = CGPoint(x: self.frame.midX + self.frame.width / 4, y: self.frame.midY - 150)
        addChild(neptuneButton!)
        
        
        if isGalaxySelected == true {
            galaxyButton = SKSpriteNode(imageNamed: "selected")
        }
        else if isGalaxySelected == false && galaxyCanBeSelected == true {
            galaxyButton = SKSpriteNode(imageNamed: "select")
        }
        else {
            galaxyButton = SKSpriteNode(imageNamed: "1000")
        }
        galaxyButton!.name = "galaxybutton"
        galaxyButton!.size = CGSize(width: 122, height: 70)
        galaxyButton!.zPosition = 10
        galaxyButton!.position = CGPoint(x: self.frame.midX + self.frame.width / 4, y: self.frame.midY - 310)
        addChild(galaxyButton!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "uranusbutton" {
                if isUranusSelected == false {
                    uranusButton?.run(changetoselected)
                    if sunCanBeSelected == true {
                        sunButton?.run(changetoselect)
                    }
                    if neptuneCanBeSelected == true {
                        neptuneButton?.run(changetoselect)
                    }
                    if galaxyCanBeSelected == true {
                        galaxyButton?.run(changetoselect)
                    }
                    isUranusSelected = true
                    isSunSelected = false
                    isNeptuneSelected = false
                    isGalaxySelected = false
                    
                    defaults.set(isUranusSelected, forKey: uranusKey)
                    defaults.set(isSunSelected, forKey: sunKey)
                    defaults.set(isNeptuneSelected, forKey: neptuneKey)
                    defaults.set(isGalaxySelected, forKey: galaxyKey)
                }
            }
            if touchedNode.name == "sunbutton" {
                if sunCanBeSelected == true {
                    sunButton?.run(changetoselected)
                    uranusButton?.run(changetoselect)
                    if neptuneCanBeSelected == true {
                        neptuneButton?.run(changetoselect)
                    }
                    if galaxyCanBeSelected == true {
                        galaxyButton?.run(changetoselect)
                    }
                    isUranusSelected = false
                    isSunSelected = true
                    isNeptuneSelected = false
                    isGalaxySelected = false
                    
                    defaults.set(isUranusSelected, forKey: uranusKey)
                    defaults.set(isSunSelected, forKey: sunKey)
                    defaults.set(isNeptuneSelected, forKey: neptuneKey)
                    defaults.set(isGalaxySelected, forKey: galaxyKey)
                }
                else if money > sunPrice && isSunSelected == false {
                    money -= sunPrice
                    defaults.set(money, forKey: moneyKey)
                    moneyLabel.countFrom(CGFloat(money), to: CGFloat(money))
                    sunButton?.run(changetoselect)
                    sunCanBeSelected = true
                    
                    defaults.set(sunCanBeSelected, forKey: sunKey1)
                    defaults.set(neptuneCanBeSelected, forKey: neptuneKey1)
                    defaults.set(galaxyCanBeSelected, forKey: galaxyKey1)
                }
            }
            if touchedNode.name == "neptunebutton" {
                if neptuneCanBeSelected == true {
                    neptuneButton?.run(changetoselected)
                    uranusButton?.run(changetoselect)
                    if sunCanBeSelected == true {
                        sunButton?.run(changetoselect)
                    }
                    if galaxyCanBeSelected == true {
                        galaxyButton?.run(changetoselect)
                    }
                    isUranusSelected = false
                    isSunSelected = false
                    isNeptuneSelected = true
                    isGalaxySelected = false
                    
                    defaults.set(isUranusSelected, forKey: uranusKey)
                    defaults.set(isSunSelected, forKey: sunKey)
                    defaults.set(isNeptuneSelected, forKey: neptuneKey)
                    defaults.set(isGalaxySelected, forKey: galaxyKey)
                }
                else if money > neptunePrice && isNeptuneSelected == false {
                    money -= neptunePrice
                    defaults.set(money, forKey: moneyKey)
                    moneyLabel.countFrom(CGFloat(money), to: CGFloat(money))
                    neptuneButton?.run(changetoselect)
                    neptuneCanBeSelected = true
                    
                    defaults.set(sunCanBeSelected, forKey: sunKey1)
                    defaults.set(neptuneCanBeSelected, forKey: neptuneKey1)
                    defaults.set(galaxyCanBeSelected, forKey: galaxyKey1)
                }
            }
            if touchedNode.name == "galaxybutton" {
                if galaxyCanBeSelected == true {
                    galaxyButton?.run(changetoselected)
                    uranusButton?.run(changetoselect)
                    if sunCanBeSelected == true {
                        sunButton?.run(changetoselect)
                    }
                    if neptuneCanBeSelected == true {
                        neptuneButton?.run(changetoselect)
                    }
                    isUranusSelected = false
                    isSunSelected = false
                    isNeptuneSelected = false
                    isGalaxySelected = true
                    
                    defaults.set(isUranusSelected, forKey: uranusKey)
                    defaults.set(isSunSelected, forKey: sunKey)
                    defaults.set(isNeptuneSelected, forKey: neptuneKey)
                    defaults.set(isGalaxySelected, forKey: galaxyKey)
                }
                else if money > galaxyPrice && isGalaxySelected == false {
                    money -= galaxyPrice
                    defaults.set(money, forKey: moneyKey)
                    moneyLabel.countFrom(CGFloat(money), to: CGFloat(money))
                    galaxyButton?.run(changetoselect)
                    galaxyCanBeSelected = true
                    
                    defaults.set(sunCanBeSelected, forKey: sunKey1)
                    defaults.set(neptuneCanBeSelected, forKey: neptuneKey1)
                    defaults.set(galaxyCanBeSelected, forKey: galaxyKey1)
                }
            }
        }
    }
    @objc func goHome(sender: UIButton!) {
        SoundPlayer.shared.playSoundEffect(soundEffect: "button")
        
        backbutton?.removeFromSuperview()
        moneyLabel.removeFromSuperview()
        videobutton?.removeFromSuperview()
        removeAllChildren()
        
        let sceneOne = GameScene(fileNamed: "GameScene")
        sceneOne?.scaleMode = .aspectFill
        self.view?.presentScene(sceneOne!)
    }
    @objc func playVideo(sender: UIButton!) {
        rewardedAdHelper.showRewardedAd(viewController: self.view!.window!.rootViewController!)
    }
    
}
