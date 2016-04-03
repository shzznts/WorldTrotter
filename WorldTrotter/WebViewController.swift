//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Lincoln Sea on 4/2/16.
//  Copyright © 2016 Lincoln Sea. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Web loaded")
        
        let url = NSURL(string: "https://www.bignerdranch.com/")
        webView.loadRequest(NSURLRequest(URL: url!))
    }
}