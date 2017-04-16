//
//  StatusMenuController.swift
//  DiskStatus
//
//  Created by Bjørn Sørensen on 09/04/16.
//  Copyright © 2016 Bjørn Sørensen. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject, SettingsWindowDelegate {
    @IBOutlet weak var statusMenu: NSMenu!
    
    var settingsWindow: SettingsWindow?
    var settingsManager: SettingsManagerProtocol?
    var foo: String?
    
    var dataLocator: DataLocator!
    var unitConverter: UnitConverter!
    var timer: Timer!
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    override func awakeFromNib() {
        settingsManager = SettingsManager()
        settingsWindow = SettingsWindow(settingsManager: settingsManager!)
        
        settingsWindow!.delegate = self
        
        initApp()
        getData()
        initTimer()
    }
    
    func initApp() {
        statusItem.menu = statusMenu
        statusItem.title = "Loading..."
        
        dataLocator = DataLocator(strategy: FreeDiskSpaceLocator())
        unitConverter = UnitConverter(strategy: ByteConverterStrategy())
    }
    
    func initTimer() {
        let refreshRate = Double((settingsManager?.getRefreshRate())!)
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(
            timeInterval: refreshRate,
            target: self,
            selector: "getData",
            userInfo: nil,
            repeats: true)
    }
    
    func getData() {
        let value = dataLocator.getData()
        statusItem.title = unitConverter.toString(value)
    }
    
    func settingsUpdated() {
        initTimer()
    }
    
    //
    // Menu actions
    //
    @IBAction func freeDiskSpaceClicked(_ sender: NSMenuItem) {
        if dataLocator.strategy is FreeDiskSpaceLocator {
            return
        }
        
        dataLocator.setStrategy(FreeDiskSpaceLocator())
        getData()
    }
    
    @IBAction func usedDiskSpaceClicked(_ sender: AnyObject) {
        if dataLocator.strategy is UsedDiskSpaceLocator {
            return
        }
        
        dataLocator.setStrategy(UsedDiskSpaceLocator())
        getData()
    }
    
    @IBAction func settingsClicked(_ sender: NSMenuItem) {
        settingsWindow?.showWindow(nil)
    }
    
    @IBAction func closeClicked(_ sender: AnyObject) {
        statusMenu.title = "Closing..."
        timer?.invalidate()
        
        NSApplication.shared().terminate(self)
    }
}
