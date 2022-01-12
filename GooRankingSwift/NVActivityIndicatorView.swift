//
//  NVActivityIndicatorView.swift
//  GooRankingSwift
//
//  Created by cano on 2017/04/22.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import KRProgressHUD

extension NVActivityIndicatorView {
    
    open static func setup() {
        NVActivityIndicatorView.DEFAULT_TYPE = .ballScaleMultiple
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.rgba(232, 118, 131)
        KRProgressHUD.set(maskType: .black)
        KRProgressHUD.set(style: .color(background: UIColor.init(red:0,green:0,blue:0,alpha:0.7), contents: UIColor.white))
    }
    
    public static func show(message: String? = nil) {
        let data = ActivityData(message: message)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(data)
    }
    
    public static func dismiss() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    public static func showSuccess(message: String? = nil, image: String? = nil) {
        if image == nil {
            KRProgressHUD.showSuccess(message: message)
        } else {
            KRProgressHUD.show(message: message, image: UIImage(named: image!))
            let delay = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: delay) {
                KRProgressHUD.dismiss()
            }
        }
        
        // KRProgressHUD.showSuccess(message: message)
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
    public static func showError(message: String? = nil) {
        KRProgressHUD.showError(message: message)
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
