//
//  SecondViewController.swift
//  ParsingJson
//
//  Created by luk dro on 4/3/17.
//  Copyright © 2017 luk dro. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var author = ""
    var desc = ""
    var url = ""
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var authorLabel: UILabel!
    
    @IBAction func showNewsButtonPressed(_ sender: Any) {
        let webVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "webview") as! WebViewController
        webVC.url = url
        present(webVC, animated: true)
        
    }
    override func
        viewDidLoad() {
        super.viewDidLoad()
        authorLabel.text = author
        descriptionLabel.text = desc
    }
    
 
}
