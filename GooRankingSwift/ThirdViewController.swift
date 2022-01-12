//
//  ThirdViewController.swift
//  GooRankingSwift
//
//  Created by cano on 2017/04/21.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import UIKit
import Alamofire
import HTMLReader
import NVActivityIndicatorView
import Social
import GoogleMobileAds

class ThirdViewController: UIViewController {
    
    var url : String?
    var dir : String?
    
    @IBOutlet weak var tableView: UITableView!
    
    var items = [Dictionary<String, String>]()
    
    let um = UtilManager.sharedInstance()
    
    var rankingLink = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let label = UILabel(frame: CGRect(x:0, y:0, width:480, height:44))
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 2
        label.font =  UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = self.title
        self.navigationItem.titleView = label
        
        NVActivityIndicatorView.show()
        
        print(url)
        
        //セルの境界線を消す
        self.tableView.separatorColor = UIColor.clear
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        //self.tableView.rowHeight = 60
        
        let cells = self.url?.components(separatedBy: "/")
        
        um?.dir = self.dir
        um?.name = cells?[(cells?.count)!-2]
        um?.makeDir()
        um?.loadItemsList()
        
        //print(cells?[(cells?.count)!-2])
        
        if um?.itemsList != nil && (um?.itemsList.count)! > 0 {
            self.items = um?.itemsList as! [Dictionary<String, String>]
            self.tableView.reloadData()
            NVActivityIndicatorView.dismiss()
        }else{
            self.um?.clear()
            self.findLink()
            //self.loadHTML()
        }
        
        let bannerView = DFPBannerView(adSize: kGADAdSizeBanner)
        bannerView.center.x = self.view.center.x
        bannerView.center.y = self.view.frame.size.height - 50/2
        self.view.addSubview(bannerView)
        bannerView.adUnitID = "/9176203/61602"
        bannerView.rootViewController = self
        bannerView.load(DFPRequest())
    }
    
    func findLink() {
        self.items = [Dictionary<String, String>]()
        let rurl = URL(string: self.url!)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: rurl)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        //let paramString = "data=Hello"
        //request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            guard let data = data, let _ = response, error == nil else {
                print("error")
                NVActivityIndicatorView.dismiss()
                return
            }
            
            //var index = 0
            // Many columns has newlines, tabs or spaces for their
            // textual content. Here, define a character set to trim
            // them off
            //let spaceCharacterSet = CharacterSet(charactersIn: "\n\t ")
            
            let html = HTMLDocument(data: data, contentTypeHeader: "text/html; charset=utf-8")
            for node in html.nodes(matchingSelector: ".btn-default") {
                
                let link = node.nodes(matchingSelector: "a").map { $0.attributes["href"]}[0]
                self.rankingLink = "https://ranking.goo.ne.jp/" + link!
            }
            DispatchQueue.main.async {
                //self.um?.saveItemsList()
                //self.tableView.reloadData()
                //NVActivityIndicatorView.dismiss()
                self.loadHTML()
            }
            // It's better if you put a breakpoint on the line below.
            // Swift 3's logging is too verbose at the moment.
            //print(self.result["row 1"]!["Unclaimed Top Prizes"])
        }
        
        task.resume()
    }
    
    func loadHTML() {
        if self.rankingLink == "" {
            NVActivityIndicatorView.dismiss()
            return
        }
        self.items = [Dictionary<String, String>]()
        let rurl = URL(string: self.rankingLink)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: rurl)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        //let paramString = "data=Hello"
        //request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            guard let data = data, let _ = response, error == nil else {
                print("error")
                NVActivityIndicatorView.dismiss()
                return
            }
            
            //var index = 0
            // Many columns has newlines, tabs or spaces for their
            // textual content. Here, define a character set to trim
            // them off
            //let spaceCharacterSet = CharacterSet(charactersIn: "\n\t ")
            
            let html = HTMLDocument(data: data, contentTypeHeader: "text/html; charset=utf-8")
            for node in html.nodes(matchingSelector: ".ranking-list") {
                //print(node)
                let columns = node.nodes(matchingSelector: "li")
                //print(columns)
                //let topPrices = columns[3].nodes(matchingSelector: "p").map { $0.textContent }
                //let unclaimedTopPrices = columns[4].nodes(matchingSelector: "p").map { $0.textContent }
                
                for column in columns {
                    //print(column.textContent)
                    let order = column.nodes(matchingSelector: "div").map { $0.textContent.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\t", with: "").replacingOccurrences(of: "\n", with: "") }[0]
                    let title = column.nodes(matchingSelector: "h2").map { $0.textContent.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\t", with: "").replacingOccurrences(of: "\n", with: "") }[0]
                    
                    
                    let desc = column.nodes(matchingSelector: "p").map { $0.textContent.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\t", with: "").replacingOccurrences(of: "\n", with: "") }[0]
                    
                    print(order); print(title); print(desc)
                    
                    var dic = Dictionary<String, String>()
                    dic["title"] = title;
                    dic["order"] = order;
                    dic["description"] = desc;
                    
                    let str = column.textContent.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\t", with: "").replacingOccurrences(of: "\n", with: "")
                    //print(str)
                    dic["str"] = str;
                    self.items.append(dic)
                    self.um?.addItemsList(dic)
                }
            }
            DispatchQueue.main.async {
                self.um?.saveItemsList()
                self.tableView.reloadData()
                NVActivityIndicatorView.dismiss()
            }
            // It's better if you put a breakpoint on the line below.
            // Swift 3's logging is too verbose at the moment.
            //print(self.result["row 1"]!["Unclaimed Top Prizes"])
        }
        
        task.resume()
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



extension ThirdViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "MyCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdTableViewCell") as! ThirdTableViewCell
        //cell.accessoryType = .disclosureIndicator
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16.0)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = items[indexPath.row]["order"]! + "  " + items[indexPath.row]["title"]!
        
        //cell.textLabel?.text = items[indexPath.row]["title"]!
        //cell.textLabel?.text = items[indexPath.row]["str"]
        
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12.0)
        cell.detailTextLabel?.text = items[indexPath.row]["description"]
        return cell
    }
}

extension ThirdViewController : UITableViewDelegate {
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
 
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        //return UITableViewAutomaticDimension
        return 100
    }
 */
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.section) : \(indexPath.row)")
        
        let dic = self.items[indexPath.row]
        
        let actionSheet = UIAlertController(title: "", message: dic["title"], preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let action1 = UIAlertAction(title: "Google検索", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            //print("アクション１をタップした時の処理")
            self.presentWebView(indexPath)
        })
        
        let action2 = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            //print("アクション２をタップした時の処理")
            self.postTwitter(indexPath)
        })
        let action3 = UIAlertAction(title: "FaceBook", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            //print("アクション２をタップした時の処理")
            self.postFaceBook(indexPath)
        })
        
        let cancel = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler: {
            (action: UIAlertAction!) in
            //print("キャンセルをタップした時の処理")
        })
        
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.addAction(action3)
        actionSheet.addAction(cancel)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func postTwitter(_ indexPath:IndexPath) {
        let dic = self.items[indexPath.row]
        let text = self.title! + "  " + dic["order"]! + " " + dic["title"]! +  " #潮流ランク"
        
        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        vc?.setInitialText(text)
        present(vc!, animated: true, completion: nil)
    }
    
    func postFaceBook(_ indexPath:IndexPath) {
        let dic = self.items[indexPath.row]
        let text = self.title! + "  " + dic["order"]! + " " + dic["title"]! +  " #潮流ランク"
        
        let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        vc?.setInitialText(text)
        present(vc!, animated: true, completion: nil)
    }
    
    func presentWebView(_ indexPath:IndexPath) {
        
        let dic = self.items[indexPath.row]
        print(dic)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.title = dic["title"]
        vc.url = "https://www.google.co.jp/search?q=" + dic["title"]!.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        //stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        let nc = UINavigationController(rootViewController: vc)
        self.present(nc, animated: true, completion: nil)
    }
}

