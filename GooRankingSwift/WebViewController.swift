//
//  WebViewController.swift
//  GooRankingSwift
//
//  Created by cano on 2017/04/23.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import UIKit
import FontAwesome_swift
import WebKit

class WebViewController: UIViewController {

    var url : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.nav_button(left: false)
        
        let webview = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.view.addSubview(webview)
        
        let rurl = NSURL(string: self.url)
        print(self.url)
        print(rurl)
        let urlRequest = URLRequest(url: rurl! as URL)
        webview.load(urlRequest)
    }

    
    //閉じるボタン
    func nav_button(left: Bool) {
        
        let button = UIButton.init(type: .custom)
        //let image = UIImage(named: "close_white")
        let image = UIImage.fontAwesomeIcon(name: .close, textColor: UIColor.rgba(202,206,208), size: CGSize(width: 30, height: 30))
        button.setImage(image, for: .normal)
        button.contentMode = .scaleAspectFit
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        
        //タップされたら閉じる
        button.addTarget(self, action: #selector(dismiss(button:)), for: .touchUpInside)
        
        let barButton = UIBarButtonItem.init(customView: button)
        if (left){
            navigationItem.leftBarButtonItem = barButton
        }else{
            navigationItem.rightBarButtonItem = barButton
        }
    }
    
    func dismiss(button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
