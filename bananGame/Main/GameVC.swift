//
//  GameVC.swift
//  bananGame
//
//  Created by Nika Topuria on 03.11.21.
//

import UIKit

class GameVC: UIViewController {

    
    @IBOutlet var gameScore: UILabel!
    @IBOutlet var monkeyImage: UIImageView!
    var bananaCounter = 0
    var gamespeed = 7.0
    var winningScore = 20

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animateBanana(this: self.makeBanana(at: self.generateRandomSpawnPoint()))
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
            self.animateBanana(this: self.makeBanana(at: self.generateRandomSpawnPoint()))
        })
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func panGestureHappened(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        guard let gestureView = sender.view else { return }
        gestureView.center = CGPoint(
            x: gestureView.center.x + translation.x,
            y: gestureView.center.y + translation.y
        )
        sender.setTranslation(.zero, in: view)
    }
    
    func animateBanana(this banana: UIImageView) {
        self.view.addSubview(banana)
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true, block: { timer in
            if banana.frame.intersects(self.monkeyImage.frame) {
                if self.bananaCounter == self.winningScore - 1 {
                    let alert = UIAlertController(title: "Winner winner chicken dinner", message: "I think \(self.winningScore) bananas will be enough ^_^", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Start Again", style: .default, handler: { UIAlertAction in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                self.bananaCounter += 1
                self.gamespeed += 1.5
                self.updateScore(with: self.bananaCounter)
                banana.removeFromSuperview()
                timer.invalidate()
            } else {
                banana.center = CGPoint(x: banana.center.x, y: banana.center.y + CGFloat(self.gamespeed))
            }
        })
    }
    
    func updateScore(with score: Int) {
        gameScore.text = "Score: \(score)"
    }
    
    func generateRandomSpawnPoint() -> CGPoint {
        let x = CGFloat.random(in: 40...(view.frame.width-40))
        let y = CGFloat(80.0)
        return (CGPoint(x: x, y: y))
    }
    
    
    func makeBanana(at point: CGPoint) -> UIImageView {
        let bananaView = UIImageView.init(image: UIImage.init(named: "img_happyBanana"))
        bananaView.frame = CGRect(x: 0, y: 0, width: 80, height: 93)
        bananaView.center = point
        return bananaView
    }
    

}
