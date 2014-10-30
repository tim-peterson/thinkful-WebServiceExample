//
//  ViewController.swift
//  WebServiceExample
//
//  Created by Tim Peterson on 10/30/14.
//  Copyright (c) 2014 Tim Peterson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myNameLabel.alpha = 0.0 //hide until we get the data
        
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        
        activityIndicatorView.center = self.view.center
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        let manager = AFHTTPRequestOperationManager()
        
        manager.GET( "http:/graph.facebook.com/petersontimr",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                println("JSON: " + responseObject.description)
                
                if let myName = responseObject.valueForKey("name") as? String {
                    self.myNameLabel.text = myName;
                    
                    activityIndicatorView.stopAnimating()
                    
                    UIView.animateWithDuration(1.0, animations: {
                        self.myNameLabel.alpha = 1.0
                        }, completion: {
                            (value: Bool) in
                        println("Animation complete")
                    })
                }
                
                
                
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

