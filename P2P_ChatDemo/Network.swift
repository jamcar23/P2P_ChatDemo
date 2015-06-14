//
//  Network.swift
//  P2P_ChatDemo
//
//  Created by James Carroll on 6/6/15.
//  Copyright (c) 2015 James Carroll. All rights reserved.
//

import Foundation

// This class conforms to NSStreamDelegate as an extension.

class Network: NSObject {
  var iStream: NSInputStream?
  var oStream: NSOutputStream?
  var host: String
  var port: Int
  var delegate: AnyObject!
  
  override init() {
    self.host = ""
    self.port = 0
    
    super.init()
  }
  
  init(host: String, port: Int) {
    self.host = host
    self.port = port
    
    super.init()
  }
  
  func connect() {
    NSStream.getStreamsToHostWithName(host, port: port, inputStream: &iStream, outputStream: &oStream)
    
    if let i = iStream, let o = oStream {
      i.delegate = self
      o.delegate = self
      
      i.scheduleInRunLoop(.currentRunLoop(), forMode: NSDefaultRunLoopMode)
      o.scheduleInRunLoop(.currentRunLoop(), forMode: NSDefaultRunLoopMode)
      
      i.open()
      o.open()
    }
  }
  
  func disconnect() {
    if let i = iStream, let o = oStream {
      i.close()
      o.close()
    }
  }
  
  func sendMessage(message m: String!) {
    if let o = oStream {
      let d = m.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
      o.write(UnsafePointer(d!.bytes), maxLength: d?.length ?? 0)
    }
  }
  
  func getPeersFromBootstrap() {
    if let o = oStream {
      let d = SIP.registerPeers().dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
      o.write(UnsafePointer(d!.bytes), maxLength: d!.length)
    }
  }
  
  func getMessage() {
    if let i = iStream {
      let data = NSMutableData()
      let buffer = UnsafeMutablePointer<UInt8>.alloc(1024)
      var len: Int
      var str = ""
      
      if i.hasBytesAvailable {
        len = i.read(buffer, maxLength: 1024)
        
        if len > 0 {
          data.appendBytes(buffer, length: len)
          str = NSString(data: data, encoding: NSUTF8StringEncoding) as? String ?? ""
          
          println(str)
          if let crVC = delegate as? ChatRoomViewController {
            if str != "" {
              crVC.handleReceivedMessages(message: str)
            }
          }
        }
      }
      
      buffer.dealloc(1024)
      len = 0
      data.length = 0
    }
  }
}

extension Network: NSStreamDelegate {
  func stream(aStream: NSStream, handleEvent eventCode: NSStreamEvent) {
    if aStream === iStream {
      switch eventCode {
      case NSStreamEvent.ErrorOccurred:
        break
      case NSStreamEvent.OpenCompleted:
        break
      case NSStreamEvent.HasBytesAvailable:
        getMessage()
        break
      default:
        break
      }
    } else if aStream === oStream {
      switch eventCode {
      case NSStreamEvent.ErrorOccurred:
        break
      case NSStreamEvent.OpenCompleted:
        break
      case NSStreamEvent.HasSpaceAvailable:
        break
      default:
        break
      }
    }
  }
}