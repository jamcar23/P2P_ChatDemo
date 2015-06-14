//
//  ViewController.swift
//  P2P_ChatDemo
//
//  Created by James Carroll on 6/5/15.
//  Copyright (c) 2015 James Carroll. All rights reserved.
//

import UIKit
import JSQMessagesViewController

class ViewController: UIViewController {
  
  // MARK: - IBOutlets

  @IBOutlet weak var username: UITextField!
  
  let segueIdToCrVC = "toChatRoom"
  let net = Network(host: "localhost", port: 12321)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    switch segue.identifier ?? "" {
    case segueIdToCrVC:
      let crVC = segue.destinationViewController as! ChatRoomViewController
      crVC.delegate = self
      crVC.sId = username.text
      crVC.displayName = username.text
    default:
      break
    }
    
  }
  
  // MARK: - IBActions

  @IBAction func joinChatRoom(sender: AnyObject) {
    if username.text != "" {
      net.connect()
      performSegueWithIdentifier(segueIdToCrVC, sender: sender)
    }
  }

}

