//
//  ConfigurationViewController.swift
//  TimerApp
//
//  Created by TEO on 9/12/22.
//

import UIKit


class ConfigurationViewController: UIViewController {
    
    private struct Const {
        static let valueDefault = String()
        static let invalidValue = "Valor inválido"
        static let error = "Error"
        static let cancel = "Cancelar"
        static let segueIdentifier = "goToTimer"
    }
    
    @IBOutlet weak var timeOutTextField: UITextField!
    
    //private let brain: ConfigurationBrainProtocol = ConfigurationBrain()
    
    @IBAction func onContinueButtonPressed() {
        sendSeconds()
        self.view.endEditing(true)
    }
    
    private func sendSeconds(){
        let seconds = timeOutTextField.text ?? Const.valueDefault
        if seconds.isEmpty {
            executeAlert()
        }else{
            navigateToTimer()
        }
    }
    
    private func executeAlert(){
        let alert = UIAlertController(title: Const.error, message: Const.invalidValue, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: Const.cancel, style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    private func navigateToTimer(){
        performSegue(withIdentifier: Const.segueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let timerViewController = segue.destination as? TimerViewController else {
            return
        }
        
        guard let timeoutText = timeOutTextField.text,
              let timeoutInt = Int(timeoutText) else {
            return
        }
        
        timerViewController.timeout = timeoutInt
    }
    
}

