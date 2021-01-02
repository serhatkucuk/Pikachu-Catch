//
//  ViewController.swift
//  Pikachu Catch
//
//  Created by Serhat Küçük on 2.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
//    Variables
    @IBOutlet weak var timeHeader: UILabel!
    @IBOutlet weak var scoreHeader: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var pikachu1: UIImageView!
    @IBOutlet weak var pikachu2: UIImageView!
    @IBOutlet weak var pikachu3: UIImageView!
    @IBOutlet weak var pikachu4: UIImageView!
    @IBOutlet weak var pikachu5: UIImageView!
    @IBOutlet weak var pikachu6: UIImageView!
    @IBOutlet weak var pikachu7: UIImageView!
    @IBOutlet weak var pikachu8: UIImageView!
    @IBOutlet weak var pikachu9: UIImageView!
    @IBOutlet weak var ashandpikachu: UIImageView!
    
    @IBOutlet var backGround: UIView!
    @IBOutlet weak var mainRePlayButton: UIButton!
    
    
    var counter = 0
    var score = 0
    var highScore = 0
    var timer = Timer()
    var hideTimer = Timer()
    var pikachuArray = [UIImageView]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
//Oyun başladığında Replay butonunu yok eder
        mainRePlayButton.isHidden = true
        ashandpikachu.isHidden = true
        
//En yüksek skor için UserDefaultstan çağrım yapılır
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
//kayıt gelmemesi durumunda kontrol yapıldı
        if storedHighScore == nil{
            highScore = 0
        }
        if let newHighScore = storedHighScore as? Int{
            highScore = newHighScore
            highScoreLabel.text = "High Score: \(highScore)"
        }
        
        
        counter = 10
        score = 0
        scoreLabel.text = String(score)
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hidePikachu), userInfo: nil, repeats: true)
        
        
// Resimlerin tıklanabilirliğini sağlar
        pikachu1.isUserInteractionEnabled = true
        pikachu2.isUserInteractionEnabled = true
        pikachu3.isUserInteractionEnabled = true
        pikachu4.isUserInteractionEnabled = true
        pikachu5.isUserInteractionEnabled = true
        pikachu6.isUserInteractionEnabled = true
        pikachu7.isUserInteractionEnabled = true
        pikachu8.isUserInteractionEnabled = true
        pikachu9.isUserInteractionEnabled = true
 
// Tıklama eyleminin tanımı yapıldı
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
 
//        Görseller ve eylemler eşleştirildi
        pikachu1.addGestureRecognizer(recognizer1)
        pikachu2.addGestureRecognizer(recognizer2)
        pikachu3.addGestureRecognizer(recognizer3)
        pikachu4.addGestureRecognizer(recognizer4)
        pikachu5.addGestureRecognizer(recognizer5)
        pikachu6.addGestureRecognizer(recognizer6)
        pikachu7.addGestureRecognizer(recognizer7)
        pikachu8.addGestureRecognizer(recognizer8)
        pikachu9.addGestureRecognizer(recognizer9)
        
        pikachuArray = [pikachu1, pikachu2, pikachu3, pikachu4, pikachu5, pikachu6, pikachu7, pikachu8, pikachu9]
        
        
        
        
    }
    
    @objc func timerFunction(){
        
        counter -= 1
        timeLabel.text = String(counter)
        
        
        if counter == 0{
            timeLabel.text = String(counter)
            timer.invalidate()
            hideTimer.invalidate()
            for pika in pikachuArray{
                pika.isHidden = true
            }
            ashandpikachu.isHidden = false
                        
            let alert = UIAlertController(title: "Time is up. Play again?", message: nil, preferredStyle: UIAlertController.Style.alert)
            let noButton = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel){ [self] (UIAlertAction) in
                self.mainRePlayButton.isHidden = false

                
                
            }
            let replayButton = UIAlertAction(title: "RePlay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                
                self.viewDidLoad()
                
            }
            alert.addAction(noButton)
            alert.addAction(replayButton)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    func blink() {
        mainRePlayButton.alpha = 0.2
            UIView.animate(withDuration: 1, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse], animations: {self.mainRePlayButton.alpha = 1.0}, completion: nil)
         }
    
    
    @objc func  hidePikachu(){
        
        for pika in pikachuArray{
            pika.isHidden = true
        }
        
        let random = Int.random(in: 0..<(pikachuArray.count))
        pikachuArray[random].isHidden = false
        
        
    }
    
    @IBAction func mainRePlayClicked(_ sender: Any) {
        
        viewDidLoad()
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = String(score)
        if score > highScore{
            highScoreLabel.text = "High Score: \(score)"
            UserDefaults.standard.set(score, forKey: "highscore")
        }
    }


}

