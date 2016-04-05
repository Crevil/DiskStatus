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

    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var window: NSWindow!
    
    var dataLocator: DataLocator!
    var unitConverter: UnitConverter!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        statusItem.title = "Loading..."
        statusItem.menu = statusMenu
        
        dataLocator = DataLocator(strategy: FreeDiskSpaceLocator())
        unitConverter = UnitConverter(strategy: ByteConverterStrategy())
        
        getData()
    }
    
    func getData() {
        let value = dataLocator.getData()
        statusItem.title = unitConverter.toString(value)
    }
    
    @IBAction func freeDiskSpace(sender: NSMenuItem) {
        if dataLocator.strategy is FreeDiskSpaceLocator {
            return
        }
        
        dataLocator.setStrategy(FreeDiskSpaceLocator())
        getData()
    }
    
    @IBAction func usedDiskSpace(sender: AnyObject) {
        if dataLocator.strategy is UsedDiskSpaceLocator {
            return
        }
        
        dataLocator.setStrategy(UsedDiskSpaceLocator())
        getData()
    }
}
