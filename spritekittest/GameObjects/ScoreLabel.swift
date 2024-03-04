//
//  ScoreLabel.swift
//  spritekittest
//
//  Created by Николай Лаврентьев on 04.01.2023.
//

import SpriteKit

class ScoreLabel: SKLabelNode {

    override init() {
        super.init()

        self.text = "0"
        self.fontSize = 100.0
        self.fontColor = .white
        self.alpha = 0
        self.fontName = "' RonySiswadi Architect 4"
        
        self.zPosition = 10
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with score: Int) {
        self.text = "\(score)"
    }
    func update(with score: String) {
        let highscoreStr = "highscore: "
        let nonBold = [NSAttributedString.Key.font : UIFont(name: "' RonySiswadi Architect 4", size: 25), NSAttributedString.Key.foregroundColor: UIColor.white]
        let attributedString = NSMutableAttributedString(string:highscoreStr, attributes: nonBold as [NSAttributedString.Key : Any])
        let bold = [NSAttributedString.Key.font : UIFont(name: "' RonySiswadi Architect 4", size: 30), NSAttributedString.Key.foregroundColor: UIColor.white]
        let boldString = NSMutableAttributedString(string: score, attributes:bold as [NSAttributedString.Key : Any])
        attributedString.append(boldString)
        self.attributedText = attributedString
        self.fontColor = .white
    }
    func changeFontSize(with size: Int) {
        self.fontSize = CGFloat(size)
    }
}
