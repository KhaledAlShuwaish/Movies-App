//
//  ActivityIndicator.swift
//  Elm_omdb
//
//  Created by Khaled Shuwaish on 24/03/2019.
//  Copyright © 2019 Khaled Shuwaish. All rights reserved.
//

import Foundation
import UIKit


struct ActivityIndicator {
    private static var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    static func startActivityIndicator(view:UIView){
        activityIndicator.center = view.center
        activityIndicator.frame = view.frame
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .whiteLarge
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    static func stopActivityIndicator(){
        activityIndicator.stopAnimating()
    }
    
}
