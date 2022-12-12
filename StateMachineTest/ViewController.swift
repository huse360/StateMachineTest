//
//  ViewController.swift
//  StateMachineTest
//
//  Created by huse on 4/12/22.
//

import UIKit



class ViewController: UIViewController {

    let label : UILabel = {
        let label = UILabel()
        label.text = "..."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.layer.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.6047229893)
        
        return label
    }()
    
    let button1 : UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Hello World", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        
        button.layer.cornerRadius = 24
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.backgroundColor = button.tintColor.cgColor
        button.tintColor = .white
        
        button.contentEdgeInsets = .init(top: 10, left: 20, bottom: 10, right: 20)
        
        button.addTarget(self, action: #selector(onButton1(_:)), for: .touchUpInside)
        
        return button
    }()
    
    @objc func onButton1(_ sender: UIButton) {
        
        guard let text = self.buttons[0].titleLabel?.text else { return }
        guard let msg = MessageID(rawValue: text) else { return }
        
        sendMessage(msg: msg)
        states[currentState]?()
        
    }
    
    let button2 : UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Hello World", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        
        button.layer.cornerRadius = 24
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.backgroundColor = button.tintColor.cgColor
        button.tintColor = .white
        
        button.contentEdgeInsets = .init(top: 10, left: 20, bottom: 10, right: 20)
        
        button.addTarget(self, action: #selector(onButton2(_:)), for: .touchUpInside)
       
        
        return button
    }()
    
    @objc func onButton2(_ sender: UIButton) {
        guard let text = self.buttons[1].titleLabel?.text else { return }
        guard let msg = MessageID(rawValue: text) else { return }
        
        sendMessage(msg: msg)
        states[currentState]?()
    }
    
    let button3 : UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Hello World", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        
        button.layer.cornerRadius = 24
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.backgroundColor = button.tintColor.cgColor
        button.tintColor = .white
        
        button.contentEdgeInsets = .init(top: 10, left: 20, bottom: 10, right: 20)
        
        button.addTarget(self, action: #selector(onButton3(_:)), for: .touchUpInside)
       
        return button
    }()
    
    @objc func onButton3(_ sender: UIButton) {
        guard let text = self.buttons[2].titleLabel?.text else { return }
        guard let msg = MessageID(rawValue: text) else { return }
        
        sendMessage(msg: msg)
        states[currentState]?()
    }
    
    var buttons : [UIButton] = []
    
    let imageNames = [
        "10-desert",
        "20-room1",
        "30-room2",
        "40-stairs",
        
        "50-spider",
        "60-lava",
        "70-room3",
        "80-treasure",
    ]
    
    enum MessageID : String {
        case openDoor
        case digMore
        case hallway
        case goDown
        case goUp
        
        case sitInChair
        case openLeftDoor
        case openRightDoor
        case goBack
    }
    
    enum StateID {
        case desert
        case room1
        case room2
        case stairs
        
        case spider
        case lava
        case room3
        case treasure
    }
    
    var machine : [StateID : [ MessageID : StateID] ] = [:]
    var states : [StateID : Action] = [:]
    var currentState : StateID = .desert
    ///  bgcolor = gray12
    //Red gray
    /// node [color = "#d90429"];
    /// node [fontcolor = "#ef233c"]

    /// edge [color = "#8d99ae"]
    /// edge [fontcolor = "#2b2d42"]
    
    ///Red dark blue
    /// node [color = "#d62828"];
    /// node [fontcolor = "#003049"]

    /// edge [color = "#fcbf49"]
    /// edge [fontcolor = "#f77f00"]
    
    ///Black brown
    /// node [color = "#000000"];
    /// node [fontcolor = "#282A3A"]

    /// edge [color = "#C69749"]
    /// edge [fontcolor = "#735F32"]
    
    /// dual red blue
    /// node [color = "#D61C4E"];
    /// node [fontcolor = "#293462"]

    /// edge [color = "#293462"]
    /// edge [fontcolor = "#D61C4E"]
    
    /// joyfull
    /// node [style = filled]
    /// node [fillcolor = "#FF5F00"];
    /// node [color = "#B20600"];
    /// node [fontcolor = white]
    /// node [penwidth = 4.2]

    /// edge [color = "#B20600"]
    /// edge [fontcolor = black]

    ///#Dot

    /// layout="dot";

    /// nodesep = 2;
    /// minlen = 100;
    /// start = 13;
    /// node [shape = egg];
    /// edge [len=4.5];
    /// edge [penwidth = 2.2]

    /// node [color = "#AEB6BF"];
    /// node [fontcolor = "#D35400"]
    /// node [orientation = 90]

    /// edge [color = "#CCD1D1"]
    /// edge [fontcolor = "#3498DB"]


    
    ///#EndDot

    func initMachine() {
        ///#States
        machine[.desert] = [
            .openDoor : .room1,
            .digMore : .stairs,
        ]
        machine[.room1] = [
            .hallway : .room2,
            .goDown : .room3,
            .openDoor : .spider
        ]
        machine[.room2] = [
            .hallway : .room1,
            .sitInChair : .treasure,
            .openDoor : .spider

        ]
        machine[.stairs] = [
            .openDoor : .room1,
            .goDown : .room3

        ]
        machine[.spider] = [
            .openRightDoor : .room2,
            .openLeftDoor : .room1
        ]
        
        machine[.room3] = [
           .openDoor : .lava,
            .goUp : .room1
        ]
        machine[.lava] = [
            .goBack : .room3,        
        ]
        machine[.treasure] = [
            :
        ]
        ///#EndStates
    }
    
    func initStates() {
        states[.desert] = {
            self.label.text = "While digging for treasure in the desert, you find a door"
            
            self.imageView.image = self.images[0]
            
            self.refreshButtons()
            
            debugPrint("state \(StateID.desert)")
        }
        
        states[.room1] = {
            
            self.label.text = "You find a room with a door, a hallway, and a ladder going down long."
           
            
            self.imageView.image = self.images[1]
            
            self.refreshButtons()
            
            debugPrint("state \(StateID.room1)")
        }
        
        states[.room2] = {
            
            self.label.text = "This room has a chair in the middle. \nThere is a door and a hallway here"
            self.imageView.image = self.images[2]
            
            self.refreshButtons()
            
            debugPrint("state \(StateID.room2)")
        }
        
        states[.stairs] = {
            
            self.label.text = "Under the door, you find some stairs"
            
            self.imageView.image = self.images[3]
            
            self.refreshButtons()
            debugPrint("state \(StateID.stairs)")
        }
        
        
        
        states[.spider] = {
            
            self.label.text = "Yikes! \nThe room has a giant spider in it. \nThe room also has two doors"
            
            self.imageView.image = self.images[4]
            
            self.refreshButtons()
            debugPrint("state \(StateID.spider)")
        }
        
        states[.lava] = {
            
            self.label.text = "The room has lava in it.\n You have to go back"
            
            self.imageView.image = self.images[5]
            
            self.refreshButtons()
            
            debugPrint("state \(StateID.lava)")
        }
        
        states[.room3] = {
            
            self.label.text = "You find a room with a door and a ladder going up"
            
            self.imageView.image = self.images[6]
            
            self.refreshButtons()
            
            debugPrint("state \(StateID.room3)")
        }
        
        states[.treasure] = {
            
            self.label.text = "When you sit in the chair,\ntreasure falls from the ceiling.\n You win!"
            
            self.imageView.image = self.images[7]
            
            self.refreshButtons()
            
            debugPrint("state \(StateID.treasure)")
        }
        
    }
    
    
    func refreshButtons() {
        self.buttons.forEach {
            $0.setTitle("     ", for: .normal)
        }
       
        var i = Int(0)
        self.machine[self.currentState]?.forEach { key, value in
                print (" key: \(key)")
            self.buttons[i].setTitle("\(key)", for: .normal)
            i += 1
            
        }
    }
    
//    void _SendMessage(String msg) {
//        currentState = messages[msg];
//        messages = machine[currentState];
//    }
    func sendMessage(msg : MessageID) {
        guard
            let nextState = machine[currentState]?[msg]
        else { return }
        currentState = nextState
    }
    
    func AddNavButtons()
    {
                
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(onRefreshButton))

        
        navigationItem.rightBarButtonItems = [refreshButton]
       
       
    }
    
    @objc func onRefreshButton()
    {
        debugPrint("Refresh...")
        currentState = .desert
        states[currentState]?()
    }
    
    var images : [UIImage] = []
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Find the Treasure"
        
        AddNavButtons()
        
        buttons = [button1, button2, button3]
        
        initStates()
        initMachine()
        
        
//        sendMessage(msg: .msg1)
//        states[currentState]?()
        
                
        images = imageNames.map {
            guard let image = UIImage(named: $0) else { return UIImage()}
            return image
        }
        
        
        
        imageView.contentMode = .scaleAspectFit

        imageView.image = images[4]
        
        states[currentState]?()
        
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        
        view.addSubview(imageView)
        view.addSubview(label)
        
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        button3.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button1.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
            
            button2.centerXAnchor.constraint(equalTo: button1.centerXAnchor),
            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 20),
            
            button3.centerXAnchor.constraint(equalTo: button2.centerXAnchor),
            button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 20),
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5, constant: -20),
            imageView.widthAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.widthAnchor, constant: -20),
            
            label.topAnchor.constraint(equalTo: imageView.topAnchor),
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            label.widthAnchor.constraint(equalTo: imageView.widthAnchor),
        ])
        
    }


}

