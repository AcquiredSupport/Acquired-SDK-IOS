//
//  HppWKWebView.swift
//  Acquired_SDK_IOS
//
//  Created by Xiaoping Li on 2018/9/4.
//  Copyright © 2018 Acquired. All rights reserved.
//

import Foundation
import WebKit



class HppViewController : UIViewController, UIWebViewDelegate, NJKWebViewProgressDelegate {
    
    private var hppView : UIWebView?
    public var hppUrl : String?
    var progressView: NJKWebViewProgressView!
    var progressProxy: NJKWebViewProgress!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor  = UIColor.white
        setUpWKwebView()
    }
    
    func setUpWKwebView() {
        let  hppView = UIWebView(frame: UIScreen.main.bounds)
        hppView.scrollView.bounces = false
        self.hppView  = hppView
        self.view.addSubview(self.hppView!)
        
        self.progressProxy = NJKWebViewProgress()
        self.hppView?.delegate = self.progressProxy
        self.progressProxy.webViewProxyDelegate = self
        self.progressProxy.progressDelegate = self
        
        let progressBarHeight: CGFloat = 2
        let navigaitonBarBounds: CGRect = self.navigationController!.navigationBar.bounds
        let barFrame: CGRect = CGRect(x: 0, y: navigaitonBarBounds.size.height-CGFloat(Int(progressBarHeight/2)), width: navigaitonBarBounds.size.width, height: progressBarHeight)
        self.progressView = NJKWebViewProgressView(frame: barFrame)
        self.progressView.progressBarView.backgroundColor = UIColor.orange
        self.progressView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleTopMargin]
        self.progressView.isHidden = true
        
        let escapedString = self.hppUrl!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: escapedString!)!
        let request = URLRequest(url: url)
        self.hppView?.loadRequest(request)
        
//        self.hppView?.loadRequest(URLRequest(url: URL(string: (self.hppUrl)!)!))
    }
    
    deinit {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.addSubview(self.progressView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.progressView.removeFromSuperview()
    }
    
    func webViewProgress(_ webViewProgress: NJKWebViewProgress!, updateProgress progress: Float) {
        if progress > 0 {
            self.progressView.isHidden = false
        }
        self.progressView.setProgress(progress, animated: true)
    }
}
