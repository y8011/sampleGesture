//
//  ViewController.swift
//  sampleGesture
//
//  Created by yuka on 2018/06/20.
//  Copyright © 2018年 yuka. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var greenView: UIView!
    
    @IBOutlet weak var pinkView: UIView!

    var myView:UIView!

    
    // オーディオ
    var apCat1:AVAudioPlayer = AVAudioPlayer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.makeSound1("sound1.m4a")
//        self.makeSound1("cat1b.mp3")
        
        // Viewのプログラムでの作り方
        myView = UIView(frame: self.view.frame)
        myView.backgroundColor = UIColor.black
        self.view.addSubview(myView)
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animate(withDuration: 2.0, animations: {
            self.myView.backgroundColor = UIColor.clear
        }, completion: {(success) in
            self.myView.isHidden = true
        })
    }
    
    func makeSound1(_ audioFileName: String) {
        let soundFile = Bundle.main.path(forResource: audioFileName, ofType: nil)!
        let soundClear = URL(fileURLWithPath: soundFile )
        
        //AVAudioPlayerのインスタンス化
        do {
            apCat1 = try AVAudioPlayer(contentsOf: soundClear as URL)
            
            
        }catch{
            print("Failed AVAudioPlayer Instance")
        }
        apCat1.prepareToPlay()
        
    }

    // GreenViewがタップされたら発動する
    @IBAction func tapGreenView(_ sender: UITapGestureRecognizer) {
        print("タップされました")

        
        let alertController = UIAlertController(title: "tapされたよ", message: "Hello tap!", preferredStyle: .alert)
        
        
        alertController.addAction(UIAlertAction(title: "Hi!", style: .destructive, handler: {action in print("destructive!")}))
        
        present(alertController, animated: true, completion: {()->Void in print("表示されたよ")})

        
    }
    
    @IBAction func longPressPinkView(_ sender: UILongPressGestureRecognizer) {
        

        pinkView.center = sender.location(in: view)
        //音鳴らす
//        print("長押しされました",sender.state.rawValue)
        apCat1.play()

        // １回しかやらない処理はわける
//        if sender.state == .began {
//            print("始まり")
//        }
//        else if sender.state == .ended {
////            pinkView.center = tapPoint
//            print("おわり")
//        }
//
//        print(tapPoint.x,tapPoint.y)
        
        
    }
    
    var r = 0

    @IBAction func doubleTaps(_ sender: UITapGestureRecognizer) {
        print("ダブルtapされたよ")

        r = Int(arc4random_uniform(2))
        if r == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                if self.pinkView.backgroundColor != UIColor.clear {
                    self.pinkView.backgroundColor = UIColor.clear
                    
                } else {
                    self.pinkView.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green:  CGFloat(arc4random_uniform(255))/255.0, blue:  CGFloat(arc4random_uniform(255))/255.0, alpha: 1)
                }
            }, completion: { (success) in
                if self.pinkView.backgroundColor == UIColor.clear {
                    self.pinkView.frame.origin.x = CGFloat(arc4random_uniform(UInt32(UIScreen.main.bounds.width)))
                }
            })
        }
        else {
            UIView.animate(withDuration:0.3, animations: {
                if self.greenView.backgroundColor != UIColor.clear {
                    self.greenView.backgroundColor = UIColor.clear
                    
                } else {
                    self.greenView.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green:  CGFloat(arc4random_uniform(255))/255.0, blue:  CGFloat(arc4random_uniform(255))/255.0, alpha: 1)
                    
                }
            }, completion: { (success) in
                if self.greenView.backgroundColor == UIColor.clear {
                    self.greenView.frame.origin.x = CGFloat(arc4random_uniform(UInt32(UIScreen.main.bounds.width)))
                        - self.greenView.frame.width
                }
                
            })
        }

        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

