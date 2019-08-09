//
//  ChooseWeaponAction.swift
//  RPS
//
//  Created by Nyi Nyi Zaw on 8/9/19.
//  Copyright © 2019 Nyi Nyi Zaw. All rights reserved.
//

import Foundation
import ReSwift

struct ChooseWeaponAction : Action {
    var weapon : Weapon
    var restart : Bool
}

func appReducer(action : Action, state : AppState?) -> AppState {
    var state = state ?? AppState()
    
    switch action {
    case let chooseWeaponAction as ChooseWeaponAction:
        state.restart = chooseWeaponAction.restart
        
        if chooseWeaponAction.restart {
            state.turn = Turn(player: .one)
            state.message = .restart
            
            return state
        }
        
        let turn = state.turn
        switch turn.player {
        case .one:
            
            // create a play
            let play = Play(chosen: true, weapon: chooseWeaponAction.weapon)
            state.player1Play = play
            
            // pass the turn to the next player
            state.turn = Turn(player: .two)
            
            // change the message
            state.message = .player2choose
            
        case .two:
            
            // create a play
            let play = Play(chosen: true, weapon: chooseWeaponAction.weapon)
            state.player2Play = play
            
            // calculate who won
            let player1weapon = state.player1Play.weapon ?? .rock
            let player2weapon = state.player2Play.weapon ?? .rock
            
            switch player1weapon {
            case .rock:
                switch player2weapon {
                case .rock:
                    state.result = .draw
                    state.message = .draw
                case .paper:
                    state.result = .player2wins
                    state.message = .player2wins
                case .scissors:
                    state.result = .player1wins
                    state.message = .player1wins
                }
            case .paper:
                switch player2weapon {
                case .rock:
                    state.result = .player1wins
                    state.message = .player1wins
                case .paper:
                    state.result = .draw
                    state.message = .draw
                case .scissors:
                    state.result = .player2wins
                    state.message = .player2wins
                }
            case .scissors:
                switch player2weapon {
                case .rock:
                    state.result = .player2wins
                    state.message = .player2wins
                case .paper:
                    state.result = .player1wins
                    state.message = .player1wins
                case .scissors:
                    state.result = .draw
                    state.message = .draw
                }
            }
            
            state.turn = Turn(player: .one)
        }
        
    default:
        break
    }

    
    return state
}
