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
        let launcherApplicationIdentifier = "CaveOfCode.LauncherApplication"
        
        var startedAtLogin = false
        for app in NSWorkspace.shared().runningApplications {
            if app.bundleIdentifier == launcherApplicationIdentifier {
                startedAtLogin = true
            }
        }
        
        if startedAtLogin {
            DistributedNotificationCenter.default().post(name: "killme", object: Bundle.main.bundleIdentifier!)
            NSLog("Kill launcher")
        } else {
            NSLog("Not started at login")
        }
    }
    
    func applicationWillTerminate(_ notification: Notification) {
    }
}
