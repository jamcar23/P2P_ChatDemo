//
//  SIP.swift
//  P2P_ChatDemo
//
//  Created by James Carroll on 6/11/15.
//  Copyright (c) 2015 James Carroll. All rights reserved.
//

import Foundation

class SIP {
  class func registerPeers() -> String {
    return "REGISTER:"
  }
  
  class func invitePeers() -> String {
    return "INVITE:"
  }
  
  class func acknowledgePeers() -> String {
    return "ACK:"
  }
  
  class func userOfMessage() -> String {
    return "user:"
  }
  
  class func peersOfMessage() -> String {
    return ":peers:"
  }
  
  class func messageOfMessage() -> String {
    return ":message:"
  }
  
  class func endOfMessage() -> String {
    return ":end"
  }
}