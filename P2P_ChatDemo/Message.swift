//
//  Message.swift
//  P2P_ChatDemo
//
//  Created by James Carroll on 6/5/15.
//  Copyright (c) 2015 James Carroll. All rights reserved.
//

import Foundation
import JSQMessagesViewController

class Message: NSObject, JSQMessageData {
  
  enum messageTypes {
    case Sent
    case Received
  }
  
  let message: String
  let type: messageTypes
  let time: String
  let sId: String
  let displayName: String
  static var hashInt: UInt = 0
  
  override init() {
    self.message = ""
    self.type = .Sent
    self.time = ""
    self.sId = ""
    self.displayName = ""
    
    super.init()
  }
  
  init(message: String, type: messageTypes, time: String, sId: String, displayName: String) {
    self.message = message
    self.type = type
    self.time = time
    self.sId = sId
    self.displayName = displayName
    
    super.init()
  }
  
  func senderId() -> String! {
    return self.sId
  }
  
  func senderDisplayName() -> String! {
    return self.displayName
  }
  
  func date() -> NSDate! {
    return NSDate()
  }
  
  func isMediaMessage() -> Bool {
    return false
  }
  
  func messageHash() -> UInt {
    return ++Message.hashInt
  }
  
  func text() -> String! {
    return self.message
  }

  func messageType() -> messageTypes {
    return self.type
  }
  
  class func buildMessage(message m: String, senderName sn: String) -> String {
    return SIP.userOfMessage() + sn + SIP.messageOfMessage() + m + SIP.endOfMessage()
  }
}
