//
//  AppDelegate.swift
//  DiskStatus
//
//  Created by Bjørn Sørensen on 03/04/16.
//  Copyright © 2016 Bjørn Sørensen. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var refreshRate: NSPopUpButton!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
    }
    
    func applicationWillTerminate(_ notification: Notification) {
    }
}
