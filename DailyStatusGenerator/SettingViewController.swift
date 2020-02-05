//
//  SettingViewController.swift
//  TextTransformer
//
//  Created by Shubham Ojha on 28/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Cocoa

struct keys {
    static let shared = keys()
    let PROJECT_TITLE = "projectTitle"
    let RECEIVER_FIRST_NAME = "receiverFirstName"
    let YOUR_NAME = "yourName"
    let YOUR_DESIGNATION = "yourDesignation"
    let REGARDS_TEXT = "regardsText"
}

class SettingViewController: NSViewController {
    @IBOutlet weak var tf_projectTitle: NSTextField!
    @IBOutlet weak var tf_toFirstName: NSTextField!
    @IBOutlet weak var tf_yourName: NSTextField!
    @IBOutlet weak var tf_yourDesignation: NSTextField!
    @IBOutlet weak var tf_regardsText: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        prefillTexts()
    }
    
    func prefillTexts(){
        self.tf_projectTitle.stringValue =      UserDefaults.standard.value(forKey: keys.shared.PROJECT_TITLE) as! String
        self.tf_toFirstName.stringValue =       UserDefaults.standard.value(forKey: keys.shared.RECEIVER_FIRST_NAME) as! String
        self.tf_yourName.stringValue =          UserDefaults.standard.value(forKey: keys.shared.YOUR_NAME) as! String
        self.tf_yourDesignation.stringValue =   UserDefaults.standard.value(forKey: keys.shared.YOUR_DESIGNATION) as! String
        self.tf_regardsText.stringValue =       UserDefaults.standard.value(forKey: keys.shared.REGARDS_TEXT) as! String
    }
    
    @IBAction func action_saveButton(_ sender: Any) {
        UserDefaults.standard.set(tf_projectTitle.stringValue, forKey: keys.shared.PROJECT_TITLE)
        UserDefaults.standard.set(tf_toFirstName.stringValue, forKey: keys.shared.RECEIVER_FIRST_NAME)
        UserDefaults.standard.set(tf_yourName.stringValue, forKey: keys.shared.YOUR_NAME)
        UserDefaults.standard.set(tf_yourDesignation.stringValue, forKey: keys.shared.YOUR_DESIGNATION)
        UserDefaults.standard.set(tf_regardsText.stringValue, forKey: keys.shared.REGARDS_TEXT)
        self.view.window?.close()
    }
}
