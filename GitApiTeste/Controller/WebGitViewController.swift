//
//  WebGitViewController.swift
//  GitApiTeste
//
//  Created by Italus Rodrigues do Prado on 14/03/19.
//  Copyright © 2019 Italus Rodrigues do Prado. All rights reserved.
//

import UIKit
import WebKit

class WebGitViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadingAnimation.run()
        webView.navigationDelegate = self
        if let urlGit = url, let link = URL(string: urlGit){
            webView.load(URLRequest(url: link))
            
        }
    }

}

extension WebGitViewController: WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        LoadingAnimation.stop()
    }
}
