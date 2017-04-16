//
//  SettingsWindow.swift
//  DiskStatus
//
//  Created by Bjørn Sørensen on 09/04/16.
//  Copyright © 2016 Bjørn Sørensen. All rights reserved.
//

import Cocoa

protocol SettingsWindowDelegate {
    func settingsUpdated()
}

class SettingsWindow: NSWindowController, NSWindowDelegate {
    @IBOutlet weak var refreshRateSelector: NSPopUpButton!
    @IBOutlet weak var startOnButtonCheckBox: NSButtonCell!
    
    var delegate: SettingsWindowDelegate?
    var settingsManager: SettingsManagerProtocol?
    
    override var windowNibName : String! {
        return "SettingsWindow"
    }
    
    init(settingsManager: SettingsManagerProtocol) {
        super.init(window: nil)
        
        self.settingsManager = settingsManager
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        setDropDown()
        setStartOnBoot()
        
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    func setStartOnBoot() {
        let state = settingsManager?.getStartOnBoot()
        
        startOnButtonCheckBox!.state = state!
    }
    
    func setDropDown() {
        let refreshRates = settingsManager?.getRefreshRates()
        
        refreshRateSelector.addItems(withTitles: (refreshRates?.map {
            (double) -> String in
            return String(double)
            })!)
        
        let storedRefreshRateIndex = settingsManager!.getRefreshRateIndex()
        
        refreshRateSelector.selectItem(at: storedRefreshRateIndex)
    }
    
    func windowWillClose(_ notification: Notification) {
        let value = refreshRateSelector.indexOfSelectedItem
        
        settingsManager!.setRefreshRateIndex(value)
        settingsManager!.setStartOnBoot(startOnButtonCheckBox.state)
        
        delegate?.settingsUpdated()
    }
}
