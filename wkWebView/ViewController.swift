//
//  ViewController.swift
//  wkWebView
//
//  Created by Tahir Atakan Can on 28.12.2023.
//

import UIKit
import WebKit


class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
    }


}

