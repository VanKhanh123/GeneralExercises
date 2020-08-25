//
//  HomeViewController.swift
//  GeneralExercises
//
//  Created by Van Khanh Vuong on 8/21/20.
//  Copyright © 2020 IMT. All rights reserved.
//

import UIKit
import SDWebImage

enum ColorSet: String {
    case TopTabbarHomeColor
    var color: UIColor {
        guard let color = UIColor(named: self.rawValue) else {
            fatalError("Invalid Color Set name")
        }
        return color
    }
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var heightPageViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchBarNews: UISearchBar!
    @IBOutlet weak var sliderCollectionViewNews: UICollectionView!
    @IBOutlet weak var sliderPageControlNews: UIPageControl!
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var tableViewNews: UITableView!
    @IBOutlet weak var scrollViewHome: UIScrollView!
    
    var news = [News]()
    var newss = [News]()
    var timer = Timer()
    var counter = 0
    
    // Hàm lấy và giải mã JSON từ Server
    fileprivate func fetchJSON(){
        // Tao bien kieu String de luu chuoi URL
        let urlString = "http://www.json-generator.com/api/json/get/cfMHjCJUlK?indent=2"
        // Tao bien URL va luu gia tri urlString
        // Dung guard let nhu if let nhu khang dinh gia tri nay khong nil
        // Neu nhu nil thi se khong loi
        guard let url = URL(string: urlString) else { return }
        // Tien hanh lay du lieu tu url
        URLSession.shared.dataTask(with: url){ (data, _, err) in
            // Tiến hành chạy 2 luồng [Lấy dữ liệu từ Server] VS [Giải mã dữ liệu data đó]
            DispatchQueue.main.async {
                if let err = err {
                    // Nếu không lấy được dự liệu từ Server
                    print("Faild to get data form url:", err)
                    return
                }
                // Nếu lấy được dữ liệu từ Server
                guard let data = data else {return}
                
                do{
                    // Tiến hành giải mã JSON
                    let decoder = JSONDecoder()
                    // Giải mã và lưu vào mảng
                    self.news = try decoder.decode([News].self, from: data)
                    self.newss = self.news
                    // Reload lại TableView
                    self.tableViewNews.reloadData()
                    self.sliderCollectionViewNews.reloadData()
                }catch let jsonErr{
                    print("Fail to decode:", jsonErr)
                }
            }
            }.resume()
    }
    
    private func searchBarSetUp(){
        self.searchBarNews.delegate = self
        self.searchBarNews.layer.borderWidth = 1
        self.searchBarNews.layer.borderColor = ColorSet.TopTabbarHomeColor.color.cgColor
    }
    
    private func pageViewSetUp(){
        self.sliderPageControlNews.numberOfPages = news.count
        self.sliderPageControlNews.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }

    }
    
    private func tableViewSetUp(){
        self.tableViewNews.dataSource = self
        self.tableViewNews.delegate = self
    }
    
    private func collectionViewSetUp(){
        self.sliderCollectionViewNews.dataSource = self
        self.sliderCollectionViewNews.delegate = self
    }
    
    @objc func changeImage(){
        
        if counter < news.count{
            let index = IndexPath.init(item: counter, section: 0 )
            self.sliderCollectionViewNews.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            sliderPageControlNews.currentPage = counter
            counter += 1
        }else{
            counter = 0
            let index = IndexPath.init(item: counter, section: 0 )
            self.sliderCollectionViewNews.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarSetUp()
        tableViewSetUp()
        pageViewSetUp()
        collectionViewSetUp()
        fetchJSON()
    }
    
    
    
}

extension HomeViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? CustomTableViewCell
        let new = news[indexPath.row]
        cell?.imageViewNews.sd_setImage(with: URL(string: new.pictureNew), placeholderImage: UIImage(named: "placeholder.png"))
        cell?.labelTagNews.text = new.tagNews
        cell?.labelTitleNews.text = new.titleNew
        cell?.labelContentNews.text = new.contentNew
        
        return cell!
    }
    
}

extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? CustomCollectionViewCell
        let new = news[indexPath.row]
        cell?.sliderImageNews.sd_setImage(with: URL(string: new.pictureNew), placeholderImage: UIImage(named: "placeholder.png"))
        cell?.labelTag.text = new.tagNews
        cell?.labelTitleNew.text = new.titleNew
        cell?.labelTrend.text = new.trend
        return cell!
    }
    
    
    
}

extension HomeViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds
        return CGSize(width: size.width, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension HomeViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            news = newss
            self.searchBarNews.showsCancelButton = false
            heightPageViewConstraint.constant = 270
            self.pageView.isHidden = false
        }else{
            self.pageView.isHidden = true
            self.searchBarNews.showsCancelButton = true
            heightPageViewConstraint.constant = 0
            news = news.filter { (mod) -> Bool in
                return mod.tagNews.contains(searchText)
            }
        }
        
        self.tableViewNews.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBarNews.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBarNews.showsCancelButton = false
        self.searchBarNews.endEditing(true)
    }
    
}


