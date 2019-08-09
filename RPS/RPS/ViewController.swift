//
//  ViewController.swift
//  RPS
//
//  Created by Nyi Nyi Zaw on 8/5/19.
//  Copyright © 2019 Nyi Nyi Zaw. All rights reserved.
//

import UIKit
import ReSwift

class ViewController: UIViewController, StoreSubscriber {

    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var placeholder1: UILabel!
    @IBOutlet weak var placeholder2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.subscribe(self)
    }
    
    @IBAction func restartGame(_ sender: Any) {
        store.dispatch(ChooseWeaponAction(weapon: .rock, restart: true))
    }
    
    @IBAction func rockButton(_ sender: Any) {
        
        store.dispatch(ChooseWeaponAction(weapon: .rock,restart: false))
    }
    
    @IBAction func paperButton(_ sender: Any) {
        store.dispatch(ChooseWeaponAction(weapon: .paper,restart: false))
        
    }
    
    @IBAction func scissorsButton(_ sender: Any) {
        store.dispatch(ChooseWeaponAction(weapon: .scissors,restart: false))
    }
    
    func newState(state: AppState) {
        message.text = state.message.rawValue
        
        if state.restart {
            placeholder1.text = "Choose"
            placeholder2.text = "Choose"
        }else {
            
            if state.player2Play.chosen {
                placeholder1.text = state.player1Play.weapon?.rawValue
                placeholder2.text = state.player2Play.weapon?.rawValue
                
            } else {
                placeholder1.text = state.player1Play.chosen ? "chosen" : ""
            }
        }
       
    }
    
}

