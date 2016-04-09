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
        
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activateIgnoringOtherApps(true)
    }
    
    func setDropDown() {
        let refreshRates = settingsManager?.getRefreshRates()
        
        refreshRateSelector.addItemsWithTitles((refreshRates?.map {
            (double) -> String in
            return String(double)
            })!)
        
        let storedRefreshRateIndex = settingsManager!.getRefreshRateIndex()
        
        refreshRateSelector.selectItemAtIndex(storedRefreshRateIndex)
    }
    
    func windowWillClose(notification: NSNotification) {
        let value = refreshRateSelector.indexOfSelectedItem
        
        settingsManager!.setRefreshRateIndex(value)
        
        delegate?.settingsUpdated()
    }
}
