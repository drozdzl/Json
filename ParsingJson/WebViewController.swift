//
//  WebViewController.swift
//  ParsingJson
//
//  Created by luk dro on 4/3/17.
//  Copyright © 2017 luk dro. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
   
    var url : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.loadRequest(URLRequest(url: URL(string: url!)!))
    

    
    }
}
