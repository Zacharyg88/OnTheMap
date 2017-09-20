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
    @IBOutlet weak var activityIndicator = UIActivityIndicatorView()
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator?.hidesWhenStopped = true
        activityIndicator?.startAnimating()
        webView?.scalesPageToFit = true
        webView?.scrollView.isScrollEnabled = true
        let request = URLRequest(url: URL(string: "https://www.udacity.com/account/auth#!/signup")!)
        webView?.loadRequest(request)
        }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator?.stopAnimating()
    }
    
    @IBAction func closeWebView() {
        dismiss(animated: true, completion: nil)
    }
    
}
