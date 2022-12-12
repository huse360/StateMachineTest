//
//  SimpleTraficLightController.swift
//  StateMachineTest
//
//  Created by huse on 10/12/22.
//

import UIKit

class SimpleTraficLightController : UIViewController {
    enum MessageID {
        case goNext
    }
    
    enum StateID {
        case red
        case yellow
        case yellow2
        case green
    }
    
    var machine : [StateID : [ MessageID : StateID] ] = [:]
    var states : [StateID : Action] = [:]
    var currentState : StateID = .red
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        initMachine()
        initStates()
        
        execute()
        
    }
}


extension SimpleTraficLightController {
    ///#Dot
    /// layout="dot";
    /// nodesep= 2
    /// start = 6;
    /// node [shape = egg];
    /// edge [len=3.5];
    /// edge [penwidth = 2.2]

    /// node [color = gray];
    /// node [fontcolor = black]


    /// edge [color = gray]
    /// edge [fontcolor = black]


    
    ///#EndDot
    
    ///#States
    func initMachine() {
        machine[.red] = [
            .goNext : .yellow
        ]
  
        machine[.yellow] = [
            .goNext : .green
        ]
  
        machine[.yellow2] = [
            .goNext : .red
        ]
 
        machine[.green] = [
            .goNext : .yellow2
        ]
        
    }
    ///#EndStates
    
    
    func initStates() {
         states[.red] = {
             self.view.backgroundColor = .red

             self.sendMessageAndExecute(msg: .goNext, delay: 2.0)
             
         }
        
        states[.yellow] = yellow
        
        states[.yellow2] = yellow
        
        states[.green] = {
             self.view.backgroundColor = .green
             
             self.sendMessageAndExecute(msg: .goNext, delay: 2.0)
        }
    }
    
    func yellow() {
        self.view.backgroundColor = .yellow
        
        self.sendMessageAndExecute(msg: .goNext, delay: 2.0)
    }
    
    func sendMessage(msg: MessageID) {
        guard
            let nextState = machine[currentState]?[msg]
        else { return }
        currentState = nextState
    }
    
    func execute() {
        states[currentState]?()
    }
    
    func sendMessageAndExecute(msg: MessageID) {
        sendMessage(msg: msg)
        execute()
    }
    
    func sendMessageAndExecute(msg: MessageID, delay: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.sendMessageAndExecute(msg: .goNext)
        }
    }
    
    
    
    
}
