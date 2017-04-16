//
//  AppDelegate.swift
//  LauncherApplication
//
//  Created by Bjørn Sørensen on 07/09/16.
//  Copyright © 2016 Bjørn Sørensen. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mainAppIdentifier = "CaveOfCode.DiskStatus"
        let running = NSWorkspace.shared().runningApplications
        var alreadyRunning = false
        
        for app in running {
            if app.bundleIdentifier == mainAppIdentifier {
                alreadyRunning = true
                break
            }
        }
        
        if !alreadyRunning {
            DistributedNotificationCenter.default().addObserver(self, selector: "terminate", name: "killme", object: mainAppIdentifier)
            
            let path = Bundle.main.bundlePath as NSString
            var components = path.pathComponents
            components.removeLast()
            components.removeLast()
            components.removeLast()
            components.append("MacOS")
            components.append("DiskStatus")
            
            let newPath = NSString.path(withComponents: components)
            NSLog("Launch DiskStatus: " + newPath)
            NSWorkspace.shared().launchApplication(newPath)
        }
        else {
            self.terminate()
        }
    }
    
    func terminate() {
        NSLog("Terminating")
        NSApp.terminate(nil)
    }
}

