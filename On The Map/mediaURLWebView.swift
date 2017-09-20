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
    @IBOutlet weak var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator?.startAnimating()
        webView?.scalesPageToFit = true
        webView?.scrollView.isScrollEnabled = true
        
        if ParseClient.parseConstants.currentMediaURL != "" {
        let mediaURL = URL(string: (ParseClient.parseConstants.currentMediaURL))
        let request = URLRequest(url: mediaURL!)
        webView?.loadRequest(request)
        }else {
            let alert = UIAlertController(title: "Missing Media URL", message: "There doesn't appear to be a Media URL associated with this user.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { action in
                self.dismiss(animated: true, completion: nil)
                
                }))
        }
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator?.stopAnimating()
        activityIndicator?.isHidden = true
    }
    

    @IBAction func dismissMediaURL() {
        dismiss(animated: true, completion: nil)
    }
    

}
    

