//
//  HppWKWebView.swift
//  Acquired_SDK_IOS
//
//  Created by Xiaoping Li on 2018/9/4.
//  Copyright © 2018 Acquired. All rights reserved.
//

import Foundation
import WebKit



class HppViewController : UIViewController,WKUIDelegate, WKNavigationDelegate,UIWebViewDelegate{
    
    private var hppView : WKWebView?
    public var hppUrl : String?
    lazy private var progressView: UIProgressView = {
        self.progressView = UIProgressView.init(frame: CGRect(x: CGFloat(0), y: CGFloat(1), width: UIScreen.main.bounds.width, height: 2))
        self.progressView.tintColor = UIColor.green
        self.progressView.trackTintColor = UIColor.white
        self.progressView.progress = 0.05
        return self.progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor  = UIColor.white
        setUpWKwebView()
    }
    
    
    func setUpWKwebView() {
        let js = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        let wkUserScript = WKUserScript(source: js, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
        
        let wkUController = WKUserContentController()
        wkUController.addUserScript(wkUserScript)
        
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        preferences.minimumFontSize = 50.0;
        

        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.userContentController = wkUController
        wkWebConfig.preferences = preferences
        
        let  hppView = WKWebView(frame: UIScreen.main.bounds,configuration:wkWebConfig)
        hppView.scrollView.bounces = false
        hppView.load(URLRequest(url: URL(string: (self.hppUrl)!)!))
        
        self.hppView  = hppView
        self.view.addSubview(self.hppView!)
        self.view.addSubview(progressView)
        self.hppView?.uiDelegate = self
        self.hppView?.navigationDelegate = self
        self.hppView?.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
    }
    
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress"{
//            progressView.alpha = 1.0
            progressView.setProgress(Float((self.hppView?.estimatedProgress)! ), animated: true)
            if (self.hppView?.estimatedProgress )!  >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!){
        self.progressView.isHidden = true
    }
    func webViewDidClose(_ webView: WKWebView) {
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    deinit {
        self.hppView?.removeObserver(self, forKeyPath: "estimatedProgress")
        self.hppView?.uiDelegate = nil
        self.hppView?.navigationDelegate = nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    
}
