//
//  Actionable.swift
//  StateMachineTest
//
//  Created by huse on 10/12/22.
//

import Foundation

typealias Action = () -> Void

enum Messageable : Hashable {}

enum Stateable : Hashable {}

protocol Actionable : AnyObject{
//    var machine : [Stateable : [ Messageable : Stateable] ] { get set }
//    var states : [Stateable : Action] {get set}
//    var currentState : Stateable {get set}
    func initMachine()
    func initStates()
    func sendMessage(msg : Messageable)
}

//extension Actionable {
//    func sendMessage(msg : Messageable) -> Stateable? {
//        machine[currentState]?[msg]
//    }
//}
