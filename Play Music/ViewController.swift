//
//  ViewController.swift
//  Play Music
//
//  Created by Doãn Tuấn on 11/21/16.
//  Copyright © 2016 doantuan. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, AVAudioPlayerDelegate{

    var audio = AVAudioPlayer()
    var checkPlay:Int!
    var currentTimeAudio:Double!
    var time:Timer!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var timeLeft_Lbl: UILabel!
    @IBOutlet weak var timeTotal_Lbl: UILabel!
    @IBOutlet weak var Duration_Slider: UISlider!
    @IBOutlet weak var RepeatSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audio = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: ".mp3")!))
        setThubImage()
        checkPlay = 0
        audio.delegate = self
        RepeatSwitch.setOn(false, animated: true)
        audio.numberOfLoops = 0
        //
        let minu: Int = Int(audio.duration / 60)
        let sec: Int = Int(audio.duration.truncatingRemainder(dividingBy: 60))
        if minu < 10 && sec < 10{
            timeTotal_Lbl.text = "0\(minu):0\(sec)"
        }else{
            if minu > 10 && sec < 10{
                timeTotal_Lbl.text = "\(minu):0\(sec)"
            }else{
                if minu < 10 && sec > 10{
                    timeTotal_Lbl.text = "0\(minu):\(sec)"
                }else{
                    timeTotal_Lbl.text = "\(minu):\(sec)"
                }
            }
        }

         Duration_Slider.maximumValue = Float(audio.duration)
    }

    
    func updateTimeLeft(){
        let minu = Int(audio.currentTime/60)
        let sec = Int(audio.currentTime.truncatingRemainder(dividingBy: 60))
        if minu < 10 && sec < 10{
            timeLeft_Lbl.text = "0\(minu):0\(sec)"
        }else{
            if minu > 10 && sec < 10{
                timeLeft_Lbl.text = "\(minu):0\(sec)"
            }else{
                if minu < 10 && sec > 10{
                    timeLeft_Lbl.text = "0\(minu):\(sec)"
                }else{
                    timeLeft_Lbl.text = "\(minu):\(sec)"
                }
            }
        }
        Duration_Slider.value = Float(audio.currentTime)
    }
    
    
    // forward backward 
    @IBAction func ChangeCurrentTimeAudio(_ sender: UISlider) {
        audio.currentTime = TimeInterval(sender.value)
        
    }
    
    @IBAction func changeSwitch(_ sender: UISwitch) {
        if sender.isOn{
            audio.numberOfLoops = -1
        }else{
            audio.numberOfLoops = 0
        }
    }
  
    
    
    @IBAction func SlideAciton(_ sender: UISlider) {
       
        audio.volume = sender.value
    }

    @IBOutlet weak var PlayOutlet: UIButton!

    @IBAction func PlayAction(_ sender: Any) {
        if checkPlay == 0{
            audio.play()
            PlayOutlet.setBackgroundImage(UIImage(named: "pause"), for: UIControlState.normal)
            checkPlay = 1
            time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeLeft), userInfo: nil, repeats: true)
        }else{
            if checkPlay == 1{
                
            audio.pause()
            time.invalidate()
            PlayOutlet.setBackgroundImage(UIImage(named: "play"), for: UIControlState.normal)
            checkPlay = 0
                time.invalidate()
            }
        }
    }
    // set ThubImage
    func setThubImage(){
        Duration_Slider.value = 0.0
        slider.setThumbImage(UIImage(named: "thumb.png"), for: UIControlState.normal)
        slider.setThumbImage(UIImage(named: "thumbHightLight"), for: UIControlState.highlighted)
        Duration_Slider.setThumbImage(UIImage(named: "duration"), for: UIControlState.normal)
        Duration_Slider.setThumbImage(UIImage(named: "duration"), for: UIControlState.highlighted)
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //
        if RepeatSwitch.isOn {
            
        }else{
            PlayOutlet.setBackgroundImage(UIImage(named: "play"), for: UIControlState.normal)
        }
        
    }
    
}

