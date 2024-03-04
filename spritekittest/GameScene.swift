//
//  GameScene.swift
//  spritekittest
//
//  Created by Николай Лаврентьев on 02.01.2023.
//

import SpriteKit
import GameplayKit
import EFCountingLabel


extension CGRect
{
    init(center: CGPoint, size: CGSize)
    {
        self.init(x: center.x - size.width / 2, y: center.y - size.height / 2, width: size.width, height: size.height)
    }
    var center: CGPoint
        {
        get { return CGPoint(x: centerX, y: centerY) }
        set { centerX = newValue.x; centerY = newValue.y }
    }
    var centerX: CGFloat
        {
        get { return midX }
        set { origin.x = newValue - width * 0.5 }
    }
    var centerY: CGFloat
        {
        get { return midY }
        set { origin.y = newValue - height * 0.5 }
    }
}


var highScoreNumber : Int = 0
var money : Int = 0
var oldmoney : Int = 0
var hasSeenJumpTutorial: Bool = false
var hasSeenAsteroidTutorial: Bool = false
var hasSeenDeathstarTutorial: Bool = false
var isTutorialOn: Bool = false
var highscoreLabel = ScoreLabel()
let scoreKey = "scoreKey"
let moneyKey = "moneyKey"
let jumpKey = "jumpKey"
let asteroidKey = "asteroidKey"
let deathstarKey = "deathstarKey"

var space1: SKTexture = SKTexture(imageNamed: "Frame 2")
var space2: SKTexture = SKTexture(imageNamed: "Frame 2-1")
var space3: SKTexture = SKTexture(imageNamed: "Frame 2-2")
var space4: SKTexture = SKTexture(imageNamed: "Frame 2-3")
var space5: SKTexture = SKTexture(imageNamed: "Frame 2-4")
var space6: SKTexture = SKTexture(imageNamed: "Frame 2-5")
var space7: SKTexture = SKTexture(imageNamed: "Frame 2-6")
var space8: SKTexture = SKTexture(imageNamed: "Frame 2-7")
var space9: SKTexture = SKTexture(imageNamed: "Frame 2-8")
var space10: SKTexture = SKTexture(imageNamed: "Frame 2-9")
var space11: SKTexture = SKTexture(imageNamed: "Frame 2-10")
var spaceTextures : [SKTexture] = [space1,
                                   space2,
                                   space3,
                                   space4,
                                   space5,
                                   space6,
                                   space7,
                                   space8,
                                   space9,
                                   space10,
                                   space9,
                                   space8,
                                   space7,
                                   space6,
                                   space5,
                                   space4,
                                   space3,
                                   space2]

var doIhaveUranus: Bool = true
var doIhaveSun: Bool = false
var doIhaveNeptune: Bool = false
var doIhaveGalaxy: Bool = false

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var bg : SKSpriteNode?
    private var floor : SKSpriteNode?
    var tutorialJump : SKSpriteNode?
    var tutorialAsteroid: SKSpriteNode?
    var tutorialDeath: SKSpriteNode?
    var developerInfo: SKSpriteNode?
    var developerBack: SKSpriteNode?


    
    
    var balls = [Ball]()
    var enemyballs = [EnemyBall]()
    var evilenemyballs = [EvilEnemyBall]()
    var deathballs = [DeathBall]()
    
    var scoreLabel : ScoreLabel!
    var niceLanding : ScoreLabel!
    var isHighscoreLabelOn: Bool = false
    var score : Int = 0
    var allScores = [Int]()
    var isScoreLabelOn : Bool = false
    var leftOrRight: Bool = false
    
    var isCountdownUp: Bool = false
    var countdownDuration: Int = 15
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    
    var timerEndgame = Timer()
    var timerSpawn = Timer()
    var timerSpace = Timer()
    var timerResumableEndgame : ResumableTimer?
    var timerTutorial = Timer()
    var isResumableTimerWorking : Bool = false
    
    var restartButton: UIButton?
    var pauseButton: UIButton?
    var resumeButton: UIButton?
    var tutorialButton: UIButton?
    var homeButton: UIButton?
    var musicButton: UIButton?
    var infoButton: UIButton?
    var isItRestart: Bool = false
    var isRandomBad: Bool = false
    var isGamePaused: Bool = false
    var isItNotFirstTouch: Bool = false
    var isPauseButtonThere: Bool = false
    var isItNewHighscore: Bool = false
    var isItGameOver: Bool = false
    
    
    let bgColor = UIColor(red: 173/255, green: 239/255, blue: 209/255, alpha: 1)
    let floorColor = UIColor(red: 75/255, green: 110/255, blue: 117/255, alpha: 1)
    let ballColor = UIColor(red: 200/255, green: 255/255, blue: 200/255, alpha: 1)
    let grayColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
    
    let fadein = SKAction.fadeIn(withDuration: 1)
    let fadeout = SKAction.fadeOut(withDuration: 1)
    let blurEffect = UIBlurEffect()
    let blurEffectView = UIVisualEffectView()
    var tapTheScreen : SKSpriteNode?
    var title : SKSpriteNode?
    var startTime = TimeInterval()
    var pauseTime: Double = 0
    var surviveTime: Double = 0
    
    var bgGameover : SKSpriteNode?
    var results : SKLabelNode?
    var scoreResult : SKLabelNode?
    var timeResult : SKLabelNode?
    var highscoreResult : SKLabelNode?
    var isDelay3: Bool = false
    var isDelay2: Bool = false
    
    var shopButton: UIButton?
    let screenSize: CGRect = UIScreen.main.bounds
    let ratio: Double = UIScreen.main.bounds.height / UIScreen.main.bounds.width
    
    let asteroid = SKTexture(imageNamed: "grayasteroid")
    let spaceship =  SKTexture(imageNamed: "submarine")
    let deathstar =  SKTexture(imageNamed: "deathstarskull")
    let useddeathstar = SKTexture(imageNamed: "useddeathstar")
    let changetoused = SKAction.setTexture(SKTexture(imageNamed: "useddeathstar"))
    
    let defaults = UserDefaults.standard
    var moneyLabel = EFCountingLabel()
    var coinImage: SKSpriteNode?
    
    var isGameGoing: Bool = false
    var isItGoingHome: Bool = false
    

    
    override func didMove(to view: SKView) {
        print(isUranusSelected)
        print(isSunSelected)
        print(isNeptuneSelected)
        print(isGalaxySelected)
        print(" ")
        print("hasSeenJumpTutorial " + String(hasSeenJumpTutorial))
        print("hasSeenAsteroidTutorial " + String(hasSeenAsteroidTutorial))
        print("hasSeenDeathstarTutorial " + String(hasSeenDeathstarTutorial))
        print("isTutorialOn " + String(isTutorialOn))
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)

        
            
        if highScoreNumber > 0 {
            putHighscorelabel()
        }

        createTutorialTap()
        if hasSeenAsteroidTutorial == false || isTutorialOn == true {
            createTutorialAsteroid()
        }
        if hasSeenDeathstarTutorial == false || isTutorialOn == true {
            createTutorialDeath()
        }
        createTitle()
        

        spawnBall()
        createShop()
        createBg()
        createFloor()
        surroundSceneWithBorder()
        


        
        
        view.ignoresSiblingOrder = true
        //view.showsDrawCount = true
        physicsWorld.speed = 0.9999
        physicsWorld.contactDelegate = self
    }
    
    func createShop() {
        shopButton = UIButton(frame: CGRect(x: view!.frame.midX + frame.width / 5.5, y: self.frame.midY + UIScreen.main.bounds.height * 0.9, width: 50, height: 50))
        if UIDevice.current.userInterfaceIdiom == .pad {
            shopButton = UIButton(frame: CGRect(x: self.frame.midX + 20, y: self.frame.midY + UIScreen.main.bounds.height * 0.88, width: 100, height: 100))
            }
        if UIScreen.main.bounds.height == 1080.0 {
            shopButton = UIButton(frame: CGRect(x: self.frame.midX + 20, y: self.frame.midY + UIScreen.main.bounds.height * 0.91, width: 70, height: 70))
            }
        if UIScreen.main.bounds.height == 1112.0 {
            shopButton = UIButton(frame: CGRect(x: self.frame.midX + 20, y: self.frame.midY + UIScreen.main.bounds.height * 0.93, width: 60, height: 60))
            }
        if screenSize.height == 1112.0 {
            shopButton = UIButton(frame: CGRect(x: self.frame.midX + 20, y: self.frame.midY + UIScreen.main.bounds.height * 0.9, width: 100, height: 100))
            }
        if screenSize.height == 812.0 || screenSize.height == 667.0 {
            shopButton = UIButton(frame: CGRect(x: view!.frame.midX + frame.width / 6, y: self.frame.midY + UIScreen.main.bounds.height * 0.9, width: 50, height: 50))
            }

        
        shopButton!.addTarget(self, action: #selector(shop), for: .touchUpInside)
        
        self.view!.addSubview(shopButton!)
        UIView.animate(withDuration: 1) {
            self.shopButton!.setImage(UIImage(named: "shop"), for: .normal)
        }
        
    }
    
    
    func createMoney() {
        if isItGameOver == true {
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
            moneyLabel.countFrom(CGFloat(oldmoney), to: CGFloat(money))
            moneyLabel.layer.zPosition = 15
            self.view?.addSubview(moneyLabel)
            isItGameOver = false
        }
    }
    
    
    func createBg() {
        bg = SKSpriteNode(imageNamed: "Frame 2")
        bg!.position = CGPoint(x: 0, y: 0)
        bg!.size.width = self.size.width
        bg!.size.height = self.size.height
        bg!.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        bg?.zPosition = 0
        self.addChild(bg!)
        backgroundAnimation(space: bg!)
    }
    
    func createFloor() {
        floor = SKSpriteNode(imageNamed: "floor")
        floor!.size = CGSize(width: self.frame.width, height: self.frame.height / 4.6)
        floor!.position = CGPoint(x: self.frame.midX, y: self.frame.minY)
        if UIDevice.current.userInterfaceIdiom == .pad {
            floor!.position = CGPoint(x: self.frame.midX, y: self.frame.minY + UIScreen.main.bounds.height * 0.12)
         }
        
        if UIScreen.main.bounds.height == 1024.0 {
            floor!.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
         }

        
        floor!.zPosition = 5
        self.addChild(floor!)
        let floorPhysics = SKPhysicsBody(rectangleOf: CGSize(width: (floor?.size.width)!, height: (floor?.size.height)!))
        floorPhysics.categoryBitMask = PhysicsCategories.floorObstacle
        floorPhysics.collisionBitMask = PhysicsCategories.ball | PhysicsCategories.enemyball | PhysicsCategories.evilenemyball
        floorPhysics.contactTestBitMask = PhysicsCategories.ball | PhysicsCategories.enemyball | PhysicsCategories.evilenemyball
        floorPhysics.fieldBitMask = PhysicsCategories.none
        floorPhysics.pinned = true
        floorPhysics.allowsRotation = false
        floor!.physicsBody = floorPhysics
    }

    func modelIdentifier() -> String {
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
    
    func createGameOver() {
        bgGameover = SKSpriteNode(imageNamed: "rectangle")
        bgGameover!.size = CGSize(width: 400, height: 350)
        bgGameover!.zPosition = 10
        bgGameover!.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 60)
        
        results = SKLabelNode(text: "Results")
        results!.fontName = "' RonySiswadi Architect 4"
        results!.fontColor = .black
        results!.fontSize = 50
        results!.zPosition = 15
        results!.position = CGPoint(x: self.frame.midX - 70, y: self.frame.midY + 180)
        
        scoreResult = SKLabelNode()
        let scoreStr = "Score: "
        let grayText = [NSAttributedString.Key.font : UIFont(name: "' RonySiswadi Architect 4", size: 25), NSAttributedString.Key.foregroundColor: UIColor(red: 121/255, green: 128/255, blue: 121/255, alpha: 1)]
        let blackText = [NSAttributedString.Key.font : UIFont(name: "' RonySiswadi Architect 4", size: 25), NSAttributedString.Key.foregroundColor: UIColor.black]
        let grayScore = NSMutableAttributedString(string: scoreStr, attributes: grayText as [NSAttributedString.Key : Any])
        let blackScore = NSMutableAttributedString(string: String(score), attributes:blackText as [NSAttributedString.Key : Any])
        grayScore.append(blackScore)
        scoreResult!.attributedText = grayScore
        scoreResult!.zPosition = 15
        scoreResult!.position = CGPoint(x: self.frame.midX - 180, y: self.frame.midY + 120)
        scoreResult!.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        
        timeResult = SKLabelNode()
        let timeStr = "Survive time: "
        let grayTime = NSMutableAttributedString(string: timeStr, attributes: grayText as [NSAttributedString.Key : Any])
//        var blackTime = NSMutableAttributedString(string: String(Double(round(1000 * surviveTime) / 1000)), attributes:blackText)
        let blackTime = NSMutableAttributedString(string: String(Int(surviveTime)), attributes:blackText as [NSAttributedString.Key : Any])
        blackTime.append(NSMutableAttributedString(string: " sec", attributes: blackText as [NSAttributedString.Key : Any]))
        grayTime.append(blackTime)
        timeResult!.attributedText = grayTime
        timeResult!.zPosition = 15
        timeResult!.position = CGPoint(x: self.frame.midX - 180, y: self.frame.midY + 90)
        timeResult!.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        
        highscoreResult = SKLabelNode()
        let highStr = "Highscore: "
        let grayHigh = NSMutableAttributedString(string: highStr, attributes: grayText as [NSAttributedString.Key : Any])
        let blackHigh = NSMutableAttributedString(string: String(highScoreNumber), attributes:blackText as [NSAttributedString.Key : Any])
        if isItNewHighscore == true {
            blackHigh.append(NSMutableAttributedString(string: " | New Highscore!", attributes: grayText as [NSAttributedString.Key : Any]))
            isItNewHighscore = false
        }
        grayHigh.append(blackHigh)
        highscoreResult!.attributedText = grayHigh
        highscoreResult!.zPosition = 15
        highscoreResult!.position = CGPoint(x: self.frame.midX - 180, y: self.frame.midY + 60)
        highscoreResult!.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        
        
        if
            let view = self.view ,
            let _ = view.scene as? GameScene
        {
            restartButton = UIButton()
            restartButton?.frame = CGRect(x: view.frame.midX - UIScreen.main.bounds.width / 3.3, y: view.frame.midY, width: UIScreen.main.bounds.width / 1.65, height: UIScreen.main.bounds.height / 13.3)
            if ratio < 2 {
                restartButton?.frame = CGRect(x: view.frame.midX - UIScreen.main.bounds.width / 4, y: view.frame.midY, width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 13.3)
             }
            if UIDevice.current.userInterfaceIdiom == .pad{
                restartButton?.frame = CGRect(x: view.frame.midX - UIScreen.main.bounds.width / 4, y: view.frame.midY, width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 10)
             }
            if ratio >= 1.5 && ratio < 1.53 {
                restartButton?.frame = CGRect(x: view.frame.midX - UIScreen.main.bounds.width / 4, y: view.frame.midY - 15, width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 10)
            }
            restartButton!.addTarget(self, action: #selector(restartTheGame), for: .touchUpInside)
            restartButton?.layer.zPosition = 15
            self.view!.addSubview(restartButton!)
            UIView.animate(withDuration: 1) {
                self.restartButton!.setImage(UIImage(named: "rest"), for: .normal)
            }
        }
        
        
        self.addChild(bgGameover!)
        self.addChild(results!)
        self.addChild(scoreResult!)
        self.addChild(timeResult!)
        self.addChild(highscoreResult!)

        createMoney()
    }
    
    func createPauseButton() {
        pauseButton = UIButton(frame: CGRect(x: self.frame.midX + 20, y: self.frame.midY + UIScreen.main.bounds.height * 0.9, width: 50, height: 50))
        if UIDevice.current.userInterfaceIdiom == .pad {
            pauseButton = UIButton(frame: CGRect(x: self.frame.midX + 20, y: self.frame.midY + UIScreen.main.bounds.height * 0.88, width: 100, height: 100))
         }
        if UIScreen.main.bounds.height == 1080.0 {
            pauseButton = UIButton(frame: CGRect(x: self.frame.midX + 20, y: self.frame.midY + UIScreen.main.bounds.height * 0.91, width: 70, height: 70))
         }
        if UIScreen.main.bounds.height == 1112.0 {
            pauseButton = UIButton(frame: CGRect(x: self.frame.midX + 20, y: self.frame.midY + UIScreen.main.bounds.height * 0.93, width: 60, height: 60))
         }
        pauseButton!.addTarget(self, action: #selector(pauseTheGame), for: .touchUpInside)
        
        self.view!.addSubview(pauseButton!)
        UIView.animate(withDuration: 1) {
            self.pauseButton!.setImage(UIImage(named: "pause"), for: .normal)
        }
    }
    
    func createTitle() {
        title = SKSpriteNode(imageNamed: "title")
        title!.alpha = 1
        title!.zPosition = 10
        title!.size = CGSize(width: 440, height: 60)
        title!.position = CGPoint(x: self.frame.midX, y: self.frame.midY + self.frame.height / 4)
        self.addChild(title!)
    }
    
    func createTutorialTap() {
        tapTheScreen = SKSpriteNode(imageNamed: "tap")
        tapTheScreen!.alpha = 1
        tapTheScreen!.zPosition = 10
        tapTheScreen!.size = CGSize(width: 220, height: 40)
        tapTheScreen!.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(tapTheScreen!)
        let moveAction1 = SKAction.move(to: CGPoint(x: frame.midX, y: frame.midY - 100), duration: 2)
        let moveAction2 = SKAction.move(to: CGPoint(x: frame.midX, y: frame.midY), duration: 2)
        tapTheScreen?.run(moveAction1)
        timerTutorial = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) {_ in
            if self.tapTheScreen?.position == CGPoint(x: self.frame.midX, y: self.frame.midY - 100) {
                self.tapTheScreen?.run(moveAction2)
            }
            if self.tapTheScreen?.position == CGPoint(x: self.frame.midX, y: self.frame.midY) {
                self.tapTheScreen?.run(moveAction1)
            }
        }
        if self.tapTheScreen?.isHidden == true {
            timerTutorial.invalidate()
        }
    }
    
    func createTutorialJump() {
        _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [self]_ in
            tutorialJump = SKSpriteNode(imageNamed: "tutorialjump")
            tutorialJump!.alpha = 0
            tutorialJump!.zPosition = 1
            tutorialJump!.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            if UIDevice.current.userInterfaceIdiom == .phone && screenSize.height != 667.0 {
                tutorialJump?.size = CGSize(width: UIScreen.main.bounds.width * 1.5, height: UIScreen.main.bounds.height * 1.5)
            }
            self.addChild(tutorialJump!)
            tutorialJump!.run(fadein)
        }
    }
    
    func createTutorialAsteroid() {
        tutorialAsteroid = SKSpriteNode(imageNamed: "tutorialasteroidgray")
        tutorialAsteroid!.alpha = 0
        tutorialAsteroid!.zPosition = 1
        tutorialAsteroid!.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        if UIDevice.current.userInterfaceIdiom == .phone && screenSize.height != 667.0 {
            tutorialAsteroid?.size = CGSize(width: UIScreen.main.bounds.width * 1.5, height: UIScreen.main.bounds.height * 1.5)
        }
        self.addChild(tutorialAsteroid!)
    }
    
    func createTutorialDeath() {
        tutorialDeath = SKSpriteNode(imageNamed: "tutorialdeathstar")
        tutorialDeath!.alpha = 0
        tutorialDeath!.zPosition = 1
        tutorialDeath!.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        if UIDevice.current.userInterfaceIdiom == .phone && screenSize.height != 667.0 {
            tutorialDeath?.size = CGSize(width: UIScreen.main.bounds.width * 1.5, height: UIScreen.main.bounds.height * 1.5)
        }
        self.addChild(tutorialDeath!)
    }
    
    func createCountdown() {
        isCountdownUp = true
        
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: view!.frame.midX, y: view!.frame.midY - view!.frame.height / 3 - 30), radius: 50, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        view!.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 0
        view!.layer.addSublayer(shapeLayer)

        

        basicAnimation.toValue = 1
        basicAnimation.duration = CFTimeInterval(countdownDuration)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.shouldRasterize = true
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        view?.layer.shouldRasterize = true
    }
    
    func resetAnimation() {
        shapeLayer.removeAllAnimations()
        
        basicAnimation.toValue = 1
        basicAnimation.duration = CFTimeInterval(countdownDuration)
        basicAnimation.fillMode = CAMediaTimingFillMode.removed
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        
        timerResumableEndgame?.invalidate()
        if score >= 3 || isItRestart == true {
            timerResumableEndgame = ResumableTimer(interval: basicAnimation.duration) { [weak self] in
                if self!.isItGameOver == false {
                    self?.killAllBalls()
                    self?.isItGameOver = true
                    self?.endTheGame()
                }
            }
            timerResumableEndgame?.start()
            isResumableTimerWorking = true
        }
    }
    
    
    func backgroundAnimation(space: SKSpriteNode) {
        SKTexture.preload(spaceTextures) {
            let animate = SKAction.animate(with: spaceTextures, timePerFrame: 0.2)
            let forever = SKAction.repeatForever(animate)
            space.run(forever)
        }
    }
    

    
    
    func surroundSceneWithBorder() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = PhysicsCategories.borderObstacle
        self.physicsBody?.collisionBitMask = PhysicsCategories.ball
    }
    
    func spawnBall() {
        var ball = Ball()
        if isSunSelected == true {
            ball = Ball(texture: spaceship,
                            color: .yellow,
                            size: CGSize(width: 100, height: 100))
        }
        else if isNeptuneSelected == true {
            ball = Ball(texture: spaceship,
                            color: .cyan,
                            size: CGSize(width: 100, height: 100))
        }
        else if isGalaxySelected == true {
            ball = Ball(texture: spaceship,
                            color: .magenta,
                            size: CGSize(width: 100, height: 100))
        }
        else if isUranusSelected == true {
            ball = Ball(texture: spaceship,
                            color: ballColor,
                            size: CGSize(width: 100, height: 100))
        }
        else {
            ball = Ball(texture: spaceship,
                            color: ballColor,
                            size: CGSize(width: 100, height: 100))
            isUranusSelected = true
        }
        ball.position = CGPoint(x: frame.midX, y: frame.midY - frame.height / 4)
        balls.append(ball)
        isItGameOver = false
        self.addChild(ball)
    }
    
    func createEnemyBall(xpos: Int, ypos: Int, ximp: Int, yimp: Int, color: UIColor) {
        let enemyball = EnemyBall(texture: asteroid,
                                  color: color,
                                  size: CGSize(width: 50, height: 50))
        enemyball.position = CGPoint(x: xpos, y: ypos)
        self.addChild(enemyball)
        ballApplyImpulse(ball: enemyball, vx: ximp, vy: yimp)
        enemyballs.append(enemyball)
    }
    
    func createEvilEnemyBall(xpos: Int, ypos: Int, ximp: Int, yimp: Int, color: UIColor) {
        let evilenemyball = EvilEnemyBall(texture: spaceship,
                                          color: color,
                                          size: CGSize(width: 50, height: 50))
        evilenemyball.position = CGPoint(x: xpos, y: ypos)
        self.addChild(evilenemyball)
        ballApplyImpulse(ball: evilenemyball, vx: ximp, vy: yimp)
        evilenemyballs.append(evilenemyball)
    }
    
    func createDeathBall(xpos: Int, ypos: Int, ximp: Int, yimp: Int, color: UIColor) {
        let deathball = DeathBall(texture: deathstar,
                                          color: color,
                                          size: CGSize(width: 60, height: 60))
        deathball.position = CGPoint(x: xpos, y: ypos)
        self.addChild(deathball)
        ballApplyImpulse(ball: deathball, vx: ximp, vy: yimp)
        deathballs.append(deathball)
    }
        
    func despawnEnemyBall() {
        for enemyball in enemyballs {
            if enemyball.position.x > frame.midX + frame.width || enemyball.position.x < frame.midX - frame.width || enemyball.position.y > frame.height {
                enemyball.removeFromParent()
            }
        }
        for evilenemyball in evilenemyballs {
            if evilenemyball.position.x > frame.midX + frame.width || evilenemyball.position.x < frame.midX - frame.width || evilenemyball.position.y > frame.height {
                evilenemyball.removeFromParent()
            }
        }
        for deathball in deathballs {
            if deathball.position.x > frame.midX + frame.width || deathball.position.x < frame.midX - frame.width || deathball.position.y > frame.height {
                deathball.removeFromParent()
            }
        }
    }
    
    
    func putScorelabel() {
        scoreLabel = ScoreLabel()
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY + frame.height / 4)
        if UIDevice.current.userInterfaceIdiom == .pad {
            scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY + frame.height / 6)
         }
        if ratio > 1.7 && ratio < 1.8 {
            scoreLabel.position = CGPoint(x: frame.midX, y: frame.midY + frame.height / 6)
        }
        addChild(scoreLabel)
        startTime = (NSDate.timeIntervalSinceReferenceDate)
        scoreLabel.run(fadein)
    }
    
    func putHighscorelabel() {
        if (isHighscoreLabelOn == false) {
            highscoreLabel.changeFontSize(with: 25)
            highscoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 75)
            if UIDevice.current.userInterfaceIdiom == .pad {
                highscoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.minY + UIScreen.main.bounds.height * 0.17)
             }
            if screenSize.height == 1024.0 {
                highscoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.minY + UIScreen.main.bounds.height * 0.21)
            }
            if screenSize.height == 1133.0 {
                highscoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.minY + UIScreen.main.bounds.height * 0.15)
            }
            if screenSize.height == 1112.0 {
                highscoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.minY + UIScreen.main.bounds.height * 0.19)
            }
            addChild(highscoreLabel)
            highscoreLabel.run(fadein)
            isHighscoreLabelOn = true
        }
        if (allScores.last == allScores.max()) {
            highscoreLabel.update(with: String(highScoreNumber))
        }
    }
    
    
    func spawnEnemyballWithDelay() {
        //        if score >= 30 && score <= 40 {
        //            if (Int.random(in: 1...2) == 1) {
        //                createEvilEnemyBall(xpos: Int(CGFloat.random(in: -300 ... -150)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -75, color: grayColor)
        //                if (Int.random(in: 1...2) == 1) {
        //                    createEnemyBall(xpos: Int(CGFloat.random(in: 150 ... 300)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -60, color: .black)
        //                }
        //                else {
        //                    createEvilEnemyBall(xpos: Int(CGFloat.random(in: 150 ... 300)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -60, color: grayColor)
        //                }
        //            }
        //            else {
        //                if (Int.random(in: 1...2) == 1) {
        //                    createEvilEnemyBall(xpos: Int(CGFloat.random(in: 150 ... 300)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -60, color: grayColor)
        //                    if (Int.random(in: 1...2) == 1) {
        //                        createEnemyBall(xpos: Int(CGFloat.random(in: -300 ... -150)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -60, color: .black)
        //                    }
        //                    else {
        //                        createEvilEnemyBall(xpos: Int(CGFloat.random(in: -300 ... -150)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -60, color: grayColor)
        //                    }
        //                }
        //                else {
        //                    createEnemyBall(xpos: Int(CGFloat.random(in: -300 ... 300)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -60, color: .black)
        //                }
        //            }
        //        }
        if score > 70 {
            createDeathBall(xpos: Int(CGFloat.random(in: 150 ... 300)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -80, color: .white)
            createDeathBall(xpos: Int(CGFloat.random(in: -300 ... -150)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -80, color: .white)
        }
        else {
            if score > 50 {
                if (Int.random(in: 1...2) == 1) {
                    createDeathBall(xpos: Int(CGFloat.random(in: 150 ... 300)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -80, color: .white)
                    if (Int.random(in: 1...2) == 1) {
                        createDeathBall(xpos: Int(CGFloat.random(in: -300 ... -150)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -80, color: .white)
                    }
                    else {
                        createDeathBall(xpos: Int(CGFloat.random(in: -300 ... -150)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -80, color: .white)
                    }
                }
                else {
                    createDeathBall(xpos: Int(CGFloat.random(in: -300 ... 300)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -80, color: .white)
                }
            }
            else {
                if score >= 4 || score > 30 {
                    if (Int.random(in: 1...2) == 1) {
                        createEnemyBall(xpos: Int(CGFloat.random(in: -300 ... -150)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -75, color: .darkGray)
                        if (Int.random(in: 1...2) == 1) {
                            createEvilEnemyBall(xpos: Int(CGFloat.random(in: 150 ... 300)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -60, color: .systemRed)
                        }
                        else {
                            createEnemyBall(xpos: Int(CGFloat.random(in: 150 ... 300)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -60, color: .darkGray)
                        }
                    }
                    else {
                        if (Int.random(in: 1...2) == 1) {
                            createEnemyBall(xpos: Int(CGFloat.random(in: 150 ... 300)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -60, color: .darkGray)
                            if (Int.random(in: 1...2) == 1) {
                                createEvilEnemyBall(xpos: Int(CGFloat.random(in: -300 ... -150)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -60, color: .systemRed)
                            }
                            else {
                                if (score > 30) {
                                    createDeathBall(xpos: Int(CGFloat.random(in: -300 ... -150)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -80, color: .white)
                                }
                                else {
                                    createEnemyBall(xpos: Int(CGFloat.random(in: -300 ... -150)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -60, color: .darkGray)
                                }
                            }
                        }
                        else {
                            if (score > 30) {
                                createDeathBall(xpos: Int(CGFloat.random(in: 150 ... 300)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -80, color: .white)
                            }
                            else {
                                createEnemyBall(xpos: Int(CGFloat.random(in: -300 ... 300)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -60, color: .darkGray)
                            }
                        }
                    }
                }
                else {
                    createEnemyBall(xpos: Int(CGFloat.random(in: -300 ... 300)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -60, color: .darkGray)
                    //createDeathBall(xpos: Int(CGFloat.random(in: -300 ... 300)), ypos: Int(frame.height / 2) + 10, ximp: 0, yimp: -80, color: .white)
                }
            }
        }
    }
    
    func checkVelocity() {
        for enemyball in enemyballs {
            if enemyball.physicsBody?.velocity == CGVector.zero {
                enemyball.removeFromParent()
            }
        }
        for evilenemyball in evilenemyballs {
            if evilenemyball.physicsBody?.velocity == CGVector.zero {
                evilenemyball.removeFromParent()
            }
        }
        for deathball in deathballs {
            if deathball.physicsBody?.velocity == CGVector.zero {
                deathball.removeFromParent()
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        checkVelocity()
        if isItRestart == true && isCountdownUp == false && score == 3 {
            createCountdown()
        }
        let contactMask = contact.bodyA.categoryBitMask
        if contactMask == PhysicsCategories.ball{
            if contact.bodyB.categoryBitMask == PhysicsCategories.enemyball || contact.bodyB.categoryBitMask == PhysicsCategories.deathball {
                SoundPlayer.shared.playSoundEffect(soundEffect: "pick")
                Vibration.success.vibrate()
                score += 1
                scoreLabel.update(with: score)
                
                if contact.bodyB.categoryBitMask == PhysicsCategories.deathball {
                    contact.bodyB.node?.run(changetoused)
                }
                
                //contact.bodyB.contactTestBitMask = PhysicsCategories.none
                
                // should the balls reduce points if they hit the ground
                // even after they have been hit by your spaceship?
                contact.bodyB.categoryBitMask = PhysicsCategories.usedball
                
                resetAnimation()
            }
            if contact.bodyB.categoryBitMask == PhysicsCategories.evilenemyball {
                Vibration.error.vibrate()
                if score >= 3 {
                    score -= 3
                    scoreLabel.update(with: score)
                }
                else if score == 1 {
                    score -= 1
                    scoreLabel.update(with: score)
                }
                else if score == 2 {
                    score -= 2
                    scoreLabel.update(with: score)
                }
                contact.bodyB.contactTestBitMask = PhysicsCategories.none
            }
        }
        
        let contactMaskFloor = contact.bodyA.categoryBitMask
        if contactMaskFloor == PhysicsCategories.floorObstacle {
            if contact.bodyB.categoryBitMask == PhysicsCategories.enemyball {
                if score != 0 {
                    score -= 1
                    scoreLabel.update(with: score)
                }
                contact.bodyB.node!.removeFromParent()
            }
            if contact.bodyB.categoryBitMask == PhysicsCategories.usedball {
                contact.bodyB.node!.removeFromParent()
            }
            if contact.bodyB.categoryBitMask == PhysicsCategories.evilenemyball {
                if score != 0 {
                    score += 1
                    scoreLabel.update(with: score)
                }
                contact.bodyB.node!.removeFromParent()
            }
            if contact.bodyB.categoryBitMask == PhysicsCategories.deathball {
                timerResumableEndgame?.invalidate()
                contact.bodyB.node?.removeFromParent()
                killAllBalls()
                if isItGameOver == false {
                    isItGameOver = true
                    self.endTheGame()
                }
            }
            // !!
            if contact.bodyB.categoryBitMask == PhysicsCategories.none {
                contact.bodyB.node?.removeFromParent()
            }
//            else if contact.bodyA.categoryBitMask == PhysicsCategories.none {
//                if contact.bodyB.categoryBitMask == PhysicsCategories.floorObstacle {
//                    contact.bodyA.node?.removeFromParent()
//                }
//            }
            // !!
        }
        if contact.bodyA.categoryBitMask == PhysicsCategories.none {
            if contact.bodyB.categoryBitMask == PhysicsCategories.floorObstacle {
                contact.bodyA.node?.removeFromParent()
            }
        }
        if contact.bodyA.categoryBitMask == PhysicsCategories.usedball {
            if contact.bodyB.categoryBitMask == PhysicsCategories.floorObstacle {
                contact.bodyA.node?.removeFromParent()
            }
        }
        
        if score == 1 {
            tutorialJump?.run(fadeout)
            hasSeenJumpTutorial = true
            if isPauseButtonThere == false {
                createPauseButton()
                isPauseButtonThere = true
            }
            defaults.set(hasSeenJumpTutorial, forKey: jumpKey)
        }
        if score == 2 {
            if hasSeenAsteroidTutorial == false || isTutorialOn == true {
                tutorialAsteroid?.run(fadein)
            }
        }
        if score == 10 {
            if isDelay3 == false {
                timerSpawn.invalidate()
                timerSpawn = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
                isDelay3 = true
            }
        }
        if score == 30 {
            if isDelay2 == false {
                timerSpawn.invalidate()
                timerSpawn = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
                isDelay2 = true
            }
        }
        if score == 29 {
            if hasSeenDeathstarTutorial == false || isTutorialOn == true {
                tutorialDeath!.run(fadein)
            }
        }
        if score == 34 {
            tutorialDeath?.run(fadeout)
            hasSeenDeathstarTutorial = true
            defaults.set(hasSeenDeathstarTutorial, forKey: deathstarKey)
        }
        if score > highScoreNumber {
            isItNewHighscore = true
            highScoreNumber = score
            defaults.set(highScoreNumber, forKey: scoreKey)
            highscoreLabel.update(with: String(highScoreNumber))
        }
        if score == 4 {
            tutorialAsteroid?.run(fadeout)
            hasSeenAsteroidTutorial = true
            defaults.set(hasSeenAsteroidTutorial, forKey: asteroidKey)
        }
        let contactMaskUsedBall = contact.bodyA.categoryBitMask
        if contactMaskUsedBall == PhysicsCategories.usedball {
            if contact.bodyB.categoryBitMask == PhysicsCategories.enemyball ||
                contact.bodyB.categoryBitMask == PhysicsCategories.deathball {
                print("billyards")
                Vibration.success.vibrate()
                score += 1
                scoreLabel.update(with: score)
                
                if contact.bodyB.categoryBitMask == PhysicsCategories.deathball {
                    contact.bodyB.node?.run(changetoused)
                }
                
                
                contact.bodyB.categoryBitMask = PhysicsCategories.usedball
                
                // !!
                //contact.bodyA.contactTestBitMask = PhysicsCategories.none
                // !!
                
                resetAnimation()
            }
            if contact.bodyB.categoryBitMask == PhysicsCategories.floorObstacle {
                contact.bodyA.node?.removeFromParent()
            }
        }
        else if contactMaskUsedBall == PhysicsCategories.deathball ||
                    contactMaskUsedBall == PhysicsCategories.enemyball {
            if contact.bodyB.categoryBitMask == PhysicsCategories.usedball {
                print("billyards 2")
                Vibration.success.vibrate()
                score += 1
                scoreLabel.update(with: score)
                
                if contact.bodyA.categoryBitMask == PhysicsCategories.deathball {
                    contact.bodyA.node?.run(changetoused)
                }
                
                
                contact.bodyA.categoryBitMask = PhysicsCategories.usedball
                
                // !!
                //contact.bodyB.contactTestBitMask = PhysicsCategories.none
                // !!
                
                resetAnimation()
            }
        }
    }
    
    func killAllBalls() {
        for enemyball in enemyballs {
            enemyball.removeFromParent()
        }
        for evilenemyball in evilenemyballs {
            evilenemyball.removeFromParent()
        }
        for deathball in deathballs {
            deathball.removeFromParent()
        }
        for ball in balls {
            ball.removeFromParent()
        }
    }

    
    
    func endTheGame() {
        tutorialDeath?.removeFromParent()
        isGameGoing = false
        if isItGameOver == true {
            oldmoney = money
            money += score
            defaults.set(money, forKey: moneyKey)
        }
        view?.layer.removeAllAnimations()
        trackLayer.removeFromSuperlayer()
        shapeLayer.removeFromSuperlayer()
        isCountdownUp = false
        surviveTime = NSDate.timeIntervalSinceReferenceDate - startTime + pauseTime
        isResumableTimerWorking = false
        allScores.append(score)
        killAllBalls()
        timerSpawn.invalidate()
        if
            let view = self.view ,
            let _ = view.scene as? GameScene
        {
//            restartButton = UIButton(frame: CGRect(x: view.frame.midX - 65, y: view.frame.midY - 25, width: 130, height: 50))
//            restartButton!.addTarget(self, action: #selector(restartTheGame), for: .touchUpInside)
//
//            self.view!.addSubview(restartButton!)
//            UIView.animate(withDuration: 1) {
//                self.restartButton!.setImage(UIImage(named: "restart"), for: .normal)
//            }
        }
        tutorialAsteroid?.removeFromParent()
        tutorialDeath?.removeFromParent()
        scoreLabel.removeFromParent()
        highscoreLabel.removeFromParent()
        isHighscoreLabelOn = false
        pauseButton?.removeFromSuperview()
        isPauseButtonThere = false
        createGameOver()
    }
    
    
    @objc func restartTheGame(sender: UIButton!) {
        SoundPlayer.shared.playSoundEffect(soundEffect: "button")
        pauseTime = 0
        spawnBall()
        score = 0
        isScoreLabelOn = false
        isItRestart = true
        restartButton?.isHidden = true
        bgGameover?.removeFromParent()
        results?.removeFromParent()
        scoreResult?.removeFromParent()
        timeResult?.removeFromParent()
        highscoreResult?.removeFromParent()
        coinImage?.removeFromParent()
        moneyLabel.removeFromSuperview()
        putHighscorelabel()
        timerSpawn.invalidate()
        createTutorialTap()
        createTitle()
        createShop()
        
        if isTutorialOn == true {
            createTutorialJump()
            createTutorialAsteroid()
            createTutorialDeath()
        }
    }
    
    @objc func appMovedToBackground() {
        print("App moved to background!")
        if isGamePaused == false && isGameGoing == true {
            print("i pause")
            pauseTheGame(sender: self.pauseButton)
        }
    }
    
    @objc func appMovedToForeground() {
        print("App moved to foreground!")

    }
    
    
    @objc func goHome(sender: UIButton!) {
        isItGoingHome = true
        resumeTheGame()
        endTheGame()
        timerResumableEndgame?.invalidate()
        pauseTime = 0
        spawnBall()
        score = 0
        isScoreLabelOn = false
        restartButton!.isHidden = true
        isItRestart = true
        bgGameover?.removeFromParent()
        results?.removeFromParent()
        scoreResult?.removeFromParent()
        timeResult?.removeFromParent()
        highscoreResult?.removeFromParent()
        putHighscorelabel()
        timerSpawn.invalidate()
        createTutorialTap()
        createTitle()
        createShop()
        isItGoingHome = false
        
        print(" ")
        print("hasSeenJumpTutorial " + String(hasSeenJumpTutorial))
        print("hasSeenAsteroidTutorial " + String(hasSeenAsteroidTutorial))
        print("hasSeenDeathstarTutorial " + String(hasSeenDeathstarTutorial))
        print("isTutorialOn " + String(isTutorialOn))
        
        if isTutorialOn == true {
            createTutorialJump()
            createTutorialAsteroid()
            createTutorialDeath()
        }
    }
    
    @objc func pauseTheGame(sender: UIButton!) {
        SoundPlayer.shared.playSoundEffect(soundEffect: "button")
        pauseTime += NSDate.timeIntervalSinceReferenceDate - startTime
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view!.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view!.addSubview(blurEffectView)
        blurEffectView.tag = 10

        createButtonsOnPauseScreen()
        
        
        timerSpawn.invalidate()
        
        timerResumableEndgame?.pause()
        
    
        var pausedTime = shapeLayer.convertTime(CACurrentMediaTime(), from: nil)
        shapeLayer.speed = 0.0
        shapeLayer.timeOffset = pausedTime
        
        self.physicsWorld.speed = 0.0
        self.view!.isPaused = true
        isGamePaused = true
    }
    
    func createButtonsOnPauseScreen() {
        resumeButton = UIButton(frame: CGRect(x: view!.frame.midX - 65, y: view!.frame.midY - 25, width: 130, height: 50))
        if UIDevice.current.userInterfaceIdiom == .pad {
            resumeButton = UIButton(frame: CGRect(x: view!.frame.midX - (UIScreen.main.bounds.width / 3.3) / 2, y: view!.frame.midY - ((UIScreen.main.bounds.width / 3.3) / 2.6) / 2, width: UIScreen.main.bounds.width / 3.3, height: (UIScreen.main.bounds.width / 3.3) / 2.6))
         }
        resumeButton!.addTarget(self, action: #selector(resumeTheGame), for: .touchUpInside)
        self.view!.addSubview(resumeButton!)
        UIView.animate(withDuration: 1) {
            self.resumeButton!.setImage(UIImage(named: "resume"), for: .normal)
        }
        
        musicButton = UIButton(frame: CGRect(x: view!.frame.midX - 65, y: view!.frame.midY - 25 - (resumeButton?.frame.height)! * 1.5, width: 50, height: 50))
        if UIDevice.current.userInterfaceIdiom == .pad {
            musicButton = UIButton(frame: CGRect(x: view!.frame.midX - (UIScreen.main.bounds.width / 3.3) / 2, y: (view!.frame.midY - ((UIScreen.main.bounds.width / 3.3) / 2.6) / 2) - (resumeButton?.frame.height)! * 1.5, width: ((UIScreen.main.bounds.width / 3.3) / 2.6), height: ((UIScreen.main.bounds.width / 3.3) / 2.6)))
         }
        musicButton!.addTarget(self, action: #selector(turnOnOffMusic), for: .touchUpInside)
        self.view!.addSubview(musicButton!)
        if MusicPlayer.isMusicOn == true {
            UIView.animate(withDuration: 1) {
                self.musicButton!.setImage(UIImage(named: "musicon"), for: .normal)
            }
        }
        else if MusicPlayer.isMusicOn == false {
            UIView.animate(withDuration: 1) {
                self.musicButton!.setImage(UIImage(named: "musicoff"), for: .normal)
            }
        }
        
        infoButton = UIButton(frame: CGRect(x: view!.frame.midX + 15, y: view!.frame.midY - 25 - (resumeButton?.frame.height)! * 1.5, width: 50, height: 50))
        if UIDevice.current.userInterfaceIdiom == .pad {
            infoButton = UIButton(frame: CGRect(x: view!.frame.midX - (UIScreen.main.bounds.width / 3.3) / 2 + 190, y: (view!.frame.midY - ((UIScreen.main.bounds.width / 3.3) / 2.6) / 2) - (resumeButton?.frame.height)! * 1.5, width: ((UIScreen.main.bounds.width / 3.3) / 2.6), height: ((UIScreen.main.bounds.width / 3.3) / 2.6)))
         }
        if ratio >= 1.52 && ratio <= 1.53 {
            infoButton = UIButton(frame: CGRect(x: view!.frame.midX - (UIScreen.main.bounds.width / 3.3) / 2 + 140, y: (view!.frame.midY - ((UIScreen.main.bounds.width / 3.3) / 2.6) / 2) - (resumeButton?.frame.height)! * 1.5, width: ((UIScreen.main.bounds.width / 3.3) / 2.6), height: ((UIScreen.main.bounds.width / 3.3) / 2.6)))
        }
        if ratio >= 1.43 && ratio <= 1.44 {
            infoButton = UIButton(frame: CGRect(x: view!.frame.midX - (UIScreen.main.bounds.width / 3.3) / 2 + 155, y: (view!.frame.midY - ((UIScreen.main.bounds.width / 3.3) / 2.6) / 2) - (resumeButton?.frame.height)! * 1.5, width: ((UIScreen.main.bounds.width / 3.3) / 2.6), height: ((UIScreen.main.bounds.width / 3.3) / 2.6)))
        }
        if UIScreen.main.bounds.height == 1024.0 {
            infoButton = UIButton(frame: CGRect(x: view!.frame.midX - (UIScreen.main.bounds.width / 3.3) / 2 + 145, y: (view!.frame.midY - ((UIScreen.main.bounds.width / 3.3) / 2.6) / 2) - (resumeButton?.frame.height)! * 1.5, width: ((UIScreen.main.bounds.width / 3.3) / 2.6), height: ((UIScreen.main.bounds.width / 3.3) / 2.6)))
         }
        if UIScreen.main.bounds.height == 1080.0 {
            infoButton = UIButton(frame: CGRect(x: view!.frame.midX - (UIScreen.main.bounds.width / 3.3) / 2 + 150, y: (view!.frame.midY - ((UIScreen.main.bounds.width / 3.3) / 2.6) / 2) - (resumeButton?.frame.height)! * 1.5, width: ((UIScreen.main.bounds.width / 3.3) / 2.6), height: ((UIScreen.main.bounds.width / 3.3) / 2.6)))
         }
        if UIScreen.main.bounds.height == 1112.0 {
            infoButton = UIButton(frame: CGRect(x: view!.frame.midX - (UIScreen.main.bounds.width / 3.3) / 2 + 155, y: (view!.frame.midY - ((UIScreen.main.bounds.width / 3.3) / 2.6) / 2) - (resumeButton?.frame.height)! * 1.5, width: ((UIScreen.main.bounds.width / 3.3) / 2.6), height: ((UIScreen.main.bounds.width / 3.3) / 2.6)))
         }
        infoButton!.addTarget(self, action: #selector(infoDeveloper), for: .touchUpInside)
        self.view!.addSubview(infoButton!)
        UIView.animate(withDuration: 1) {
            self.infoButton!.setImage(UIImage(named: "info"), for: .normal)
        }

        
        homeButton = UIButton(frame: CGRect(x: view!.frame.midX - 65, y: view!.frame.midY - 25 + (resumeButton?.frame.height)! * 1.5, width: 130, height: 50))
        if UIDevice.current.userInterfaceIdiom == .pad {
            homeButton = UIButton(frame: CGRect(x: view!.frame.midX - (UIScreen.main.bounds.width / 3.3) / 2, y: (view!.frame.midY - ((UIScreen.main.bounds.width / 3.3) / 2.6) / 2) + (resumeButton?.frame.height)! * 1.5, width: UIScreen.main.bounds.width / 3.3, height: (UIScreen.main.bounds.width / 3.3) / 2.6))
         }
        homeButton!.addTarget(self, action: #selector(goHome), for: .touchUpInside)
        self.view!.addSubview(homeButton!)
        UIView.animate(withDuration: 1) {
            self.homeButton!.setImage(UIImage(named: "home"), for: .normal)
        }
        
        if hasSeenJumpTutorial == true && hasSeenAsteroidTutorial == true {
            tutorialButton = UIButton(frame: CGRect(x: view!.frame.midX - 65, y: view!.frame.midY - 25 - (resumeButton?.frame.height)! * 3, width: 130, height: 50))
            if UIDevice.current.userInterfaceIdiom == .pad {
                tutorialButton = UIButton(frame: CGRect(x: view!.frame.midX - (UIScreen.main.bounds.width / 3.3) / 2, y: view!.frame.midY - ((UIScreen.main.bounds.width / 3.3) / 2.6) / 2 - (resumeButton?.frame.height)! * 3, width: UIScreen.main.bounds.width / 3.3, height: (UIScreen.main.bounds.width / 3.3) / 2.6))
            }
            tutorialButton!.addTarget(self, action: #selector(turnOnOffTutorial), for: .touchUpInside)
            self.view!.addSubview(tutorialButton!)
            if isTutorialOn == true {
                UIView.animate(withDuration: 1) {
                    self.tutorialButton!.setImage(UIImage(named: "tutorialon"), for: .normal)
                }
            }
            else if isTutorialOn == false {
                UIView.animate(withDuration: 1) {
                    self.tutorialButton!.setImage(UIImage(named: "tutorialoff"), for: .normal)
                }
            }
        }
    }
    
    @objc func turnOnOffTutorial() {
        if isTutorialOn == true {
            UIView.animate(withDuration: 1) {
                self.tutorialButton!.setImage(UIImage(named: "tutorialoff"), for: .normal)
            }
            isTutorialOn = false
            
//            hasSeenJumpTutorial = false
//            defaults.set(hasSeenJumpTutorial, forKey: jumpKey)
//            hasSeenAsteroidTutorial = false
//            defaults.set(hasSeenAsteroidTutorial, forKey: asteroidKey)
//            hasSeenDeathstarTutorial = false
//            defaults.set(hasSeenDeathstarTutorial, forKey: deathstarKey)
        }
        else if isTutorialOn == false {
            UIView.animate(withDuration: 1) {
                self.tutorialButton!.setImage(UIImage(named: "tutorialon"), for: .normal)
            }
            isTutorialOn = true
            
//            hasSeenJumpTutorial = true
//            defaults.set(hasSeenJumpTutorial, forKey: jumpKey)
//            hasSeenAsteroidTutorial = true
//            defaults.set(hasSeenAsteroidTutorial, forKey: asteroidKey)
//            hasSeenDeathstarTutorial = true
//            defaults.set(hasSeenDeathstarTutorial, forKey: deathstarKey)
        }
    }
    
    @objc func turnOnOffMusic() {
        if MusicPlayer.isMusicOn == true {
            MusicPlayer.shared.stopBackgroundMusic()
            UIView.animate(withDuration: 1) {
                self.musicButton!.setImage(UIImage(named: "musicoff"), for: .normal)
            }
        }
        else if MusicPlayer.isMusicOn == false {
            MusicPlayer.shared.startBackgroundMusic()
            UIView.animate(withDuration: 1) {
                self.musicButton!.setImage(UIImage(named: "musicon"), for: .normal)
            }
        }
    }
        
    @objc func infoDeveloper() {
        print("info")
        SoundPlayer.shared.playSoundEffect(soundEffect: "button")
        
        if let removable = view!.viewWithTag(10){
            removable.removeFromSuperview()
         }
    
        
        trackLayer.isHidden = true
        shapeLayer.isHidden = true

        
        
        resumeButton?.removeFromSuperview()
        tutorialButton?.removeFromSuperview()
        musicButton?.removeFromSuperview()
        homeButton?.removeFromSuperview()
        infoButton?.removeFromSuperview()
        pauseButton?.isHidden = true
        
        developerInfo = SKSpriteNode(imageNamed: "devinfonew")
        developerInfo?.position = CGPoint(x: 0, y: 0)
        developerInfo?.size.width = self.size.width
        developerInfo?.size.height = self.size.height
        developerInfo?.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        developerInfo?.zPosition = 25
        self.addChild(developerInfo!)
        
        developerBack = SKSpriteNode(imageNamed: "back")
        developerBack?.name = "developerBack"
        developerBack?.size = CGSize(width: 170, height: 65)
        developerBack?.zPosition = 30
        developerBack?.position = CGPoint(x: self.frame.midX, y: self.frame.midY - self.frame.height / 4)
        self.addChild(developerBack!)

    }
    
    
    @objc func resumeTheGame() {
        SoundPlayer.shared.playSoundEffect(soundEffect: "button")
        if let removable = view!.viewWithTag(10){
            removable.removeFromSuperview()
         }
        
        startTime = (NSDate.timeIntervalSinceReferenceDate)
        resumeButton?.removeFromSuperview()
        tutorialButton?.removeFromSuperview()
        musicButton?.removeFromSuperview()
        homeButton?.removeFromSuperview()
        infoButton?.removeFromSuperview()
        
        if isItGoingHome == true {
            
            if isResumableTimerWorking == true {
                timerResumableEndgame?.resume()
            }
            
            if score >= 30 {
                timerSpawn.invalidate()
                timerSpawn = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            }
            else if score >= 10 {
                timerSpawn.invalidate()
                timerSpawn = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            }
            else {
                timerSpawn.invalidate()
                timerSpawn = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            }
            
            let pausedTime = shapeLayer.timeOffset
            shapeLayer.speed = 1.0
            shapeLayer.timeOffset = 0.0
            shapeLayer.beginTime = 0.0
            let timeSincePause = shapeLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
            shapeLayer.beginTime = timeSincePause
            
            self.view!.isPaused = false
            self.physicsWorld.speed = 0.9999
            isGamePaused = false
        }
        else {
            pauseButton?.removeFromSuperview()
            
            let resuming1 = SKSpriteNode(imageNamed: "resuminggray")
            resuming1.alpha = 1
            resuming1.zPosition = 10
            resuming1.size = CGSize(width: 300, height: 60)
            resuming1.position = CGPoint(x: frame.midX, y: frame.midY)
            self.addChild(resuming1)
//            if UIDevice.current.userInterfaceIdiom == .phone {
//                resuming1.size = CGSize(width: UIScreen.main.bounds.width * 1.5, height: UIScreen.main.bounds.height * 1.5)
//            }
//            resuming1.zPosition = 15
//            resuming1.position = CGPoint(x: 0, y: 0)
//            addChild(resuming1)
            
            _ = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { [self]_ in
                createPauseButton()
                resuming1.removeFromParent()
                
                if isResumableTimerWorking == true {
                    timerResumableEndgame?.resume()
                }
                
                if score >= 30 {
                    timerSpawn.invalidate()
                    timerSpawn = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
                }
                else if score >= 10 {
                    timerSpawn.invalidate()
                    timerSpawn = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
                }
                else {
                    timerSpawn.invalidate()
                    timerSpawn = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
                }
                
                let pausedTime = shapeLayer.timeOffset
                shapeLayer.speed = 1.0
                shapeLayer.timeOffset = 0.0
                shapeLayer.beginTime = 0.0
                let timeSincePause = shapeLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
                shapeLayer.beginTime = timeSincePause
                
                self.view!.isPaused = false
                self.physicsWorld.speed = 0.9999
                isGamePaused = false
            }
        }
    }
    
    @objc func shop(sender: UIButton!) {
        SoundPlayer.shared.playSoundEffect(soundEffect: "button")
        tutorialJump?.removeFromParent()
        tutorialDeath?.removeFromParent()
        tutorialAsteroid?.removeFromParent()
        tapTheScreen?.isHidden = true
        tapTheScreen?.removeFromParent()
        timerTutorial.invalidate()
        
        shopButton?.removeFromSuperview()
        
        self.removeAllChildren()
        
        let spaceShop = SpaceShop(fileNamed: "SpaceShop")
        spaceShop?.scaleMode = .aspectFill
        self.view?.presentScene(spaceShop!)
    }
    
    
    
    @objc func timerAction() {
        spawnEnemyballWithDelay()
        isGameGoing = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isGamePaused == false {
            for t in touches {
                let location = t.location(in: self)
                Vibration.soft.vibrate()
                if(location.x < 0) {
                    ballApplyImpulse(ball: self.balls.last!, vx: -100, vy: 300)
                }
                else {
                    ballApplyImpulse(ball: self.balls.last!, vx: 100, vy: 300)
                }
            }
        }
        for t in touches {
            let location = t.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "developerBack" {
                print("back")
                SoundPlayer.shared.playSoundEffect(soundEffect: "button")
                
                let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.frame = view!.bounds
                blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                view!.addSubview(blurEffectView)
                blurEffectView.tag = 10
                
                createButtonsOnPauseScreen()
                
                developerBack?.removeFromParent()
                developerInfo?.removeFromParent()
                pauseButton?.isHidden = false
                
                trackLayer.isHidden = false
                shapeLayer.isHidden = false

            
                self.view?.isPaused = false
            
                _ = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: false) { [self]_ in
                    self.view?.isPaused = true
                }
            }
        }
        despawnEnemyBall()
        if score == 3 && isCountdownUp == false {
            createCountdown()
        }
        if (isScoreLabelOn == false) {
            putScorelabel()
            isScoreLabelOn = true
            timerSpawn = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }
        if isItNotFirstTouch == false {
            if hasSeenJumpTutorial == false || isTutorialOn == true {
                createTutorialJump()
            }
            tapTheScreen?.isHidden = true
            tapTheScreen?.removeFromParent()
            title?.removeFromParent()
            isItNotFirstTouch = true
        }
        title?.removeFromParent()
        tapTheScreen?.isHidden = true
        tapTheScreen?.removeFromParent()
        shopButton?.removeFromSuperview()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    override func update(_ currentTime: TimeInterval) {

    }
    deinit {
        print("\n THE SCENE \(type(of: self))) WAS REMOVED FROM MEMORY (DEINIT) \n")
    }
}
