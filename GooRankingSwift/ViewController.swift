//
//  ViewController.swift
//  GooRankingSwift
//
//  Created by cano on 2017/04/21.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import GoogleMobileAds

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let array = [
    "検索",
    "ニュース",
    "スポーツ",
    "マネー",
    "ダウンロード",
    "占い",
    "旅行",
    "宿",
    "車＆バイク",
    "グルメ",
    "飲食店",
    "ビジネス",
    "学び",
    "住まい",
    "恋愛＆結婚",
    "妊娠・育児",
    "ダイエット",
    "ペット",
    "テレビ",
    "芸能",
    "映画",
    "音楽",
    "アニメ",
    "ゲーム",
    "商品トレンド",
    "書籍",
    "人気商品",
    "オークション",
    "動画",
    "教えて！goo",
    "レジャー",
    "温泉",
    "観光地",
    "地域",
    "キッズ",
    "モバイル",
    "環境",
    "ブログ",
    "ネット",
    "健康",
    "顔ちぇき!",
    "教えて！",
    "その他",
    /*
    "2010年上半期",
    "2007年間",
    "2008年間",
    "2009年間",
    "2010年間",
    "2011年間",
    */
    "恋空"];
    
    let array2 = [
    "http://ranking.goo.ne.jp/service/001/rss",
    "http://ranking.goo.ne.jp/service/004/rss",
    "http://ranking.goo.ne.jp/service/005/rss",
    "http://ranking.goo.ne.jp/service/007/rss",
    "http://ranking.goo.ne.jp/service/009/rss",
    "http://ranking.goo.ne.jp/service/010/rss",
    "http://ranking.goo.ne.jp/service/011/rss",
    "http://ranking.goo.ne.jp/service/011ya/rss",
    "http://ranking.goo.ne.jp/service/012/rss",
    "http://ranking.goo.ne.jp/service/013/rss",
    "http://ranking.goo.ne.jp/service/013sp/rss",
    "http://ranking.goo.ne.jp/service/014/rss",
    "http://ranking.goo.ne.jp/service/015/rss",
    "http://ranking.goo.ne.jp/service/016/rss",
    "http://ranking.goo.ne.jp/service/017/rss",
    "http://ranking.goo.ne.jp/service/018/rss",
    "http://ranking.goo.ne.jp/service/019/rss",
    "http://ranking.goo.ne.jp/service/020/rss",
    "http://ranking.goo.ne.jp/service/022/rss",
    "http://ranking.goo.ne.jp/service/022id/rss",
    "http://ranking.goo.ne.jp/service/024/rss",
    "http://ranking.goo.ne.jp/service/025/rss",
    "http://ranking.goo.ne.jp/service/026/rss",
    "http://ranking.goo.ne.jp/service/027/rss",
    "http://ranking.goo.ne.jp/service/028/rss",
    "http://ranking.goo.ne.jp/service/028bk/rss",
    "http://ranking.goo.ne.jp/service/028sp/rss",
    "http://ranking.goo.ne.jp/service/029/rss",
    "http://ranking.goo.ne.jp/service/030/rss",
    "http://ranking.goo.ne.jp/service/050/rss",
    "http://ranking.goo.ne.jp/service/051ki/rss",
    "http://ranking.goo.ne.jp/service/051on/rss",
    "http://ranking.goo.ne.jp/service/051sp/rss",
    "http://ranking.goo.ne.jp/service/056/rss",
    "http://ranking.goo.ne.jp/service/058/rss",
    "http://ranking.goo.ne.jp/service/065/rss",
    "http://ranking.goo.ne.jp/service/082/rss",
    "http://ranking.goo.ne.jp/service/090/rss",
    "http://ranking.goo.ne.jp/service/092/rss",
    "http://ranking.goo.ne.jp/service/099/rss",
    "http://ranking.goo.ne.jp/service/1000/rss",
    "http://ranking.goo.ne.jp/service/1002/rss",
    "http://ranking.goo.ne.jp/service/999/rss",
    /*
    "http://ranking.goo.ne.jp/service/k10/rss",
    "http://ranking.goo.ne.jp/service/n07/rss",
    "http://ranking.goo.ne.jp/service/n08/rss",
    "http://ranking.goo.ne.jp/service/n09/rss",
    "http://ranking.goo.ne.jp/service/n10/rss",
    "http://ranking.goo.ne.jp/service/n11/rss",
    */
    "http://ranking.goo.ne.jp/service/s001/rss"];
    
    let array3 = [
    "i_001.gif",
    "i_004.gif",
    "i_005.gif",
    "i_007.gif",
    "i_009.gif",
    "i_010.gif",
    "i_011.gif",
    "i_011ya.gif",
    "i_012.gif",
    "i_013.gif",
    "i_013sp.gif",
    "i_014.gif",
    "i_015.gif",
    "i_016.gif",
    "i_017.gif",
    "i_018.gif",
    "i_019.gif",
    "i_020.gif",
    "i_022.gif",
    "i_022id.gif",
    "i_024.gif",
    "i_025.gif",
    "i_026.gif",
    "i_027.gif",
    "i_028.gif",
    "i_028bk.gif",
    "i_028sp.gif",
    "i_029.gif",
    "i_030.gif",
    "i_050.gif",
    "i_051ki.gif",
    "i_051on.gif",
    "i_051sp.gif",
    "i_056.gif",
    "i_058.gif",
    "i_065.gif",
    "i_082.gif",
    "i_090.gif",
    "i_092.gif",
    "i_099.gif",
    "i_1000.gif",
    "i_050.gif",
    "i_999.gif",
    /*
    "i_k10.gif",
    "i_n07.gif",
    "i_n08.gif",
    "i_n09.gif",
    "i_n09.gif",
    "i_n09.gif",
    */
    "i_s001.gif"]
    
    let titles = ["芸能",
                  "アニメ・漫画",
                  "ゲーム",
                  "地域",
                  "言葉",
                  "ネタ・おもしろ",
                  "音楽",
                  "テレビ",
                  "映画",
                  "スポーツ",
                  "商品",
                  "生活",
                  "社会",
                  "恋愛",
                  "グルメ"]
    
    let values = [1,
                  2,
                  3,//"ゲーム",
        4,//"地域",
        5,//"言葉",
        15,//"ネタ・おもしろ",
        6,//"音楽",
        7,//"テレビ",
        8,//"映画",
        9,//"スポーツ",
        10,//"商品",
        11,//"生活",
        12,//"社会",
        13,//"恋愛",
        14,//"グルメ",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "潮流ランク"
        
        //セルの境界線を消す
        self.tableView.separatorColor = UIColor.clear
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.reloadData()
        
        NVActivityIndicatorView.setup()
        
        let bannerView = DFPBannerView(adSize: kGADAdSizeBanner
        )
        bannerView.center.x = self.view.center.x
        bannerView.center.y = self.view.frame.size.height - 50/2
        self.view.addSubview(bannerView)
        bannerView.adUnitID = "/9176203/61602"
        bannerView.rootViewController = self
        bannerView.load(DFPRequest())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return array.count
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IndexCell") as! IndexCell
        cell.accessoryType = .disclosureIndicator
        
        //cell.genreLabel?.text = array[indexPath.row]
        //cell.genreImageView.image = UIImage(named: array3[indexPath.row])
        
        cell.genreImageView.image = UIImage(named: "i_k10.gif")
        cell.genreLabel?.text = titles[indexPath.row]
        
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    
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
        NVActivityIndicatorView.show()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        //let nc = UINavigationController(rootViewController: vc)
        //self.present(nc, animated: true, completion: nil)
        //vc.url = array2[indexPath.row]
        //vc.title = array[indexPath.row]
        
        let index = values[indexPath.row]
        vc.url = "https://ranking.goo.ne.jp/category/\(index)/"
        vc.title = titles[indexPath.row]
        
        let cells = vc.url?.components(separatedBy: "/")
        //print(cells?[(cells?.count)!-2])
        vc.dir = (cells?[(cells?.count)!-2])!
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
