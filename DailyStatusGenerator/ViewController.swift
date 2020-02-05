//
//  ViewController.swift
//  TextTransformer
//
//  Created by Shubham on 27/09/19.
//  Copyright © 2019 Shubham. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var tf: NSTextField!
    @IBOutlet weak var tf_result: NSTextField!
    
    @IBOutlet weak var btn_convert: NSButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func action_convert(_ sender: Any) {
        let gitLog = self.tf.stringValue
        var status = getStatus(gitLog: gitLog)
        let projectName = UserDefaults.standard.value(forKey: keys.shared.PROJECT_TITLE) as! String
        let toName = UserDefaults.standard.value(forKey: keys.shared.RECEIVER_FIRST_NAME) as! String
        let fromName = UserDefaults.standard.value(forKey: keys.shared.YOUR_NAME) as! String
        let fromDesignation = UserDefaults.standard.value(forKey: keys.shared.YOUR_DESIGNATION) as! String
        let regardsMsg = UserDefaults.standard.value(forKey: keys.shared.REGARDS_TEXT) as! String
        status = self.addTitle(title: "\(projectName) iOS App Status", completeStatus: status)
        status = self.addNewStatus(newStatusText: "Code Commit on AWS(Done)", completeStatus: status)
        status = self.addNewStatus(newStatusText: "Export ipa for testing locally(Done)", completeStatus: status)
        status = self.addNewStatus(newStatusText: "Export ipa for uploading on Testflight(Done)", completeStatus: status)
        status = self.addEmailInfo(toName: toName, fromName: fromName, fromDesignation: fromDesignation, regardsMessage: regardsMsg, completeStatus: status)
        self.tf_result.stringValue = status
    }
    
    @IBAction func action_clear(_ sender: Any) {
        self.tf.stringValue = ""
    }
    var statusCounter = 0
    
    func getStatus(gitLog: String) -> String{
        var temp = """
        commit 2393217c43e32ae3eef27b5fc7002e12e6cf0808 (HEAD -> development)
        Author: Shubham Ojha <ojhashubham29@gmail.com>
        Date:   Fri Sep 27 13:04:05 2019 +0530
        
        Issues #46, #48, #53 Replace branding
        
        commit 040755a22c5ccb567aab685efb47811c4ba40b38
        Author: Shubham Ojha <ojhashubham29@gmail.com>
        Date:   Thu Sep 26 20:19:42 2019 +0530
        
        Add Sticky note bug fix
        
        commit 312da7ace689647420af63142c0e055a6afa81d6
        Author: Shubham Ojha <ojhashubham29@gmail.com>
        Date:   Thu Sep 26 18:05:35 2019 +0530
        
        Resolved issues #522 #523 #524 #517 #512
        
        commit f362b8d67088fa7b9d30994ab084204ddad6f871
        Author: Shubham Ojha <ojhashubham29@gmail.com>
        Date:   Thu Sep 26 12:13:59 2019 +0530
        
        Changes for Hiding Things in Booking Details, Account Details
        
        """
        temp = gitLog
        let regex = try! NSRegularExpression(pattern: "commit(.*)\n *", options: NSRegularExpression.Options.caseInsensitive)
        let range = NSMakeRange(0, temp.count)
        let temp1 = regex.stringByReplacingMatches(in: temp, options: [], range: range, withTemplate: "")
        print("removing commit ids")
        
        let regex2 = try! NSRegularExpression(pattern: "Author(.*)\n *", options: NSRegularExpression.Options.caseInsensitive)
        let range2 = NSMakeRange(0, temp1.count)
        let temp2 = regex2.stringByReplacingMatches(in: temp1, options: [], range: range2, withTemplate: "")
        print("removing commit Author")
        
        let regex3 = try! NSRegularExpression(pattern: "Date(.*)\n\n *", options: NSRegularExpression.Options.caseInsensitive)
        let range3 = NSMakeRange(0, temp2.count)
        var temp3: String = regex3.stringByReplacingMatches(in: temp2, options: [], range: range3, withTemplate: "((1))")
        print("removing date")
        
        var i=0
        while temp3.range(of: "((1))") != nil {
            i = i+1
            statusCounter = i
            if let range = temp3.range(of: "((1))") {
                temp3 = temp3.replacingCharacters(in: range, with: "(\(i))")
            }
        }
        
        return temp3
    }
    
    func addEmailInfo(toName: String,
                      fromName: String,
                      fromDesignation: String,
                      regardsMessage: String,
                      completeStatus: String) -> String{
        
        let hiMessage = "Hi \(toName),\n\n"
        let endSignature = "\n" + regardsMessage + ",\n" + fromName + ",\n" + fromDesignation
        let finalMessage = hiMessage + completeStatus + endSignature
        return finalMessage
    }
    
    func addTitle(title: String, completeStatus: String) -> String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/MM/YYYY"
        let date = Date()
        let currentDate = dateformatter.string(from: date)
        return title + " " + currentDate + "\n\n" + completeStatus
    }
    
    func addNewStatus(newStatusText: String, completeStatus: String)->String {
        self.statusCounter = self.statusCounter + 1
        return completeStatus + "\n(\(self.statusCounter))\(newStatusText)\n"
    }
    
    @IBAction func action_copyStatus(_ sender: Any) {
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        pasteboard.setString(self.tf_result.stringValue, forType: NSPasteboard.PasteboardType.string)
    }
    
    @IBAction func action_clearResult(_ sender: Any) {
        self.tf_result.stringValue = ""
    }
}

