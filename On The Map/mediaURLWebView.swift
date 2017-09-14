//
//  mediaURLWebView.swift
//  On The Map
//
//  Created by Zach Eidenberger on 9/14/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit

class mediaURLWebView: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView = UIWebView()
    @IBOutlet weak var navBar = UINavigationBar()
    @IBOutlet weak var doneButton = UIButton()
    
    var mediaURL = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        webView?.scalesPageToFit = true
        webView?.scrollView.isScrollEnabled = true
        print(mediaURL)
        
        let request = URLRequest(url: URL(string: "https://\(ParseClient.parseConstants.currentMediaURL)")!)
        webView?.loadRequest(request)
        
        
    }
    
    

    @IBAction func dismissMediaURL() {
        dismiss(animated: true, completion: nil)
    }
    

}
    

