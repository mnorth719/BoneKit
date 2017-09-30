//
//  ViewController.swift
//  MattKit
//
//  Created by Matt North on 09/29/2017.
//  Copyright (c) 2017 Matt North. All rights reserved.
//

import UIKit
import MattKit

struct Menu: Codable {
    var title: String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let webClient = WebClient()
        webClient.request(URL(string: "")!, headers: nil, method: .GET).then { (result: Menu) in
            print(result)
        }.always {
            // stop loading
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

