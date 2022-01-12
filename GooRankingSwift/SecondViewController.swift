//
//  SecondViewController.swift
//  GooRankingSwift
//
//  Created by cano on 2017/04/21.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import UIKit
import MWFeedParser
import NVActivityIndicatorView
import Alamofire
import AlamofireRSSParser
import HTMLReader
import GoogleMobileAds
import GoogleMobileAds
class SecondViewController: UIViewController,  MWFeedParserDelegate {
    
    var url : String?
    var dir : String?
    //var title : String?
    //var items = [MWFeedItem]()
    var items = [Dictionary<String, String>]()
    
    @IBOutlet weak var tableView: UITableView!
    
    let um = UtilManager.sharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NVActivityIndicatorView.show()
        
        //セルの境界線を消す
        self.tableView.separatorColor = UIColor.clear
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        print(url ?? "")
        
        um?.dir = self.dir
        um?.name = self.dir
        um?.makeDir()
        um?.loadItemsList()
        //um?.clearItemsList()
        //print("um?.itemsList.count")
        //print( um?.itemsList.count )
        
        //request()
        if um?.itemsList != nil && (um?.itemsList.count)! > 0 {
            self.items = um?.itemsList as! [Dictionary<String, String>]
            self.tableView.reloadData()
            NVActivityIndicatorView.dismiss()
        }else{
            //self.rssRequest(url!)
            self.um?.clear()
            self.loadHTML()
        }
        
        let bannerView = DFPBannerView(adSize: kGADAdSizeBanner)
        bannerView.center.x = self.view.center.x
        bannerView.center.y = self.view.frame.size.height - 50/2
        self.view.addSubview(bannerView)
        bannerView.adUnitID = "/9176203/61602"
        bannerView.rootViewController = self
        bannerView.load(DFPRequest())
    }
    
    func loadHTML() {
        self.items = [Dictionary<String, String>]()
        let rurl = URL(string: self.url!)!
        print("self.url : \(self.url!)")
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: rurl)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        //let paramString = "data=Hello"
        //request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            guard let data = data, let _ = response, error == nil else {
                print("error")
                return
            }
            
            //var index = 0
            // Many columns has newlines, tabs or spaces for their
            // textual content. Here, define a character set to trim
            // them off
            //let spaceCharacterSet = CharacterSet(charactersIn: "\n\t ")
            
            let html = HTMLDocument(data: data, contentTypeHeader: "text/html; charset=utf-8")
            //for node in html.nodes(matchingSelector: ".ranking-list") {
            for node in html.nodes(matchingSelector: ".article-archive") {
                //print(node)
                let columns = node.nodes(matchingSelector: "li")
                //print(columns)
                //let topPrices = columns[3].nodes(matchingSelector: "p").map { $0.textContent }
                //let unclaimedTopPrices = columns[4].nodes(matchingSelector: "p").map { $0.textContent }
                
                for column in columns {
                    //print(column.textContent)
                    let link = column.nodes(matchingSelector: "a").map { $0.attributes["href"]}[0]//{ $0.textContent.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\t", with: "").replacingOccurrences(of: "\n", with: "") }[0]
                    
                    //let order = column.nodes(matchingSelector: "p").map { $0.textContent.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\t", with: "").replacingOccurrences(of: "\n", with: "") }[0]
                    let title = column.nodes(matchingSelector: "h2").map { $0.textContent.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\t", with: "").replacingOccurrences(of: "\n", with: "") }[0]
                    
                    /*
                     let descArray = column.nodes(matchingSelector: "p").map { $0.textContent.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\t", with: "").replacingOccurrences(of: "\n", with: "") }
                     
                     var desc = ""
                     if descArray.count > 0 {
                     desc = descArray[0]
                     }
                     */
                    let desc = column.nodes(matchingSelector: "p").map { $0.textContent.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\t", with: "").replacingOccurrences(of: "\n", with: "") }[0]
                    
                    //print(order);
                    print(title);
                    //print(desc)
                    print("\nlink : \(link)\n")
                    var dic = Dictionary<String, String>()
                    dic["title"] = title;
                    //dic["order"] = order;
                    dic["description"] = desc;
                    dic["link"] = link;
                    
                    //let str = column.textContent.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\t", with: "").replacingOccurrences(of: "\n", with: "")
                    //print(str)
                    //dic["str"] = str;
                    print(dic)
                    self.items.append(dic)
                    print("itemsList : \(self.um?.itemsList)")
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
    
    func rssRequest(_ url:String){
        self.items = [Dictionary<String, String>]()
        Alamofire.request(url).responseRSS() { (response) -> Void in
            if let feed: RSSFeed = response.result.value {
                //do something with your new RSSFeed object!
                for item in feed.items {
                    //print(item)
                    
                    var dic = Dictionary<String, String>()
                    dic["title"] = item.title;
                    dic["link"] = item.link;
                    dic["description"] = item.itemDescription;
                    
                    self.items.append(dic)
                    self.um?.addItemsList(dic)
                }
                self.um?.saveItemsList()
                self.tableView.reloadData()
                NVActivityIndicatorView.dismiss()
            }
        }
    }
    
    /*
    func request() {
        let URL = NSURL(string: self.url!)
        let feedParser = MWFeedParser(feedURL: URL! as URL);
        feedParser?.delegate = self
        feedParser?.parse()
        self.tableView.reloadData()
        NVActivityIndicatorView.dismiss()
    }
    
    func feedParserDidStart(_ parser: MWFeedParser) {
        //SVProgressHUD.show()
        self.items = [MWFeedItem]()
    }
    
    func feedParserDidFinish(_ parser: MWFeedParser) {
        //SVProgressHUD.dismiss()
        self.tableView.reloadData()
        um?.saveItemsList()
        
        //print(self.items)
    }
    
    
    func feedParser(_ parser: MWFeedParser, didParseFeedInfo info: MWFeedInfo) {
        //print(info)
        self.title = info.title
    }
    
    func feedParser(_ parser: MWFeedParser, didParseFeedItem item: MWFeedItem) {
        //print(item)
        self.items.append(item)
        
        let currentItem = Item()
        currentItem.title = item.title;
        currentItem.rdf = item.link; //[urls objectAtIndex:(1)];
        currentItem.description = "";
        currentItem.pubDate = "";
        um?.addItemsList(currentItem)
        
    }
    */
    
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

extension SecondViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as! SecondTableViewCell
        cell.accessoryType = .disclosureIndicator
        
        cell.textLabel?.text = items[indexPath.row]["title"]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        
        //[cell.textLabel setFont:[UIFont systemFontOfSize:[UIFont smallSystemFontSize]]];
        
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}

extension SecondViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.section) : \(indexPath.row)")
        
        NVActivityIndicatorView.setup()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        //let nc = UINavigationController(rootViewController: vc)
        //self.present(nc, animated: true, completion: nil)
        //vc.url = items[indexPath.row]["link"]
        
        vc.url = "https://ranking.goo.ne.jp" + items[indexPath.row]["link"]!
        vc.title = items[indexPath.row]["title"]
        
        //let cells = vc.url?.components(separatedBy: "/")
        //print(cells?[(cells?.count)!-2])
        vc.dir = self.dir
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

