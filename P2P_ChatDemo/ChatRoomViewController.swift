//
//  ChatRoomViewController.swift
//  P2P_ChatDemo
//
//  Created by James Carroll on 6/5/15.
//  Copyright (c) 2015 James Carroll. All rights reserved.
//

import UIKit
import JSQMessagesViewController

// This class conforms to the UITableViewDelegate and UI protocol.

class ChatRoomViewController: JSQMessagesViewController {
  var net: Network!
  
  var delegate: ViewController!
  var sId: String!
  var displayName: String!
  var messages = [Message]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    self.senderId = sId
    self.senderDisplayName = displayName
    self.net = delegate.net
    self.net.delegate = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
    if text != "" {
      let m = Message.buildMessage(message: text, senderName: senderDisplayName)
      messages.append(Message(message: text, type: .Sent, time: "", sId: senderId, displayName: senderDisplayName))
      net.sendMessage(message: m)
      finishSendingMessageAnimated(true)
    }
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messages.count
  }
  
  override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
    return messages[indexPath.item]
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let c = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
    let m = messages[indexPath.item]
    c.textView.text = m.text()
    
    return c
  }
  
  override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
    let b = JSQMessagesBubbleImageFactory()
    let m = messages[indexPath.item]
    let i = m.messageType() == .Sent ? b.outgoingMessagesBubbleImageWithColor(UIColor.blueColor()) : b.incomingMessagesBubbleImageWithColor(UIColor.greenColor())
    
    return i
  }
  
  override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
    let m = messages[indexPath.item]
    let name = m.senderDisplayName()
    let initials = String(name[name.startIndex])
    let diameter = m.messageType() == .Sent ? UInt(collectionView.collectionViewLayout.incomingAvatarViewSize.width) : UInt(collectionView.collectionViewLayout.outgoingAvatarViewSize.width)
    
    return JSQMessagesAvatarImageFactory.avatarImageWithUserInitials(initials, backgroundColor: UIColor.grayColor(), textColor: UIColor.whiteColor(), font: UIFont(name: "HelveticaNeue", size: CGFloat(15)), diameter: diameter)
  }
  
  func handleReceivedMessages(message m: String) {
    messages.append(Message(message: m, type: .Received, time: "", sId: "test", displayName: "test"))
    finishReceivingMessageAnimated(true)
  }
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
  // MARK: - IBActions
  
  @IBAction func sendMessage(sender: AnyObject) {
//    if messageBox.text != "" {
//      let f = NSDateFormatter()
//      f.dateStyle = .MediumStyle
//      f.timeStyle = .MediumStyle
//      let d = f.stringFromDate(NSDate())
//      messages.append(Message(message: messageBox.text, type: .Sent, time: d))
//      
//      tableView.reloadData()
//    }
  }
}

// MARK: - JSQMessagesCollectionViewDelegateFlowLayout

extension ChatRoomViewController: JSQMessagesCollectionViewDelegateFlowLayout {
  
}

// MARK: - JSQMessagesCollectionViewDataSource
