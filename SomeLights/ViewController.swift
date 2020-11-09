//
//  ViewController.swift
//  SomeLights
//
//  Created by Nikita Petrenkov on 09/11/2020.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    
    override var prefersStatusBarHidden: Bool {
        false
    }
    
    /// Признак того, что фонарик включён
    var isOn = false

    override func viewDidLoad() {
        super.viewDidLoad()
        changeBackground()
    }

    /// Реагируем на нажатие кнопки
    @IBAction func buttonPressed() {
        
        changeValue()
        interactWithLight()
    }
    
    /// Меняем значение флага
    func changeValue() {
        isOn = !isOn
    }
    
    /// взаимодействуем со вспышкой на реальном девайсе
    func interactWithLight() {
        if let device = AVCaptureDevice.default(for: .video), device.hasTorch {
            
            do {
                try device.lockForConfiguration()
                device.torchMode = isOn ? .on : .off
                device.unlockForConfiguration()
            } catch {
                print(error.localizedDescription)
            }
            
        } else {
            changeBackground()
        }
    }
    

    /// меняем наш фон экрана в зависимости от признака `isOn`
    func changeBackground() {
        view.backgroundColor = isOn ? .white : .black
    }
}

