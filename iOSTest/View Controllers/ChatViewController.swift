//
//  ChatViewController.swift
//  iOSTest
//
//  Created by D & A Technologies on 1/22/18.
//  Copyright © 2018 D & A Technologies. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Using the following endpoint, fetch chat data
     *    URL: http://dev.datechnologies.co/Tests/scripts/chat_log.php
     *
     * 3) Parse the chat data using 'Message' model
     *
     **/
    
    // MARK: - Properties
    private var client: ChatClient?
    private var messages: [Message]?
    
    // MARK: - Outlets
    @IBOutlet weak var chatTable: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messages = [Message]()
        configureTable(tableView: chatTable)
        title = "Chat"
        
        populateMessages()
        
        chatTable.estimatedRowHeight = 100
        chatTable.rowHeight = UITableViewAutomaticDimension
        
        chatTable.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0)
        
        
        // TODO: Remove test data when we have actual data from the server loaded
//        messages?.append(Message(testName: "James", withTestMessage: "Hey Guys! How is it going? Word up kids. I am trying something knew. I hope this doesn't break the app."))
//        messages?.append(Message(testName:"Paul", withTestMessage:"What's up?"))
//        messages?.append(Message(testName:"Amy", withTestMessage:"Hey! :)"))
//        messages?.append(Message(testName:"James", withTestMessage:"Want to grab some food later?"))
//        messages?.append(Message(testName:"Paul", withTestMessage:"Sure, time and place?"))
//        messages?.append(Message(testName:"Amy", withTestMessage:"YAS! I am starving!!!"))
//        messages?.append(Message(testName:"James", withTestMessage:"1 hr at the Local Burger sound good?"))
//        messages?.append(Message(testName:"Paul", withTestMessage:"Sure thing"))
//        messages?.append(Message(testName:"Amy", withTestMessage:"See you there :P"))
 
        chatTable.reloadData()
    }
    
    func populateMessages(){
        let chatTest = ChatClient()
        chatTest.getChatData() { results in
            print("Results: \(results?.description ?? "")")
            
            if let json = results as? [String : Any],
                let arrayOfDictionaries = json["data"] as? [[String: Any]] {
                for dictionary in arrayOfDictionaries {
                    
                    if let newMessage = Message(dictionary: dictionary) {
                        self.messages?.append(newMessage)
                    }
                }
                
                DispatchQueue.main.async {
                    self.chatTable.reloadData()
                }
            }
        }
    }
    
    // MARK: - Private
    private func configureTable(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ChatTableViewCell? = nil
        if cell == nil {
            let nibs = Bundle.main.loadNibNamed("ChatTableViewCell", owner: self, options: nil)
            cell = nibs?[0] as? ChatTableViewCell
        }
        cell?.setCellData(message: messages![indexPath.row])
        let singleMessage = messages![indexPath.row]
        
        URLSession.shared.dataTask(with: singleMessage.avatarURL){(data, _, _)in
            guard let imageData = data
                else {return}
            
            guard let image = UIImage(data: imageData)
                else {return}
            
            DispatchQueue.main.async {
                cell?.userImageView.image = image
            }
        }.resume()
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages!.count
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24.0    }
    
    // MARK: - IBAction
    

}
