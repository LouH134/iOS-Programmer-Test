//
//  ChatTableViewCell.swift
//  iOSTest
//
//  Created by D & A Technologies on 1/22/18.
//  Copyright © 2018 D & A Technologies. All rights reserved.
//

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Setup cell to match mockup
 *
 * 2) Include user's avatar image
 **/

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var body: UILabelPadding!
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var messageLabel: UILabel!
    
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureMessageBorder()
        makeImageRound()
    }
    
    // MARK: - Public
    func setCellData(message: Message) {
        header.text = message.username
        body.text = message.text
    }
    
    func configureMessageBorder(){
        body.layer.borderWidth = 1.0
        body.layer.cornerRadius = 8.0
        body.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    func makeImageRound(){
        userImageView.layer.borderWidth = 1.0
        userImageView.layer.masksToBounds = false
        userImageView.layer.cornerRadius = userImageView.frame.height/2
        userImageView.clipsToBounds = true
        userImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
}
