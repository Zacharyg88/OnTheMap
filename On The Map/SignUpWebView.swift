//
//  SignUpWebView.swift
//  On The Map
//
//  Created by Zach Eidenberger on 9/13/17.
//  Copyright © 2017 ZacharyG. All rights reserved.
//

import UIKit

class signUpWebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView = UIWebView()
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView?.scalesPageToFit = true
        webView?.scrollView.isScrollEnabled = true
        let request = URLRequest(url: URL(string: "https://www.udacity.com/account/auth#!/signup")!)
        webView?.loadRequest(request)
        }
    
    @IBAction func closeWebView() {
        dismiss(animated: true, completion: nil)
    }
    
}
