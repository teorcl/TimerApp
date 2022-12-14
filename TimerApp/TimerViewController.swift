//
//  TimerViewController.swift
//  TimerApp
//
//  Created by TEO on 9/12/22.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController {
    
    var timeout : Int?
    var currentTime = 0
    var timer: Timer?
    var bombSoundEffect: AVAudioPlayer?
    
    @IBOutlet weak var timeOutLabel: UILabel!
    @IBOutlet weak var timeOutProgressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        startTimer()
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(processTick),
            userInfo: nil,
            repeats: true)
    }
    
    @objc func processTick(){
        guard let timeout = timeout else {
            return
        }
        currentTime += 1
        
        updateUI()
        
        if currentTime >= timeout {
            timer?.invalidate()
            UIDevice.vibrate()
            playSound()
            timer = nil
        }
        
    }
    
    private func updateUI(){
        updateTimeOutLabel()
        updatetimeOutProgressView()
    }
    
    private func updateTimeOutLabel(){
        timeOutLabel.text = getTimeoutText()
    }
    
    private func getTimeoutText() -> String {
        guard let timeout = timeout else {
            return "ERROR"
        }
        
        let secondsLeft = Float(timeout - currentTime)
        
        let minutes = Int(secondsLeft / 60.0)
        let seconds = Int(secondsLeft) - minutes * 60
        
        return convertToText(minutes: minutes, seconds: seconds)
    }
    
    private func convertToText(minutes: Int, seconds: Int) -> String {
        let minutesAsString = "\(minutes)"
        let secondsAsString = "\(seconds < 10 ? "0" : "")\(seconds)"
        return "\(minutesAsString):\(secondsAsString)"
    }
    
    private func updatetimeOutProgressView(){
        timeOutProgressView.progress = getProgress()
    }
    
    private func getProgress() -> Float {
        guard let timeout = timeout else {
            return 0.0
        }
        return Float(currentTime) / Float(timeout)
    }
    
    private func playSound(){
        let audioPath = Bundle.main.path(forResource: "sound1", ofType: "mp3")!
        let url = URL(fileURLWithPath: audioPath)
        do {
            bombSoundEffect = try AVAudioPlayer(contentsOf: url)
            bombSoundEffect?.play()
        } catch{
            print("Error")
        }
    }
    
}

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
