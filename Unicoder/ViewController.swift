//
//  ViewController.swift
//  Unicoder
//
//  Created by Fnoz on 16/7/27.
//  Copyright © 2016年 Fnoz. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextViewDelegate {
    
    var topTextView:NSTextView! = nil
    var bottomTextView:NSTextView! = nil
    var typeLabel:NSTextField! = nil
    override func viewDidAppear() {
        let win = view.window!
        win.backgroundColor = NSColor.init(red: 252/255.0, green: 252/255.0, blue: 250/255.0, alpha: 1)
        win.titlebarAppearsTransparent = true
        win.title = ""
        win.styleMask = win.styleMask | NSFullSizeContentViewWindowMask;
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(update(_:)), name: NSTextViewDidChangeSelectionNotification, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.init(red: 252/255.0, green: 252/255.0, blue: 250/255.0, alpha: 1).CGColor
        view.layer?.cornerRadius = 5
        
        let titleLabel = NSTextField.init(frame: CGRect.init(x: (view.frame.width - 100)/2 + 10, y: view.frame.height - 35, width: 100, height: 30))
        titleLabel.stringValue = "Unicoder"
        titleLabel.bezeled = false
        titleLabel.drawsBackground = false
        titleLabel.editable = false
        titleLabel.selectable = false
        titleLabel.font = NSFont.init(name: "Eurostile", size: 20)
        titleLabel.textColor = NSColor.init(red: 230/255.0, green: 75/255.0, blue: 21/255.0, alpha: 1)
        view.addSubview(titleLabel)
        
        let topStartLabel = NSTextField.init(frame: CGRect.init(x: 8, y: view.frame.height - 52, width: 20, height: 20))
        topStartLabel.stringValue = ">"
        topStartLabel.bezeled = false
        topStartLabel.drawsBackground = false
        topStartLabel.editable = false
        topStartLabel.selectable = false
        topStartLabel.font = NSFont.systemFontOfSize(20)
        topStartLabel.textColor = NSColor.init(red: 230/255.0, green: 75/255.0, blue: 21/255.0, alpha: 1)
        view.addSubview(topStartLabel)
        
        topTextView = NSTextView.init(frame: CGRect.init(x: 30, y: view.frame.height / 2 - 2, width: view.frame.width - 10 - 30, height: (view.frame.height - 10 * 2 - 50) / 2))
        topTextView.backgroundColor = NSColor.clearColor()
        topTextView.insertionPointColor = NSColor.init(red: 108/255.0, green: 113/255.0, blue: 196/255.0, alpha: 1)
        topTextView.textColor = NSColor.init(red: 108/255.0, green: 113/255.0, blue: 196/255.0, alpha: 1)
        topTextView.font = NSFont.systemFontOfSize(18)
        topTextView.delegate = self
        view.addSubview(topTextView)
        
        typeLabel = NSTextField.init(frame: CGRect.init(x: view.frame.width - 80, y: view.frame.height / 2 - 12, width: 70, height: 20))
        typeLabel.stringValue = "  Unicode"
        typeLabel.bezeled = false
        typeLabel.drawsBackground = false
        typeLabel.editable = false
        typeLabel.selectable = false
        typeLabel.font = NSFont.init(name: "Eurostile", size: 15)
        typeLabel.wantsLayer = true
        typeLabel.layer?.borderColor = NSColor.init(red: 230/255.0, green: 75/255.0, blue: 21/255.0, alpha: 1).CGColor
        typeLabel.layer?.borderWidth = 2
        typeLabel.textColor = NSColor.init(red: 230/255.0, green: 75/255.0, blue: 21/255.0, alpha: 1)
        view.addSubview(typeLabel)
        
        let bottomStartLabel = NSTextField.init(frame: CGRect.init(x: 8, y: view.frame.height / 2 - 42, width: 20, height: 20))
        bottomStartLabel.stringValue = ">"
        bottomStartLabel.bezeled = false
        bottomStartLabel.drawsBackground = false
        bottomStartLabel.editable = false
        bottomStartLabel.selectable = false
        bottomStartLabel.font = NSFont.systemFontOfSize(20)
        bottomStartLabel.textColor = NSColor.init(red: 230/255.0, green: 75/255.0, blue: 21/255.0, alpha: 1)
        view.addSubview(bottomStartLabel)
        
        bottomTextView = NSTextView.init(frame: CGRect.init(x: 30, y: 10 - 1, width: view.frame.width - 10 - 30, height: (view.frame.height - 10 * 2 - 50) / 2))
        bottomTextView.editable = false
        bottomTextView.backgroundColor = NSColor.clearColor()
        bottomTextView.font = NSFont.systemFontOfSize(18)
        bottomTextView.textColor = NSColor.init(red: 108/255.0, green: 113/255.0, blue: 196/255.0, alpha: 1)
        view.addSubview(bottomTextView)
        
        let segmentControl = NSSegmentedControl.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 20))
        segmentControl.setLabel("Unicode", forSegment: 0)
        segmentControl.setLabel("UTF8", forSegment: 1)
        segmentControl.setLabel("UTF16", forSegment: 2)
        view.addSubview(segmentControl)
    }
    
    func update(noti:NSNotification) {
        let textView = noti.object as! NSTextView
        if textView == topTextView {
            let string = textView.string
            bottomTextView.string = unicodeHandle(string!) as String
        }
    }
    
    func unicodeHandle(string:NSString) -> NSString {
        if string.rangeOfString("\\u").location != NSNotFound {
            return unicodeToString(string)
        }
        else {
            return stringToUnicoder(string)
        }
    }
    
    func unicodeToString(string:NSString) -> NSString {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding)
        var resultStr = NSString.init(data: data!, encoding: NSNonLossyASCIIStringEncoding)
        if resultStr == nil {
            resultStr = ""
        }
        return resultStr!
    }
    
    func stringToUnicoder(string:NSString) -> NSString {
        let data = string.dataUsingEncoding(NSNonLossyASCIIStringEncoding)
        return NSString.init(data: data!, encoding: NSUTF8StringEncoding)!
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}

